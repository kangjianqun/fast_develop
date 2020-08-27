import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import '../../fast_develop.dart';

class DatePickerTheme with Diagnosticable {
  final TextStyle cancelStyle;
  final TextStyle doneStyle;
  final TextStyle itemStyle;
  final Color backgroundColor;

  final double containerHeight;
  final double titleHeight;
  final double itemHeight;

  const DatePickerTheme({
    this.cancelStyle,
    this.doneStyle,
    this.itemStyle = const TextStyle(color: Color(0xFF000046), fontSize: 18),
    this.backgroundColor = Colors.white,
    this.containerHeight = 210.0,
    this.titleHeight = 44.0,
    this.itemHeight = 36.0,
  });

  /// 自动
  static autoColor() {
    return DatePickerTheme(
      backgroundColor: CConfig.cBackgroundColor,
      itemStyle: TextStyle(color: CConfig.cTextColorOne),
      cancelStyle: TextStyle(color: CConfig.primaryColor, fontSize: 16),
      doneStyle: TextStyle(color: CConfig.primaryColor, fontSize: 16),
    );
  }
}
