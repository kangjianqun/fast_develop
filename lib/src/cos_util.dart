// import 'dart:convert';
// import 'dart:io';
// import 'package:fast_develop/fast_develop.dart';
// import 'package:http/http.dart' as http;
//
// import 'package:crypto/crypto.dart';
//
// class CosUtil {
//   static final int signExpireTimeInSeconds = 10;
//
//   static late String _secretId;
//   static late String _secretKey;
//
//   /// xxx-xxxxxx.cos.ap-chengdu.myqcloud.com 主机地址
//   static late String _bucketHost;
//
//   static CosUtil? _cos;
//
//   CosUtil._();
//
//   static void init(String secretId, String secretKey, String bucketHost) {
//     _secretId = secretId;
//     _secretKey = secretKey;
//     _bucketHost = bucketHost;
//   }
//
//   static CosUtil get() {
//     if (_cos == null) {
//       _cos = CosUtil._();
//     }
//     return _cos!;
//   }
//
//   upImg(File f, {String? filename}) async {
//     filename ??= f.path.substring(f.path.lastIndexOf("/") + 1);
//     var sign = buildHeaders(filename);
//     List<int> bytes = await f.readAsBytes();
//     var url = Uri.parse('https://example.com/whatsit/create');
//     http.put(url, headers: sign, body: bytes).then((response) {
//       print(response);
//     });
//   }
//
//   Map<String, String> buildHeaders(String url, {String httpMethod = "get"}) {
//     Map<String, String> headers = Map();
//     headers['HOST'] = _bucketHost;
//     headers['Authorization'] = _auth(httpMethod, url, headers: headers);
//     LogUtil.printLog(headers);
//     return headers;
//   }
//
//   String _auth(String httpMethod, String httpUrl,
//       {Map<String, String>? headers, Map<String, String>? params}) {
//     headers = headers ?? {};
//     params = params ?? {};
//
//     int currentTimestamp = DateTime.now().millisecondsSinceEpoch ~/ 1000;
//     var keyTime =
//         '$currentTimestamp;${currentTimestamp + signExpireTimeInSeconds}';
//     headers = headers.map((key, value) => MapEntry(key.toLowerCase(), value));
//     params = params.map((key, value) => MapEntry(key.toLowerCase(), value));
//     List<String> headerKeys = headers.keys.toList();
//     headerKeys.sort();
//     var headerList = headerKeys.join(';');
//     var httpHeaders = headerKeys
//         .map((item) => '$item=${Uri.encodeFull(headers![item]!)}')
//         .join('&');
//
//     List<String> paramKeys = params.keys.toList();
//     paramKeys.sort();
//     var urlParamList = paramKeys.join(';');
//     var httpParameters = paramKeys
//         .map((item) => '$item=${Uri.encodeFull(params![item]!)}')
//         .join('&');
//
//     var signKey =
//         new Hmac(sha1, utf8.encode(_secretKey)).convert(utf8.encode(keyTime));
//     String httpString =
//         '${httpMethod.toLowerCase()}\n$httpUrl\n$httpParameters\n$httpHeaders\n';
//     var httpStringData = sha1.convert(utf8.encode(httpString));
//     String stringToSign = 'sha1\n$keyTime\n$httpStringData\n';
//     var signature = new Hmac(sha1, utf8.encode(signKey.toString()))
//         .convert(utf8.encode(stringToSign));
//
//     String auth =
//         'q-sign-algorithm=sha1&q-ak=$_secretId&q-sign-time=$keyTime&q-key-time=$keyTime&q-header-list=$headerList&q-url-param-list=$urlParamList&q-signature=$signature';
//     return auth;
//   }
// }
