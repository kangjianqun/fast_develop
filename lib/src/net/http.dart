import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:dio/native_imp.dart';
import 'package:flutter/foundation.dart';
import 'package:fast_mvvm/fast_mvvm.dart';
import '../../fast_develop.dart';

import 'interceptor.dart';

String keyShowDialog = "key_show_dialog";
String keyDialogAllClear = "key_dialog_clear";
String keyShowError = "key_show_error";
String keyShowHint = "key_show_hint";
String keyDisposeJson = "key_disponse_json";

String keyIsMore = "key_isMore";
String keyJson = "key_json";
String keyExtendData = "key_extendData";
String keyTotalPage = "key_totalPage";
String keyHint = "key_hint";
String keyResult = "key_result";

typedef DioInit = void Function(Dio dio, String baseUrl);

/// [parseJson]必须是顶层函数
void initFastDevelopOfHttp(
  BaseOptions? baseOptions,
  JsonDecodeCallback? parseJson,
  DioInit? dioInit,
) {
  if (baseOptions != null) _baseOptions = baseOptions;
  if (parseJson != null) _parseJson = parseJson;
}

BaseOptions _baseOptions =
    BaseOptions(connectTimeout: 1000 * 60, receiveTimeout: 1000 * 60);

/// 必须是顶层函数
JsonDecodeCallback _parseJson = (String text) {
  return compute(jsonDecode(text), text);
};

/// 初始化 Dio
DioInit _dioInit = (Dio dio, String baseUrl) {
  dio.interceptors.add(ApiInterceptor(baseUrl));
};

class Http extends DioForNative {
  static late Http? instance;

  factory Http(String baseUrl, {bool isInstance = true}) {
    if (!isInstance) {
      return Http._(_baseOptions).._init(baseUrl);
    }

    if (instance == null) {
      instance = Http._(_baseOptions).._init(baseUrl);
    }
    return instance!;
  }

  Http._([BaseOptions? options]) : super(options);

  /// 初始化 加入app通用处理
  _init(String baseUrl, [BaseOptions? options]) {
    (transformer as DefaultTransformer).jsonDecodeCallback = _parseJson;
    _dioInit(this, baseUrl);
  }
}

enum RequestType { Get, Post }

typedef RequestSucceed = void Function(Response);
typedef RequestFailure = void Function(DioError);

Future<void> requestHttp(
  RequestType type,
  Http dio,
  String url, {
  Map<String, dynamic>? p,
  bool isShowDialog = false,
  bool dialogAllClear = false,
  bool isShowError = true,
  bool isShowHint = true,
  bool disposeJson = false,
  Function? notLogin,
  required RequestSucceed succeed,
  RequestFailure? failure,
}) async {
  Response response;
  dio.options.extra.update(keyShowDialog, (item) => isShowDialog,
      ifAbsent: () => isShowDialog);
  dio.options.extra.update(keyDialogAllClear, (item) => dialogAllClear,
      ifAbsent: () => dialogAllClear);
  dio.options.extra
      .update(keyShowError, (item) => isShowError, ifAbsent: () => isShowError);
  dio.options.extra
      .update(keyShowHint, (item) => isShowHint, ifAbsent: () => isShowHint);
  dio.options.extra.update(keyDisposeJson, (item) => disposeJson,
      ifAbsent: () => disposeJson);
  try {
    switch (type) {
      case RequestType.Get:
        response = await dio.get(url, queryParameters: p);
        break;
      case RequestType.Post:
        var data = p != null ? FormData.fromMap(p) : null;
        response = await dio.post(url, data: data);
        break;
    }
    succeed(response);
  } on DioError catch (e) {
//    LogUtil.printLog("UnAuthorizedException");
    if (e.error is UnAuthorizedException) {
      if (notLogin != null) notLogin();
    } else {
      LogUtil.printLog("error");
      if (failure != null) failure(e);
    }
  }
}
