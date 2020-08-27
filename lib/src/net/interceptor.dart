import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/widgets.dart';
import 'package:fast_mvvm/fast_mvvm.dart';

import '../../fast_develop.dart';

///  API
class ApiInterceptor extends InterceptorsWrapper {
  ApiInterceptor(this.baseUrl);

  final String baseUrl;

  @override
  onRequest(RequestOptions options) async {
    var version = await PlatformUtils.getAppVersion();
    options.baseUrl = baseUrl;
    options.headers.putIfAbsent("version", () => "v$version");
    if (BoolUtil.parse(options.extra[keyShowDialog])) {
//      LogUtil.printLog("showDialog");
      try {
        DialogSimple.show(options.uri.toString());
      } catch (e) {}
    }
    LogUtil.printLog(options.uri);
    return options;
  }

  @override
  onResponse(Response response) async {
    bool dialog = BoolUtil.parse(response.request.extra[keyShowDialog]);
    if (dialog) {
//      LogUtil.printLog("closeDialog");
      bool allClear = BoolUtil.parse(response.request.extra[keyDialogAllClear]);
      DialogSimple.close(response.request.uri.toString(), clear: allClear);
    }

    var disposeJson = BoolUtil.parse(response.request.extra[keyDisposeJson]);
    response.extra.update(keyDisposeJson, (v) => disposeJson,
        ifAbsent: () => disposeJson);
    if (disposeJson) {
      response.extra.update(keyResult, (v) => true, ifAbsent: () => true);
      return Http(baseUrl).resolve(response);
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
        if (BoolUtil.parse(response.request.extra[keyShowError]) &&
            respData.error.en) {
          showToast(respData.error);
        }

        ///需要登录
        if (respData.login.en && respData.login == "0") {
          throw const UnAuthorizedException();
        }
      }

      if (BoolUtil.parse(response.request.extra[keyShowHint]) &&
          respData.hint.en) {
        showToast(respData.error);
      }
      return Http(baseUrl).resolve(response);
    }
  }

  @override
  Future onError(DioError err) {
    DialogSimple.close("", clear: true);
    LogUtil.printLog(err.toString());
    LogUtil.printLog('---api-response--->error---->$err');
    return super.onError(err);
  }
}

class _RespData {
  dynamic data;
  int code = 0;
  String login;
  bool isMore = false;
  int totalPageNum = 1;
  String error;
  String hint;

  /// 下一步路由路径
  String next;

  /// 默认未空
  String back;

  bool get result => 200 == code;

  Map<String, dynamic> getExtend() {
    if (next.e) return null;

    var data = Map<String, dynamic>();
    data["next"] = next;
    data["back"] = back;
    data["error"] = error;
    return data;
  }

  _RespData({this.data, this.code});

  @override
  String toString() {
    return 'RespData{status: $code, datas: $data}';
  }

  _RespData.fromJson(Map<String, dynamic> json) {
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
