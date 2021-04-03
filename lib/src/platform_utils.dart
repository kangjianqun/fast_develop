import 'dart:async';

import 'package:device_info/device_info.dart';
import 'package:package_info/package_info.dart';
import 'package:universal_io/io.dart';
import '../fast_develop.dart';

/// 是否资源版本  判断正式与测试
const bool inProduction = bool.fromEnvironment("dart.vm.product");

class PlatformUtils {
  static String getPlatform() => Platform.operatingSystem;

  static late String? version;

  static bool isAndroid() => Platform.isAndroid;

  static bool isIOS() => Platform.isIOS;

  static bool isWeb() {
    return Platform.operatingSystem == "web";
  }

  static late String? _type;

  static String type() {
    if (StringUtil.isEmpty(_type)) {
      init();
    }
    return _type!;
  }

  static init() {
    if (Platform.isAndroid) {
      _type = "android";
    } else if (Platform.isIOS) {
      _type = "ios";
    } else {
      _type = "web";
    }
  }

  static Future<PackageInfo> getAppPackageInfo() {
    return PackageInfo.fromPlatform();
  }

  static Future<String> getAppVersion() async {
    if (version!.en) return version!;
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    version = packageInfo.version;
    return version!;
  }

  static Future getDeviceInfo() async {
    DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
    if (isAndroid()) {
      return await deviceInfo.androidInfo;
    } else if (isIOS()) {
      return await deviceInfo.iosInfo;
    } else {
      return null;
    }
  }
}
