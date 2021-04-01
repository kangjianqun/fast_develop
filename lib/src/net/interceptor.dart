import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/widgets.dart';
import 'package:fast_mvvm/fast_mvvm.dart';

import '../../fast_develop.dart';

typedef ApiInterceptorOnRequest = Future<RequestOptions> Function(
    RequestOptions options, String baseUrl);

void initFastDevelopOfApiInterceptor(
    ApiInterceptorOnRequest? onRequest, bool? extraSaveJson) {
  if (onRequest != null) _onRequest = onRequest;
  if (extraSaveJson != null) ApiInterceptor.extraSaveJson = extraSaveJson;
}

/// 配置[headers] 等
ApiInterceptorOnRequest _onRequest = (options, String baseUrl) async {
  var version = await PlatformUtils.getAppVersion();
  options.headers.putIfAbsent("version", () => "v$version");
  if (BoolUtil.parse(options.extra[keyShowDialog])) {
//      LogUtil.printLog("showDialog");
    try {
      DialogSimple.show(options.uri.toString());
    } catch (e) {}
  }
  LogUtil.printLog(options.uri);
  return options;
};

///  API
class ApiInterceptor extends InterceptorsWrapper {
  ApiInterceptor(this.baseUrl);

  final String baseUrl;

  /// 是否在[Response]的extra保存原始json
  static bool extraSaveJson = true;

  @override
  onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    options.baseUrl = baseUrl;
    await _onRequest(options, baseUrl);
  }

  @override
  onResponse(Response response, ResponseInterceptorHandler handler) async {
    bool dialog = BoolUtil.parse(response.requestOptions.extra[keyShowDialog]);
    if (dialog) {
//      LogUtil.printLog("closeDialog");
      bool allClear =
          BoolUtil.parse(response.requestOptions?.extra[keyDialogAllClear]);
      DialogSimple.close(response.requestOptions.uri.toString(),
          clear: allClear);
    }

    var disposeJson =
        BoolUtil.parse(response.requestOptions.extra[keyDisposeJson]);
    response.extra.update(keyDisposeJson, (v) => disposeJson,
        ifAbsent: () => disposeJson);
    if (disposeJson) {
      response.extra.update(keyResult, (v) => true, ifAbsent: () => true);
      return handler.resolve(response);
    } else {
      Map<String, dynamic> jsonData = {};
      try {
        try {
          jsonData = json.decode(response.data);
        } catch (e) {
          if (response.data?.runtimeType == String) {
            LogUtil.printLog("---response---> data: ${response.data}");
            int startIndex = (response.data as String).indexOf("{");
            int endIndex = (response.data as String).lastIndexOf("}");
            String data =
                (response.data as String).substring(startIndex, endIndex + 1);
            jsonData = json.decode(data);
            response.data = data;
          }
        }
      } catch (e) {
        jsonData["datas"] = response.data;
        jsonData["code"] = response.statusCode;
        debugPrint(response.data);
      }
      _RespData respData = _RespData.fromJson(jsonData);

      response.data = respData.data;
      if (extraSaveJson)
        response.extra.update(keyJson, (v) => respData.json,
            ifAbsent: () => respData.json);
      response.extra.update(keyIsMore, (v) => respData.isMore,
          ifAbsent: () => respData.isMore);
      response.extra.update(keyTotalPage, (v) => respData.totalPageNum,
          ifAbsent: () => respData.totalPageNum);
      response.extra
          .update(keyHint, (v) => respData.hint, ifAbsent: () => respData.hint);
      response.extra.update(keyResult, (v) => respData.result,
          ifAbsent: () => respData.result);
      response.extra.update(keyExtendData, (v) => respData.getExtend(),
          ifAbsent: () => respData.getExtend());

      if (!respData.result) {
        response.statusCode = respData.code;
        LogUtil.printLog('---api-response--->error---->$respData');
        if (BoolUtil.parse(response.requestOptions.extra[keyShowError]) &&
            respData.error.en) {
          showToast(respData.error);
        }

        ///需要登录
        if (respData.login.en && respData.login == "0") {
          throw const UnAuthorizedException();
        }
      }

      if (BoolUtil.parse(response.requestOptions.extra[keyShowHint]) &&
          respData.hint.en) {
        showToast(respData.error);
      }
      return handler.resolve(response);
    }
  }

  @override
  void onError(DioError err, ErrorInterceptorHandler handler) {
    DialogSimple.close("", clear: true);
    LogUtil.printLog(err.toString());
    LogUtil.printLog('---api-response--->error---->$err');
    super.onError(err, handler);
  }
}

typedef ProcessingExtend = Map<String, dynamic> Function(
    Map<String, dynamic> json);

void initFastDevelopOfRespData(ProcessingExtend? processingExtend) {
  if (processingExtend != null) _RespData.processingExtend = processingExtend;
}

class _RespData {
  _RespData({this.data, this.code});

  Map<String, dynamic> json;
  dynamic data;
  int code = 0;
  String login;
  bool isMore = false;
  int totalPageNum = 1;
  String error;
  String hint;

  /// 处理扩展参数
  static ProcessingExtend processingExtend;

  /// 下一步路由路径
  String next;

  /// 默认未空
  String back;

  bool get result => 200 == code;

  Map<String, dynamic> getExtend() {
    var data = Map<String, dynamic>();
    if (processingExtend != null) data = processingExtend(json);
    return data;
  }

  @override
  String toString() {
    if (json == null)
      return "";
    else
      return json.toString();
  }

  _RespData.fromJson(Map<String, dynamic> json) {
    this.json = json;
    code = json['code'];
    data = json['datas'];
    login = json['login'];
    hint = json['success'];
    next = json['next'];
    back = json['back'];
    error =
        data != null && data is Map ? valueByType(data['error'], String) : null;
    isMore = json['hasmore'] ?? false;
    totalPageNum = json['page_total'] ?? 1;

    if (data == null || data is String && (data as String).e)
      data = Map<String, dynamic>();
  }
}
