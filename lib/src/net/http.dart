import 'package:dio/dio.dart';
import 'package:dio/native_imp.dart';
import 'package:fast_mvvm/fast_mvvm.dart';
import '../../fast_develop.dart';

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

bool postDataIsFromData = true;

typedef DioInit = void Function(Dio dio, String baseUrl);
JsonDecodeCallback? jsonDecodeCallback;

/// [parseJson]必须是顶层函数
void initFastDevelopOfHttp(
  BaseOptions? baseOptions,
  JsonDecodeCallback? parseJson,
  DioInit? dioInit,
) {
  if (baseOptions != null) _baseOptions = baseOptions;
  if (parseJson != null) jsonDecodeCallback = parseJson;
}

BaseOptions _baseOptions =
    BaseOptions(connectTimeout: 1000 * 60, receiveTimeout: 1000 * 60);

/// 初始化 Dio
DioInit _dioInit = (Dio dio, String baseUrl) {
  dio.interceptors.add(ApiInterceptor(baseUrl));
};

class Http extends DioForNative {
  static Http? instance;

  factory Http(String baseUrl,
      {bool isInstance = true, BaseOptions? options, String? contentType}) {
    var o = options ?? _baseOptions;
    if (!isInstance) return Http._(o).._init(baseUrl);
    instance ??= Http._(o).._init(baseUrl);
    if (contentType.en) instance!.options.contentType = contentType;
    return instance!;
  }

  Http._([BaseOptions? options]) : super(options);

  /// 初始化 加入app通用处理
  _init(String baseUrl) {
    if (jsonDecodeCallback != null) {
      (transformer as DefaultTransformer).jsonDecodeCallback =
          jsonDecodeCallback;
    }
    _dioInit(this, baseUrl);
  }
}

enum RequestType { get, post }

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
  bool? isFromData,
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
      case RequestType.get:
        response = await dio.get(url, queryParameters: p);
        break;
      case RequestType.post:
        var data = isFromData ?? postDataIsFromData
            ? (p != null ? FormData.fromMap(p) : null)
            : p;
        response = await dio.post(url, data: data);
        break;
    }
    succeed(response);
  } on DioError catch (e) {
//    LogUtil.printLog("UnAuthorizedException");
    if (e.error is UnAuthorizedException) {
      if (notLogin != null) notLogin();
    } else {
      printLog("error");
      if (failure != null) failure(e);
    }
  }
}
