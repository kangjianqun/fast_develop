import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import '../fast_develop.dart';

class IConfig {
  /// 列表
  static IconData list = Icons.list;
  static IconData close = Icons.close;
  static IconData add = Icons.add;
}

class CConfig {
  static MaterialColor pColor = MaterialColor(
    0xFF0266B3,
    <int, Color>{
      50: Color(0xFFE3F2FD),
      100: Color(0xFFBBDEFB),
      200: Color(0xFF90CAF9),
      300: Color(0xFF64B5F6),
      400: Color(0xFF42A5F5),
      500: Color(0xFF0266B3),
      600: Color(0xFF1E88E5),
      700: Color(0xFF1976D2),
      800: Color(0xFF1565C0),
      900: Color(0xFF0D47A1),
    },
  );

  static Brightness? platformBrightness;

  /// 启用
  static bool enableDark = true;

  /// 着重色
  static Color focusColor = Color(0xFFDB3117);
  static Color primaryColor = Color(0xFF0266B3);
  static Color primaryDarkColor = Color(0xFF0266B3);
  static Color backgroundColor = Colors.white;
  static Color scaffoldBackgroundColor = Colors.white;
  static Color backgroundDarkColor = Colors.black;
  static Color scaffoldBackgroundDarkColor = Colors.black;

  static Color? cScaffoldBackgroundColor;
  static Color? cBackgroundColor;
  static Color? cMatchingColor;
  static Color? cTextColorOne;
  static Color? cTextColorTwo;
  static Color? cTextColorThree;

  /// 白色
  static Color white = Colors.white;
  static Color black = Colors.black;

  static Color red = Colors.red;
  static Color textColorOne = Colors.black;
  static Color textColorTwo = Colors.grey;
  static Color textColorThree = Colors.grey;
  static Color grey = Colors.grey;
  static Color negativeColor = Colors.grey;
  static Color transparent = Colors.transparent;
  static Color redBright = Colors.red;

  static PrimarySecondary<Color> whiteGrey =
      PrimarySecondary<Color>(white, grey);

  ///  [nullable] 可为空
  ///  [color] 默认颜色
  static Color? getColor({
    required Brightness? brightness,
    required Color light,
    required Color dark,
    BuildContext? context,
    Color? color,
    bool nullable = false,
  }) {
    if (!enableDark) return light;

    if (color != null) return color;
    if (brightness == null && nullable) return null;
    var _bright = brightness ??
        (context == null ? platformBrightness : Theme.of(context).brightness);
    var isLight = _bright == Brightness.light;
    var _color = isLight ? light : dark;
    return _color;
  }

  static Color? getOne(
      {Brightness? brightness,
      Color? color,
      BuildContext? context,
      bool nullable = false,
      bool modifyGlobal = false}) {
    var _color = getColor(
      brightness: brightness,
      context: context,
      light: textColorOne,
      dark: white,
      color: color,
      nullable: nullable,
    );
    if (color == null) {
      if (modifyGlobal) {
        cTextColorOne = _color;
      } else {
        cTextColorOne ??= _color;
      }
    }
    return _color;
  }

  static Color? getTwo(
      {Brightness? brightness,
      Color? color,
      BuildContext? context,
      bool nullable = false,
      bool modifyGlobal = false}) {
    var _color = getColor(
      brightness: brightness,
      context: context,
      light: textColorTwo,
      dark: white,
      color: color,
      nullable: nullable,
    );
    if (color == null) {
      if (modifyGlobal) {
        cTextColorTwo = _color;
      } else {
        cTextColorTwo ??= _color;
      }
    }
    return _color;
  }

  static Color? getThree(
      {Brightness? brightness,
      Color? color,
      BuildContext? context,
      bool nullable = false,
      bool modifyGlobal = false}) {
    var _color = getColor(
      brightness: brightness,
      context: context,
      light: textColorThree,
      dark: white,
      color: color,
      nullable: nullable,
    );
    if (color == null) {
      if (modifyGlobal) {
        cTextColorThree = _color;
      } else {
        cTextColorThree ??= _color;
      }
    }
    return _color;
  }

  static Color? getBackground(
      {Brightness? brightness,
      Color? color,
      BuildContext? context,
      bool nullable = false,
      bool modifyGlobal = false}) {
    var _color = getColor(
      brightness: brightness,
      context: context,
      light: backgroundColor,
      dark: backgroundDarkColor,
      color: color,
      nullable: nullable,
    );

    if (color == null) {
      if (modifyGlobal) {
        cBackgroundColor = _color;
      } else {
        cBackgroundColor ??= _color;
      }
    }
    return _color;
  }

  static Color? getScaffoldBackground(
      {Brightness? brightness,
      Color? color,
      BuildContext? context,
      bool nullable = false,
      bool modifyGlobal = false}) {
    var _color = getColor(
      brightness: brightness,
      context: context,
      light: scaffoldBackgroundColor,
      dark: scaffoldBackgroundDarkColor,
      color: color,
      nullable: nullable,
    );
    if (color == null) {
      if (modifyGlobal) {
        cScaffoldBackgroundColor = _color;
      } else {
        cScaffoldBackgroundColor ??= _color;
      }
    }
    return _color;
  }

  /// 比对色
  static Color? getMatching(
      {Brightness? brightness,
      Color? color,
      BuildContext? context,
      bool nullable = false,
      bool modifyGlobal = false}) {
    var _color = getColor(
      brightness: brightness,
      context: context,
      light: black,
      dark: white,
      color: color,
      nullable: nullable,
    );
    if (color == null) {
      if (modifyGlobal) {
        cMatchingColor = _color;
      } else {
        cMatchingColor ??= _color;
      }
    }
    return _color;
  }
}

class SConfig {

  static num listSpace = 26;

  /// 根布局 左右间隔
  static num rootSpace = 26;

  /// [Widget]内部间隔
  static num padding = 20;

  static num space = 8;
}

class StyleText {
  /// 忽略
  static TextStyle one({
    Color? color,
    FontWeight weight = FontWeight.normal,
    Brightness? brightness,
    bool ignoreColor = false,
  }) {
    return normal(
      size: FConfig.ins.textOne,
      color: color ?? CConfig.cTextColorOne,
      fontWeight: weight,
      ignoreColor: ignoreColor,
    );
  }

  /// 采用默认 [DefaultTextStyle] 的颜色
  static TextStyle oneNoColor(
      {Color? color,
      FontWeight weight = FontWeight.normal,
      Brightness? brightness}) {
    return one(color: null, weight: weight, ignoreColor: true);
  }

  static TextStyle oneB({
    Color? color,
    FontWeight weight = FontWeight.bold,
    Brightness? brightness,
    bool ignoreColor = false,
  }) {
    return normal(
      size: FConfig.ins.textOne,
      color: color ?? CConfig.cTextColorOne,
      fontWeight: weight,
      ignoreColor: ignoreColor,
    );
  }

  static TextStyle two({
    Color? color,
    FontWeight weight = FontWeight.normal,
    TextDecoration? decoration,
    Brightness? brightness,
    bool ignoreColor = false,
  }) {
    return normal(
      size: FConfig.ins.textTwo,
      color: color ?? CConfig.cTextColorTwo,
      fontWeight: weight,
      decoration: decoration,
      ignoreColor: ignoreColor,
    );
  }

  /// 采用默认 [DefaultTextStyle] 的颜色
  static TextStyle twoNoColor(
      {Color? color,
      FontWeight weight = FontWeight.normal,
      Brightness? brightness}) {
    return two(color: null, weight: weight, ignoreColor: true);
  }

  static TextStyle three({
    Color? color,
    FontWeight weight = FontWeight.normal,
    TextDecoration? decoration,
    Brightness? brightness,
    bool ignoreColor = false,
  }) {
    return normal(
      size: FConfig.ins.textThree,
      color: color ?? CConfig.cTextColorThree,
      fontWeight: weight,
      decoration: decoration,
      ignoreColor: ignoreColor,
    );
  }

  /// 采用默认 [DefaultTextStyle] 的颜色
  static TextStyle threeNoColor(
      {Color? color,
      FontWeight weight = FontWeight.normal,
      Brightness? brightness}) {
    return three(color: null, weight: weight, ignoreColor: true);
  }

  static TextStyle normal({
    num? size,
    Color? color,
    Color? backgroundColor,
    Color? decorationColor,
    FontWeight fontWeight = FontWeight.normal,
    String? fontFamily,
    TextDecoration? decoration = TextDecoration.none,
    double? decorationThickness,
    Brightness? brightness,
    bool ignoreColor = false,
  }) {
    return TextStyle(
      fontSize: (size ?? FConfig.ins.textThree).ssp,
      color: ignoreColor ? null : (color ?? CConfig.cTextColorTwo),
      backgroundColor: backgroundColor,
      fontWeight: fontWeight,
      decoration: decoration,
      decorationColor: decorationColor,
      decorationThickness: decorationThickness,
      textBaseline: TextBaseline.alphabetic,
      fontFamily: fontFamily,
    );
  }

  static TextStyle white({
    num? size,
    Color? color,
    Color? backgroundColor,
    FontWeight fontWeight = FontWeight.normal,
    String? fontFamily,
    TextDecoration d = TextDecoration.none,
  }) {
    return normal(
      size: size,
      color: color ?? CConfig.white,
      backgroundColor: backgroundColor,
      fontWeight: fontWeight,
      fontFamily: fontFamily,
      decoration: d,
    );
  }

  static TextStyle bold({
    num? size,
    Color? color,
    Color? backgroundColor,
    FontWeight fontWeight = FontWeight.normal,
    String? fontFamily,
    TextDecoration decoration = TextDecoration.none,
    double? decorationThickness,
  }) {
    return normal(
      size: size,
      color: color ?? CConfig.cTextColorOne,
      backgroundColor: backgroundColor,
      fontWeight: FontWeight.bold,
      fontFamily: fontFamily,
      decoration: decoration,
      decorationThickness: decorationThickness,
    );
  }

  static TextStyle red({
    num? size,
    Color? color,
    Color? backgroundColor,
    FontWeight fontWeight = FontWeight.normal,
    String? fontFamily,
    TextDecoration? decoration,
  }) {
    return normal(
      size: size,
      color: color ?? CConfig.red,
      backgroundColor: backgroundColor,
      decoration: decoration,
      fontWeight: fontWeight,
      fontFamily: fontFamily,
    );
  }

  static TextStyle grey({
    num? size,
    Color? color,
    Color? backgroundColor,
    FontWeight fontWeight = FontWeight.normal,
    String? fontFamily,
  }) {
    return normal(
      size: size,
      color: color ?? CConfig.getTwo(),
      backgroundColor: backgroundColor,
      fontWeight: fontWeight,
      fontFamily: fontFamily,
    );
  }
}

class SBorderRadius {
  static BorderRadiusGeometry normal({num? radius}) {
    var _radius = radius ?? FConfig.ins.radius;
    return BorderRadius.all(Radius.circular(_radius.ww!));
  }

  static BorderRadiusGeometry circle({num? radius}) {
    var _radius = radius ?? FConfig.ins.radiusOfCircle;
    return BorderRadius.circular(_radius.ww!);
  }

  static BorderRadiusGeometry only(
      {num? topLeft, num? topRight, num? bottomLeft, num? bottomRight}) {
    var _topLeft = topLeft ?? FConfig.ins.radius;
    var _topRight = topRight ?? FConfig.ins.radius;
    var _bottomLeft = bottomLeft ?? FConfig.ins.radius;
    var _bottomRight = bottomRight ?? FConfig.ins.radius;

    return BorderRadius.only(
      topLeft: Radius.circular(_topLeft.ww!),
      topRight: Radius.circular(_topRight.ww!),
      bottomLeft: Radius.circular(_bottomLeft.ww!),
      bottomRight: Radius.circular(_bottomRight.ww!),
    );
  }

  static different({num top = 20, num bottom = 40, bool isTB = true}) {
    return isTB
        ? BorderRadius.only(
            topLeft: Radius.circular(top.ww!),
            topRight: Radius.circular(top.ww!),
            bottomLeft: Radius.circular(bottom.ww!),
            bottomRight: Radius.circular(bottom.ww!),
          )
        : BorderRadius.only(
            topLeft: Radius.circular(top.ww!),
            bottomLeft: Radius.circular(top.ww!),
            topRight: Radius.circular(bottom.ww!),
            bottomRight: Radius.circular(bottom.ww!),
          );
  }

  static BorderRadiusGeometry leftRight({num? radius, bool isH = true}) {
    var _radius = radius ?? FConfig.ins.radiusOfCircle;
    var value = Radius.circular(_radius.ww!);

    return isH
        ? BorderRadius.horizontal(left: value, right: value)
        : BorderRadius.vertical(top: value, bottom: value);
  }

  static BorderRadiusGeometry leftOrRight({num? radius, bool isLeft = true}) {
    var _radius = radius ?? FConfig.ins.radius;
    var value = Radius.circular(_radius.ww!);
    var nullValue = Radius.circular(0);
    return BorderRadius.only(
      topLeft: isLeft ? value : nullValue,
      bottomLeft: isLeft ? value : nullValue,
      topRight: isLeft ? nullValue : value,
      bottomRight: isLeft ? nullValue : value,
    );
  }

  static BorderRadiusGeometry topOrButton({num? radius, bool isTop = true}) {
    var _radius = radius ?? FConfig.ins.radius;
    var value = Radius.circular(_radius.ww!);
    var nullValue = Radius.circular(0);
    return BorderRadius.only(
      topLeft: isTop ? value : nullValue,
      topRight: isTop ? value : nullValue,
      bottomLeft: isTop ? nullValue : value,
      bottomRight: isTop ? nullValue : value,
    );
  }
}
