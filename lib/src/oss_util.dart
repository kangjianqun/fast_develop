import 'dart:convert';
import 'package:crypto/crypto.dart';
import 'dart:math';

class OssUtil {
  static String accessKeyId =
      'LTAI4Fmtrf6ziNij8wAn75xs'; //临时用户的AccessKeyId，通过后台接口动态获取
  static String accessKeySecret =
      'qmtlepFlkKQbwSMwgN9MgABTU6KdDB'; //临时用户的accessKeySecret，通过后台接口动态获取
  static String stsToken = ""; //临时用户鉴权Token,临时用户认证时必传，通过后台接口动态获取

  //验证文本域
  static String _policyText =
      '{"expiration": "2069-05-22T03:15:00.000Z","conditions": [["content-length-range", 0, 1048576000]]}'; //UTC时间+8=北京时间

  //进行utf8编码
  static List<int> _policyTextUtf8 = utf8.encode(_policyText);
  //进行base64编码
  static String policy = base64.encode(_policyTextUtf8);
  //再次进行utf8编码
  static List<int> _policyUtf8 = utf8.encode(policy);

  // 工厂模式
  factory OssUtil() => _getInstance();

  static OssUtil get instance => _getInstance();
  static OssUtil _instance;

  OssUtil._internal();

  static OssUtil _getInstance() {
    if (_instance == null) {
      _instance = OssUtil._internal();
    }
    return _instance;
  }

  /*
  *获取signature签名参数
  */
  String getSignature(String _accessKeySecret) {
    //进行utf8 编码
    List<int> _accessKeySecretUtf8 = utf8.encode(_accessKeySecret);

    //通过hmac,使用sha1进行加密
    List<int> signaturePre =
        Hmac(sha1, _accessKeySecretUtf8).convert(_policyUtf8).bytes;

    //最后一步，将上述所得进行base64 编码
    String signature = base64.encode(signaturePre);
    return signature;
  }

  /// 生成上传上传图片的名称 ,获得的格式:photo/20171027175940_oCiobK
  /// 可以定义上传的路径uploadPath(Oss中保存文件夹的名称)
  /// @param uploadPath 上传的路径 如：/photo
  /// @return photo/20171027175940_oCiobK
  String getImageUploadName(String uploadPath, String filePath) {
    String imageMame = "";
    var timestamp = DateTime.now().millisecondsSinceEpoch;
    imageMame = timestamp.toString() + "_" + getRandom(6);
    if (uploadPath != null && uploadPath.isNotEmpty) {
      imageMame = uploadPath + "/" + imageMame;
    }
    String imageType =
        filePath?.substring(filePath?.lastIndexOf("."), filePath?.length);
    return imageMame + imageType;
  }

  /*
  * 生成固定长度的随机字符串
  * */
  String getRandom(int num) {
    String alphabet = 'qwertyuiopasdfghjklzxcvbnmQWERTYUIOPASDFGHJKLZXCVBNM';
    String left = '';
    for (var i = 0; i < num; i++) {
//    right = right + (min + (Random().nextInt(max - min))).toString();
      left = left + alphabet[Random().nextInt(alphabet.length)];
    }
    return left;
  }
}
