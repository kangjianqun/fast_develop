import 'package:flutter/cupertino.dart';
import 'package:localstorage/localstorage.dart';

class StorageManager {
  /// 初始化必备操作 eg:user数据
  static late LocalStorage? _localStorage;

  /// 必备数据的初始化操作
  ///
  /// 由于是同步操作会导致阻塞,所以应尽量减少存储容量
  static init() async {
    if (_localStorage != null) return;
    debugPrint('StorageManager--init');
    _localStorage ??= LocalStorage('LocalStorage.json');
    await _localStorage!.ready;
    debugPrint('StorageManager--end');
  }

  static Future<void> setItem(String key, value) {
    if (_localStorage == null) return Future.value();
    return _localStorage!.setItem(key, value);
  }

  static getItem(String key) {
    if (_localStorage == null) return null;
    return _localStorage!.getItem(key);
  }

  static Future<void> deleteItem(String key) {
    return _localStorage!.deleteItem(key);
  }
}
