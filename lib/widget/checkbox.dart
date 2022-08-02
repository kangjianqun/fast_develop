import 'package:flutter/material.dart';

import '../fast_develop.dart';

class Checkbox extends StatelessWidget {
  const Checkbox({
    Key? key,
    this.size,
    this.description,
    this.spacing,
    this.padding,
    this.borderWidth,
    required this.value,
    this.onChanged,
    this.unselectedBGColor,
    this.unselectedBorderColor,
    this.selectedBGColor,
    this.selectedBorderColor,
    this.checkColor,
  }) : super(key: key);

  final num? size;
  final num? padding;
  final Widget? description;
  final double? spacing;
  final double? borderWidth;
  final ValueChanged<bool>? onChanged;
  final bool value;

  /// The color to use when this checkbox is checked.
  ///
  /// Defaults to [Colors.transparent].
  final Color? unselectedBGColor;

  /// Defaults to [ThemeData.unselectedWidgetColor].
  final Color? unselectedBorderColor;

  /// The color to use when this checkbox is checked.
  ///
  /// Defaults to [ThemeData.toggleableActiveColor].
  final Color? selectedBGColor;

  /// Defaults to [Colors.transparent].
  final Color? selectedBorderColor;

  /// The color to use for the check icon when this checkbox is checked.
  ///
  /// Defaults to [Colors.white]
  final Color? checkColor;

  @override
  Widget build(BuildContext context) {
    var childrenSpacing = spacing ?? FConfig.ins.checkboxOfSpacing;
    var size_ = size ?? FConfig.ins.checkboxOfSize;
    var checkboxPadding = padding ?? FConfig.ins.checkboxOfPadding;
    var checkboxBorderWidth = borderWidth ?? FConfig.ins.checkboxOfBorderWidth;
    var checkboxSize = (size_ + checkboxPadding).ww;

    final ThemeData themeData = Theme.of(context);
    var borderColor = value
        ? (selectedBorderColor ?? CConfig.transparent)
        : (unselectedBorderColor ?? themeData.unselectedWidgetColor);
    var bgColor = value
        ? (selectedBGColor ?? themeData.toggleableActiveColor)
        : (unselectedBGColor ?? CConfig.transparent);
    var color = checkColor ?? CConfig.white;
    var tick = !value
        ? Container()
        : Center(child: Icon(Icons.check, size: size_.ssp, color: color));

    Widget view = Container(
      width: checkboxSize,
      height: checkboxSize,
      margin: description != null ? null : Spacing.all(size: checkboxPadding),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(checkboxSize! / 2)),
        color: bgColor,
        border: Border.all(color: borderColor, width: checkboxBorderWidth.ww!),
      ),
      child: tick,
    );

    if (description != null) {
      view = Row(
          children: [view, Spacing.spacingView(width: childrenSpacing), description!]);
    }

    if (onChanged == null) {
      return view;
    } else {
      return TouchWidget(onTap: (_) => onChanged!(!value), child: view);
    }
  }
}
