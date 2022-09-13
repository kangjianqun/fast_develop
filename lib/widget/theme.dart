import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../fast_develop.dart';

class ThemeVM with ChangeNotifier {
  ThemeVM() {
    /// 明暗模式
    var index = StorageManager.getItem(kThemeBrightnessIndex) ?? defaultIndex;
    _brightness = Brightness.values[index];
    switchTheme(brightness: _brightness, color: CConfig.pColor, isInit: true);
  }

  static const kThemeColorIndex = 'kThemeColorIndex';
  static const kThemeBrightnessIndex = 'kThemeBrightnessIndex';
  static int defaultIndex = 1;

  /// 明暗模式
  late Brightness _brightness;

  /// 当前主题颜色
  late MaterialColor _themeColor;
  late ThemeData _themeData;

  ThemeData get themeData => _themeData;

  ThemeData get darkTheme => _themeData.copyWith(brightness: Brightness.dark);

  /// 切换指定色彩
  /// 没有传[brightness]就不改变brightness,color同理
  ///  [forciblyModify]强制修改 用于初始化的时候没有适配文字大小的问题
  void switchTheme(
      {Brightness? brightness,
      MaterialColor? color,
      bool isInit = false,
      bool forciblyModify = false}) {
    if (forciblyModify &&
        brightness == _brightness &&
        (color == null || _themeColor == color)) return;
    _brightness = brightness ?? _brightness;
    _themeColor = color ?? _themeColor;
    _themeData = _generateThemeData(_brightness,
        themeColor: _themeColor, modifyGlobal: true);
    if (isInit) return;
    delayed(() => notifyListeners());
    saveTheme2Storage(_brightness, _themeColor);
  }

  /// 可以调用后二次修改 或者自己实现
  static ThemeData switchThemeBrightness(
      Brightness? brightness, ThemeData? themeData) {
    return _generateThemeData(brightness, themeData: themeData);
  }

  /// 根据主题 明暗 和 颜色 生成对应的主题 全局修改
  static ThemeData _generateThemeData(Brightness? brightness,
      {ThemeData? themeData,
      MaterialColor? themeColor,
      bool modifyGlobal = false}) {
    MaterialColor? accentColor = themeColor;
    var pColor = CConfig.primaryColor;

    var blackWhite =
        CConfig.getMatching(brightness: brightness, modifyGlobal: modifyGlobal);
    var background = CConfig.getBackground(
        brightness: brightness, modifyGlobal: modifyGlobal);
    var scaffoldBackground = CConfig.getScaffoldBackground(
        brightness: brightness, modifyGlobal: modifyGlobal);

    var one =
        CConfig.getOne(brightness: brightness, modifyGlobal: modifyGlobal);
    var two =
        CConfig.getTwo(brightness: brightness, modifyGlobal: modifyGlobal);
    var focus = CConfig.focusColor;

    var sIconSize = FConfig.ins.themeSelectedLabelSize;
    var unSIconSize = FConfig.ins.themeUnselectedLabelSize;
    var sLabelSize = FConfig.ins.themeSelectedLabelSize;
    var unSLabelSize = FConfig.ins.themeUnselectedLabelSize;

    var iconColor = one;

    var themeD = themeData ?? ThemeData();

    themeData = themeD.copyWith(
      // 主题颜色属于亮色系还是属于暗色系(eg:dark时,AppBarTitle文字及状态栏文字的颜色为白色,反之为黑色)
      brightness: brightness,
      primaryColor: pColor,
      backgroundColor: background,
      scaffoldBackgroundColor: scaffoldBackground,
      splashColor: pColor.withAlpha(50),
      errorColor: focus,
      hintColor: themeD.hintColor.withAlpha(90),
      colorScheme: themeD.colorScheme.copyWith(
        secondary: accentColor,
      ),
      toggleableActiveColor: accentColor,
      textSelectionTheme: TextSelectionThemeData(
        cursorColor: accentColor,
        selectionColor: accentColor?.withAlpha(60),
        selectionHandleColor: accentColor?.withAlpha(60),
      ),
      tabBarTheme: TabBarTheme(
        unselectedLabelColor: blackWhite,
        labelColor: focus,
        indicator: const BoxDecoration(),
      ),
      floatingActionButtonTheme: themeD.floatingActionButtonTheme.copyWith(
        // foregroundColor: accentColor,
        foregroundColor: Colors.white,
      ),
      appBarTheme: themeD.appBarTheme.copyWith(
          color: background,
          brightness: brightness,
          titleTextStyle: TextStyle(color: one),
          elevation: 0),
      cupertinoOverrideTheme: CupertinoThemeData(
        primaryColor: pColor,
        brightness: brightness,
      ),
      primaryTextTheme: textTheme(color: one),
      primaryIconTheme: iconTheme(color: iconColor),
      bottomNavigationBarTheme: themeD.bottomNavigationBarTheme.copyWith(
        backgroundColor: background,
        selectedLabelStyle: StyleText.normal(size: sLabelSize, color: pColor),
        unselectedLabelStyle: StyleText.normal(size: unSLabelSize, color: two),
        selectedIconTheme: IconThemeData(size: sIconSize.ssp, color: pColor),
        unselectedIconTheme: IconThemeData(size: unSIconSize.ssp, color: two),
      ),
      chipTheme: themeD.chipTheme.copyWith(
        pressElevation: 0,
        padding: const EdgeInsets.symmetric(horizontal: 10),
        labelStyle: themeD.textTheme.caption,
        backgroundColor: themeD.chipTheme.backgroundColor?.withOpacity(0.1),
      ),
    );

    return themeData;
  }

  /// 可以调用后二次修改 或者自己实现
  static TextTheme textTheme({Brightness? brightness, Color? color}) {
    if (brightness != null) {
      color = CConfig.getOne(brightness: brightness);
    }
    return TextTheme(
      bodyText1: StyleText.one(color: color),
      bodyText2: StyleText.two(color: color),
      headline6: TextStyle(
        color: color,
        fontSize: FConfig.ins.themeFontSize.toDouble(),
        fontWeight: FontWeight.bold,
      ),
    );
  }

  /// 可以调用后二次修改 或者自己实现
  static IconThemeData iconTheme({Brightness? brightness, Color? color}) {
    if (brightness != null) {
      color = CConfig.getOne(brightness: brightness);
    }
    return IconThemeData(color: color);
  }

  /// 数据持久化到shared preferences
  saveTheme2Storage(Brightness brightness, MaterialColor themeColor) async {
    var index = Colors.primaries.indexOf(themeColor);
    StorageManager.setItem(kThemeBrightnessIndex, brightness.index);
    StorageManager.setItem(kThemeColorIndex, index);
  }
}
