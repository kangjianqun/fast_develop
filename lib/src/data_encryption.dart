import 'dart:convert';
import 'package:crypto/crypto.dart';
import 'package:convert/convert.dart';

String generateMD5(String key) =>
    hex.encode(md5.convert(utf8.encode(key)).bytes);

/// Base64加密
String encodeBase64(String data) {
  var content = utf8.encode(data);
  var digest = base64Encode(content);
  return digest;
}

/// Base64解密
String decodeBase64(String data) {
  return String.fromCharCodes(base64Decode(data));
}
