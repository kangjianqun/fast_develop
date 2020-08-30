import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../fast_develop.dart';

class Checkbox extends StatelessWidget {
  const Checkbox({
    Key key,
    this.size = 50,
    this.description,
    this.spacing = 16,
    this.padding = 8,
    @required this.value,
    @required this.onChanged,
    this.unselectedBGColor,
    this.unselectedBorderColor,
    this.selectedBGColor,
    this.selectedBorderColor,
    this.checkColor,
  }) : super(key: key);

  final int size;
  final int padding;
  final Widget description;
  final double spacing;
  final ValueChanged<bool> onChanged;
  final bool value;

  /// The color to use when this checkbox is checked.
  ///
  /// Defaults to [Colors.transparent].
  final Color unselectedBGColor;

  /// Defaults to [ThemeData.unselectedWidgetColor].
  final Color unselectedBorderColor;

  /// The color to use when this checkbox is checked.
  ///
  /// Defaults to [ThemeData.toggleableActiveColor].
  final Color selectedBGColor;

  /// Defaults to [Colors.transparent].
  final Color selectedBorderColor;

  /// The color to use for the check icon when this checkbox is checked.
  ///
  /// Defaults to [Colors.white]
  final Color checkColor;

  @override
  Widget build(BuildContext context) {
    var _spacing = spacing ?? FastDevelopConfig.checkboxOfSpacing;
    var __size = size ?? FastDevelopConfig.checkboxOfSize;
    var _padding = padding ?? FastDevelopConfig.checkboxOfPadding;
    var _size = (__size + _padding).s;

    final ThemeData themeData = Theme.of(context);
    var borderColor = value
        ? (selectedBorderColor ?? Colors.transparent)
        : (unselectedBorderColor ?? themeData.unselectedWidgetColor);
    var bgColor = value
        ? (selectedBGColor ?? themeData.toggleableActiveColor)
        : (unselectedBGColor ?? Colors.transparent);
    var color = checkColor ?? Colors.white;
    var tick = !value
        ? Container()
        : Center(child: Icon(Icons.check, size: size.ssp, color: color));

    Widget _view = Container(
      width: _size,
      height: _size,
      margin: description != null ? null : Spacing.all(size: _padding),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(_size / 2)),
        color: bgColor,
        border: Border.all(color: borderColor, width: 1),
      ),
      child: tick,
    );

    if (description != null) {
      _view = Row(
          children: [_view, Spacing.spacingView(width: _spacing), description]);
    }

    if (onChanged == null)
      return _view;
    else
      return TouchWidget(onTap: (_) => onChanged(!value), child: _view);
  }
}
