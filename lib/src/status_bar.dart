import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../fast_develop.dart';

/// 还原标题栏
statusBarReduction() {
  if (CConfig.platformBrightness == Brightness.dark) {
    statusBarTransparent(brightness: Brightness.light);
  } else {
    statusBarTransparent(brightness: Brightness.dark);
  }
}

///  透明状态栏
statusBarTransparent({Brightness brightness = Brightness.dark, Color? color}) {
  bool light = brightness == Brightness.light;
  SystemUiOverlayStyle style = SystemUiOverlayStyle(
    systemNavigationBarColor: color ?? Colors.black,
    systemNavigationBarDividerColor: null,

    /// 注意安卓要想实现沉浸式的状态栏 需要底部设置透明色
    statusBarColor: Colors.transparent,
    statusBarBrightness: light ? Brightness.dark : Brightness.light,
    statusBarIconBrightness: light ? Brightness.light : Brightness.dark,
    systemNavigationBarIconBrightness:
        light ? Brightness.dark : Brightness.light,
  );
  SystemChrome.setSystemUIOverlayStyle(style);
}
