import 'package:fast_develop/fast_develop.dart';
import 'package:fast_develop/widget/title.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

List<SingleChildWidget> providers = [
  ...independentServices,
  ...dependentServices,
  ...uiConsumableProviders
];

/// 独立的
List<SingleChildWidget> independentServices = [
  ChangeNotifierProvider<ThemeVM>.value(value: ThemeVM()),
  ChangeNotifierProvider<TitleVM>.value(value: TitleVM()),
];

/// 需要依赖的
List<SingleChildWidget> dependentServices = [];

List<SingleChildWidget> uiConsumableProviders = [];

/// 需要context  分批初始化  可以一个方法或者多个方法
Future<void> initConfig({BuildContext? context}) async {
  if (context == null) {
    CConfig.backgroundColor = Colors.white;
    CConfig.scaffoldBackgroundColor = Colors.grey.shade300;
  } else {
    statusBarTransparent(brightness: Brightness.light);
    FConfig.init(
      context: context,
      toast: (text) => showToast(text),
      respDataJson: (RespData data, Map<String, dynamic> json) {
        data.data = json['asd'];
      },
    );
  }
}
