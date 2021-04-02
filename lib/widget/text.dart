import 'package:flutter/gestures.dart';
import 'package:flutter/widgets.dart';
import '../fast_develop.dart';

class RichTextStyle {
  String text;
  double size;
  Color? color;
  GestureRecognizer? onTap;
  RichTextStyle({
    required this.text,
    required this.size,
    required this.color,
    this.onTap,
  });

  RichTextStyle.color({
    required this.text,
    required this.size,
    this.onTap,
    this.color,
  });
}

/// [_RichTextWidget] 需要用
class RichTextItem {
  String text;
  TextStyle textStyle;
  GestureRecognizer? onTap;

  RichTextItem(this.text, this.textStyle, {this.onTap});
}

List<RichTextItem> consistent(List<RichTextStyle> children, {Color? color}) {
  List<RichTextItem> list = [];
  children.forEach((style) {
    list.add(
      RichTextItem(
        style.text,
        StyleText.normal(size: style.size, color: style.color ?? color),
        onTap: style.onTap,
      ),
    );
  });
  return list;
}

/// 富文本集成
class TextRich extends StatelessWidget {
  const TextRich({
    Key? key,
    this.list,
    this.children,
    this.color,
    this.textAlign = TextAlign.start,
  })  : assert(list == null || children == null),
        super(key: key);

  const TextRich.color({
    Key? key,
    this.list,
    this.children,
    this.textAlign = TextAlign.start,
    required this.color,
  })   : assert(list == null || children == null),
        super(key: key);

  final List<RichTextStyle>? list;
  final List<RichTextItem>? children;

  final TextAlign textAlign;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return _RichTextWidget(
      textAlign: textAlign,
      children: children ?? consistent(list!, color: color),
    );
  }
}

/// 富文本
class _RichTextWidget extends StatelessWidget {
  const _RichTextWidget({
    Key? key,
    required this.children,
    this.textAlign = TextAlign.start,
  })  : assert(children.length > 1),
        super(key: key);

  /// 每段文字
  final List<RichTextItem> children;
  final TextAlign textAlign;

  @override
  Widget build(BuildContext context) {
    List<TextSpan> view = [];

    var _text = children[0].text;
    var _style = children[0].textStyle;
    children.removeAt(0);
    view = children
        .map((item) => TextSpan(
            text: item.text, style: item.textStyle, recognizer: item.onTap))
        .toList();

    return RichText(
      textAlign: textAlign,
      text: TextSpan(text: _text, style: _style, children: view),
    );
  }
}
