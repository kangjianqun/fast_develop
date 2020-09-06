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
  static const kFontIndex = 'kFontIndex';
  static int defaultIndex = 1;

  /// 明暗模式
  Brightness _brightness;

  /// 当前主题颜色
  MaterialColor _themeColor;
  ThemeData _themeData;
  ThemeData get themeData => _themeData;
  ThemeData get darkTheme => _themeData.copyWith(brightness: Brightness.dark);

  /// 切换指定色彩
  /// 没有传[brightness]就不改变brightness,color同理
  void switchTheme(
      {Brightness brightness, MaterialColor color, bool isInit = false}) {
    if (brightness == _brightness && (color == null || _themeColor == color))
      return;
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
      Brightness brightness, ThemeData themeData) {
    return _generateThemeData(brightness, themeData: themeData);
  }

  /// 根据主题 明暗 和 颜色 生成对应的主题 全局修改
  static ThemeData _generateThemeData(Brightness brightness,
      {ThemeData themeData,
      MaterialColor themeColor,
      bool modifyGlobal = false}) {
    var _brightness = brightness;
    MaterialColor accentColor = themeColor;
    var pColor = CConfig.primaryColor;

    var blackWhite = CConfig.getMatching(
        brightness: _brightness, modifyGlobal: modifyGlobal);
    var background = CConfig.getBackground(
        brightness: _brightness, modifyGlobal: modifyGlobal);
    var scaffoldBackground = CConfig.getScaffoldBackground(
        brightness: _brightness, modifyGlobal: modifyGlobal);

    var one =
        CConfig.getOne(brightness: _brightness, modifyGlobal: modifyGlobal);
    var two =
        CConfig.getTwo(brightness: _brightness, modifyGlobal: modifyGlobal);
    var focus = CConfig.focusColor;

    var iconColor = one;

    var _themeD = themeData ?? ThemeData();

    var _themeData = _themeD.copyWith(
      brightness: _brightness,
      // 主题颜色属于亮色系还是属于暗色系(eg:dark时,AppBarTitle文字及状态栏文字的颜色为白色,反之为黑色)
      primaryColorBrightness: _brightness,
      accentColorBrightness: _brightness,
      primaryColor: pColor,
      accentColor: accentColor,
      backgroundColor: background,
      scaffoldBackgroundColor: scaffoldBackground,
      splashColor: pColor.withAlpha(50),
      errorColor: focus,
      cursorColor: accentColor,
      textSelectionColor: accentColor?.withAlpha(60),
      textSelectionHandleColor: accentColor?.withAlpha(60),
      toggleableActiveColor: accentColor,

      tabBarTheme: TabBarTheme(
        unselectedLabelColor: blackWhite,
        labelColor: focus,
        indicator: BoxDecoration(),
      ),
      appBarTheme: AppBarTheme(
        color: background,
        brightness: _brightness,
        textTheme: textTheme(color: one),
      ),
      cupertinoOverrideTheme: CupertinoThemeData(
        primaryColor: pColor,
        brightness: _brightness,
      ),
      primaryTextTheme: textTheme(color: one),
      primaryIconTheme: iconTheme(color: iconColor),
    );

    _themeData = _themeData.copyWith(
      bottomNavigationBarTheme: _themeData.bottomNavigationBarTheme.copyWith(
        backgroundColor: background,
        selectedLabelStyle: StyleText.normal(size: 25, color: pColor),
        unselectedLabelStyle: StyleText.normal(size: 25, color: two),
        selectedIconTheme: IconThemeData(size: 46.ssp, color: pColor),
        unselectedIconTheme: IconThemeData(size: 46.ssp, color: two),
      ),
      appBarTheme: _themeData.appBarTheme.copyWith(elevation: 0),
      accentIconTheme: _themeData.accentIconTheme.copyWith(color: Colors.white),
      hintColor: _themeData.hintColor.withAlpha(90),
      chipTheme: _themeData.chipTheme.copyWith(
        pressElevation: 0,
        padding: EdgeInsets.symmetric(horizontal: 10),
        labelStyle: _themeData.textTheme.caption,
        backgroundColor: _themeData.chipTheme.backgroundColor.withOpacity(0.1),
      ),
    );
    return _themeData;
  }

  /// 可以调用后二次修改 或者自己实现
  static TextTheme textTheme({Brightness brightness, Color color}) {
    var _color = color;
    if (brightness != null) {
      _color = CConfig.getOne(brightness: brightness);
    }
    return TextTheme(
      bodyText1: StyleText.one(color: _color),
      bodyText2: StyleText.two(color: _color),
      headline6: TextStyle(
        color: _color,
        fontSize: 22,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  /// 可以调用后二次修改 或者自己实现
  static IconThemeData iconTheme({Brightness brightness, Color color}) {
    var _color = color;
    if (brightness != null) {
      _color = CConfig.getOne(brightness: brightness);
    }
    return IconThemeData(color: _color);
  }

  /// 数据持久化到shared preferences
  saveTheme2Storage(Brightness brightness, MaterialColor themeColor) async {
    var index = Colors.primaries.indexOf(themeColor);
    StorageManager.setItem(kThemeBrightnessIndex, brightness.index);
    StorageManager.setItem(kThemeColorIndex, index);
  }
}
