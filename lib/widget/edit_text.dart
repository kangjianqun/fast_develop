import 'package:fast_develop/fast_develop.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class InputDecorationUtil {
  /// 正常
  static InputDecoration normal({String? hintText, TextStyle? hintStyle}) {
    return InputDecoration(
      hintText: hintText ?? "",
      hintStyle: hintStyle ?? StyleText.grey(size: FConfig.ins.textTwo),
      disabledBorder: InputBorder.none,
      enabledBorder: InputBorder.none,
      focusedBorder: InputBorder.none,
    );
  }

  /// 边线
  static InputDecoration border({
    String? hintText,
    TextStyle? hintStyle,
    num? radius,
    BorderSide? borderSide,
    Color? disabledBorderColor,
    Color? enabledBorderColor,
    Color? focusedBorderColor,
  }) {
    var borderR = SBorderRadius.circle(radius: radius);
    var disabledBorder = OutlineInputBorder(
      borderRadius: borderR,
      borderSide: borderSide ??
          BorderSide(
              color: disabledBorderColor ?? CConfig.cDisabledBorderColor),
    );
    var enabledBorder = OutlineInputBorder(
      borderRadius: borderR,
      borderSide: borderSide ??
          BorderSide(color: enabledBorderColor ?? CConfig.cEnabledBorderColor),
    );
    var focusedBorder = OutlineInputBorder(
      borderRadius: borderR,
      borderSide: borderSide ??
          BorderSide(color: focusedBorderColor ?? CConfig.cFocusedBorderColor),
    );

    return InputDecoration(
      hintText: hintText ?? "",
      hintStyle: hintStyle ?? StyleText.grey(size: FConfig.ins.textTwo),
      disabledBorder: disabledBorder,
      enabledBorder: enabledBorder,
      focusedBorder: focusedBorder,
    );
  }
}

class EditText extends StatefulWidget {
  const EditText({
    Key? key,
    this.margin,
    this.padding,
    this.height,
    this.width,
    this.maxLines = 1,
    this.maxLength,
    this.style,
    this.hint,
    this.hintStyle,
    this.enabled = true,
    this.obscureText = false,
    this.showCountHint = true,
    this.cursorColor,
    this.controller,
    this.name,
    this.focusNode,
    this.onChanged,
    TextInputType? inputType,
    this.textDirection,
    this.decoration,
    this.autoFocus = false,
    this.textAlign = TextAlign.start,
    this.complete,
    this.textInputAction,
    this.onSubmitted,
    this.scrollPadding,
  })  : keyboardType = inputType ??
            (maxLines == 1 ? TextInputType.text : TextInputType.multiline),
        super(key: key);

  const EditText.text({
    Key? key,
    this.margin,
    this.padding,
    this.height,
    this.width,
    this.maxLines = 1,
    this.maxLength,
    this.style,
    this.hint,
    this.hintStyle,
    this.enabled = true,
    this.obscureText = false,
    this.showCountHint = true,
    this.cursorColor,
    this.controller,
    required this.name,
    this.focusNode,
    this.onChanged,
    TextInputType? inputType,
    this.textDirection,
    this.decoration,
    this.autoFocus = false,
    this.textAlign = TextAlign.start,
    this.complete,
    this.textInputAction,
    this.onSubmitted,
    this.scrollPadding,
  })  : keyboardType = inputType ??
            (maxLines == 1 ? TextInputType.text : TextInputType.multiline),
        super(key: key);

  const EditText.right({
    Key? key,
    this.margin,
    this.padding,
    this.height,
    this.width,
    this.maxLines = 1,
    this.maxLength,
    this.style,
    this.hint,
    this.hintStyle,
    this.enabled = true,
    this.obscureText = false,
    this.showCountHint = true,
    this.cursorColor,
    this.controller,
    required this.name,
    this.focusNode,
    this.onChanged,
    TextInputType? inputType,
    this.textDirection,
    this.textAlign = TextAlign.right,
    this.decoration,
    this.autoFocus = false,
    this.complete,
    this.textInputAction,
    this.onSubmitted,
    this.scrollPadding,
  })  : keyboardType = inputType ??
            (maxLines == 1 ? TextInputType.text : TextInputType.multiline),
        super(key: key);

  final double? height;
  final double? width;

  final num? scrollPadding;
  final String? name;
  final String? hint;
  final TextStyle? hintStyle;
  final bool enabled;
  final bool obscureText;
  final bool showCountHint;
  final TextStyle? style;
  final bool autoFocus;

  /// {@macro flutter.widgets.editableText.textDirection}
  final TextDirection? textDirection;
  final TextAlign textAlign;
  final TextInputAction? textInputAction;

  final EdgeInsetsGeometry? margin;
  final EdgeInsetsGeometry? padding;
  final int maxLines;
  final int? maxLength;
  final Color? cursorColor;
  final TextEditingController? controller;
  final FocusNode? focusNode;
  final TextInputType keyboardType;
  final ValueChanged<String>? onChanged;
  final ValueChanged<String>? onSubmitted;
  final InputDecoration? decoration;
  final VoidCallback? complete;

  @override
  _EditTextState createState() => _EditTextState();
}

class _EditTextState extends State<EditText> {
  late TextEditingController _controller;
  TextEditingController get _effectiveController =>
      widget.controller ?? _controller;

  FocusNode? _focusNode;
  FocusNode get _effectiveFNode =>
      widget.focusNode ?? (_focusNode ??= FocusNode());

  @override
  void initState() {
    super.initState();
    if (widget.controller == null) _controller = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    InputDecoration _decoration = widget.decoration ??
        InputDecorationUtil.normal(
            hintText: widget.hint, hintStyle: widget.hintStyle);

    var _complete = widget.complete == null
        ? null
        : () {
            _effectiveFNode.unfocus();
            widget.complete!();
          };

    return Container(
      width: widget.width == null ? null : widget.width.ww,
      height: widget.height == null ? null : widget.height.hh,
      alignment: Alignment.center,
      margin: widget.margin,
      padding: widget.padding,
      child: TextField(
        scrollPadding: Spacing.all(size: widget.scrollPadding ?? 0),
        autofocus: widget.autoFocus,
        enabled: widget.enabled,
        obscureText: widget.obscureText,
        style: widget.style ?? StyleText.normal(size: FConfig.ins.textTwo),
        controller: _effectiveController,
        focusNode: _effectiveFNode,
        decoration: _decoration,
        maxLines: widget.maxLines,
        maxLength: widget.maxLength,
        keyboardType: widget.keyboardType,
        textDirection: widget.textDirection,
        cursorColor: widget.cursorColor,
        textAlign: widget.textAlign,
        onEditingComplete: _complete,
        textInputAction: widget.textInputAction,
        onChanged: widget.onChanged,
        onSubmitted: widget.onSubmitted,
      ),
    );
  }
}
