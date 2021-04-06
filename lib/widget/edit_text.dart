import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../fast_develop.dart';

class DecorationChanger {
  DecorationChanger({
    this.fillColor,
    this.focusColor,
    this.defaultBorderRadius,
    this.focusBorderRadius,
    this.defaultBorder,
    this.focusBorder,
  }) {
    this.fillColor ??= CConfig.cBackgroundColor;
  }

  DecorationChanger.changer({
    this.fillColor,
    this.focusColor,
    this.defaultBorderRadius = const BorderRadius.all(Radius.circular(4)),
    this.focusBorderRadius = const BorderRadius.all(Radius.circular(4)),
    this.defaultBorder,
    this.focusBorder,
  }) {
    this.fillColor ??= CConfig.cBackgroundColor;
    this.defaultBorder ??= defaultBorderStyle();
    this.focusBorder ??= defaultBorderStyle();
  }

  DecorationChanger.circular({
    this.fillColor,
    this.focusColor,
    this.defaultBorderRadius = const BorderRadius.all(Radius.circular(100)),
    this.focusBorderRadius = const BorderRadius.all(Radius.circular(100)),
    this.defaultBorder,
    this.focusBorder,
  }) {
    this.fillColor ??= CConfig.cBackgroundColor;
    this.defaultBorder ??= defaultBorderStyle();
    this.focusBorder ??= defaultBorderStyle();
  }

  static Border defaultBorderStyle() {
    return Border.fromBorderSide(BorderSide(
        color: CConfig.cMatchingColor!, width: 1.0, style: BorderStyle.solid));
  }

  Color? fillColor;
  Color? focusColor;
  BorderRadius? defaultBorderRadius;
  BorderRadius? focusBorderRadius;
  Border? defaultBorder;
  Border? focusBorder;

  Color? getColor(bool isFocus) {
    return isFocus ? focusColor : fillColor;
  }

  BorderRadius? getBRadius(bool isFocus) {
    return isFocus ? focusBorderRadius : defaultBorderRadius;
  }

  Border? getBorder(bool isFocus) {
    return isFocus ? focusBorder : defaultBorder;
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
    this.icon,
    this.rightChild,
    this.name,
    this.focusNode,
    this.onChanged,
    TextInputType? inputType,
    this.textDirection,
    this.decoration,
    this.decorationChanger,
    this.autoFocus = false,
    this.textAlign = TextAlign.start,
    this.complete,
    this.textInputAction,
    this.onSubmitted,
    this.iconRightSpace,
    this.signLeftPadding,
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
    this.icon,
    this.rightChild,
    required this.name,
    this.focusNode,
    this.onChanged,
    TextInputType? inputType,
    this.textDirection,
    this.decoration,
    this.decorationChanger,
    this.autoFocus = false,
    this.textAlign = TextAlign.start,
    this.complete,
    this.textInputAction,
    this.onSubmitted,
    this.iconRightSpace,
    this.signLeftPadding,
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
    this.icon,
    this.rightChild,
    required this.name,
    this.focusNode,
    this.onChanged,
    TextInputType? inputType,
    this.textDirection,
    this.textAlign = TextAlign.right,
    this.decoration,
    this.decorationChanger,
    this.autoFocus = false,
    this.complete,
    this.textInputAction,
    this.onSubmitted,
    this.iconRightSpace,
    this.signLeftPadding,
  })  : keyboardType = inputType ??
            (maxLines == 1 ? TextInputType.text : TextInputType.multiline),
        super(key: key);

  final double? height;
  final double? width;
  final num? iconRightSpace;
  final num? signLeftPadding;
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

  final DecorationChanger? decorationChanger;
  final EdgeInsetsGeometry? margin;
  final EdgeInsetsGeometry? padding;
  final int maxLines;
  final int? maxLength;
  final Color? cursorColor;
  final TextEditingController? controller;
  final Widget? icon;
  final Widget? rightChild;
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
  late DecorationChanger decorationChanger;

  FocusNode? _focusNode;
  FocusNode get _effectiveFNode =>
      widget.focusNode ?? (_focusNode ??= FocusNode());
  var _iconRightSpace;

  @override
  void initState() {
    super.initState();
    if (widget.controller == null) _controller = TextEditingController();
    decorationChanger = widget.decorationChanger ?? DecorationChanger();
    _iconRightSpace =
        widget.iconRightSpace ?? FConfig.ins.editTextOfIconRightSpace;
  }

  Widget _leftSign(num nameLeftPadding) {
    Widget? view = widget.icon ??
        (widget.name!.e ? null : Text(widget.name!, style: StyleText.normal()));

    if (view != null) {
      view = Container(
          margin: Spacing.leftOrRight(size: _iconRightSpace, isLeft: false),
          child: view);
    } else {
      view = Spacing.vView();
    }

    return Container(
      margin: Spacing.leftOrRight(size: nameLeftPadding),
      child: view,
    );
  }

  @override
  Widget build(BuildContext context) {
    var _leftR = FConfig.ins.editTextOfLeftRight;
    var _topB = FConfig.ins.editTextOfTopBottom;
    var _signLeftPadding =
        widget.signLeftPadding ?? FConfig.ins.singleLineOfNameLeftPadding;

    Widget leftSign = _leftSign(_signLeftPadding);
    Widget right = widget.rightChild ?? Spacing.vView();
    InputDecoration _decoration = widget.decoration ??
        InputDecoration(
          hintText: widget.hint ?? "",
          counterText: widget.showCountHint ? null : "",
          hintStyle:
              widget.hintStyle ?? StyleText.grey(size: FConfig.ins.textTwo),
          disabledBorder: InputBorder.none,
          enabledBorder: InputBorder.none,
          focusedBorder: InputBorder.none,
        );

    var _complete = widget.complete == null
        ? null
        : () {
            _effectiveFNode.unfocus();
            widget.complete!();
          };

    return Container(
      width: widget.width == null ? null : widget.width!.ww,
      height: widget.height == null ? null : widget.height!.hh,
      alignment: Alignment.center,
      margin: widget.margin,
      padding: widget.padding ?? Spacing.all(leftR: _leftR, topB: _topB),
      decoration: BoxDecoration(
        color: decorationChanger.getColor(_effectiveFNode.hasFocus),
        borderRadius: decorationChanger.getBRadius(_effectiveFNode.hasFocus),
        border: decorationChanger.getBorder(_effectiveFNode.hasFocus),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          leftSign,
          Expanded(
            child: TextField(
              autofocus: widget.autoFocus,
              enabled: widget.enabled,
              obscureText: widget.obscureText,
              style:
                  widget.style ?? StyleText.normal(size: FConfig.ins.textTwo),
              controller: _effectiveController,
              focusNode: _effectiveFNode,
              decoration: _decoration,
              maxLines: widget.maxLines,
              maxLength: widget.maxLength,
              keyboardType: widget.keyboardType,
              textDirection: widget.textDirection,
              textAlign: widget.textAlign,
              onEditingComplete: _complete,
              textInputAction: widget.textInputAction,
              onChanged: widget.onChanged,
              onSubmitted: widget.onSubmitted,
            ),
          ),
          right,
        ],
      ),
    );
  }
}
