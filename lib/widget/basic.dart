import 'package:fast_mvvm/fast_mvvm.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../fast_develop.dart';

/// 主次显示
class PSDisplay extends StatelessWidget {
  const PSDisplay({
    Key key,
    @required this.primary,
    @required this.secondary,
  })  : assert(primary != null && secondary != null),
        super(key: key);
  final Child primary;
  final Child secondary;

  @override
  Widget build(BuildContext context) => primary() ?? secondary();
}

class AutoText extends StatelessWidget {
  const AutoText(
    this.data, {
    Key key,
    this.style,
    this.child,
    this.alignment = Alignment.centerLeft,
    this.fit = BoxFit.scaleDown,
  })  : assert(data != null),
        assert(child == null),
        super(key: key);

  final Text child;
  final String data;
  final TextStyle style;
  final AlignmentGeometry alignment;
  final BoxFit fit;

  @override
  Widget build(BuildContext context) {
    Widget view = child ?? Text(data, style: style);

    return FittedBox(fit: fit, alignment: alignment, child: view);
  }
}

class AutoWidget extends StatelessWidget {
  const AutoWidget({
    Key key,
    @required this.child,
    this.alignment = Alignment.center,
    this.fit = BoxFit.scaleDown,
  }) : super(key: key);
  final Widget child;
  final AlignmentGeometry alignment;
  final BoxFit fit;

  @override
  Widget build(BuildContext context) {
    return FittedBox(fit: fit, alignment: alignment, child: child);
  }
}

class IconText extends StatelessWidget {
  const IconText({
    Key key,
    @required this.icon,
    @required this.text,
    this.isV = true,
    this.iconIsLeftOrTop = true,
    this.spacing,
    this.adaptChildrenSize = false,
    this.iconBottom,
    this.isExpanded = false,
    this.crossAxisAlignment,
  })  : this.data = null,
        this.iData = null,
        this.color = null,
        this.size = null,
        this.textSize = null,
        super(key: key);

  const IconText.simple({
    Key key,
    @required this.data,
    @required this.iData,
    @required this.color,
    @required this.size,
    this.textSize,
    this.isV = true,
    this.iconIsLeftOrTop = true,
    this.spacing,
    this.adaptChildrenSize = false,
    this.iconBottom = 4,
    this.isExpanded = false,
    this.crossAxisAlignment,
  })  : this.text = null,
        this.icon = null,
        super(key: key);

  const IconText.img({
    Key key,
    @required this.icon,
    this.isV = true,
    this.iconIsLeftOrTop = true,
    this.spacing,
    this.adaptChildrenSize = false,
    this.iconBottom = 0,
    this.isExpanded = false,
    this.crossAxisAlignment,
    this.textSize,
  })  : this.text = null,
        this.data = null,
        this.iData = null,
        this.color = null,
        this.size = null,
        super(key: key);

  final Widget icon;
  final IconData iData;
  final Widget text;
  final String data;
  final Color color;
  final double size;
  final double textSize;
  final num spacing;
  final double iconBottom;
  final bool isV;
  final bool iconIsLeftOrTop;
  final bool adaptChildrenSize;
  final bool isExpanded;
  final CrossAxisAlignment crossAxisAlignment;

  Widget _text() {
    var textView = text;
    if (text == null && data.en) {
      textView = Text(data,
          style: StyleText.normal(size: textSize ?? size, color: color));
    }
    return isExpanded ? Expanded(child: textView) : textView;
  }

  Widget _icon() {
    var _icon = Spacing.vView();
    if (icon != null || iData != null) {
      _icon = Container(
        padding: this.isV
            ? null
            : Spacing.topOrBottom(size: iconBottom, isTop: false),
        child: icon ?? Icon(iData, size: (size - 2).ssp, color: color),
      );
    }
    return _icon;
  }

  @override
  Widget build(BuildContext context) {
    int w = 0;
    int h = 0;
//    ThemeData themeData = Theme.of(context);

    if (isV) {
      h = spacing ?? FastDevelopConfig.iconTextOfSpacing;
    } else {
      w = spacing ?? FastDevelopConfig.iconTextOfSpacing;
    }
    List<Widget> childView = [];
    var view;
    var icon = _icon();
    var text = _text();
    if (this.iconIsLeftOrTop) {
      childView.add(icon);
      if (text != null) {
        childView.add(Spacing.spacingView(width: w, height: h));
        childView.add(text);
      }
    } else {
      childView.add(text);
      if (icon != null) {
        childView.add(Spacing.spacingView(width: w, height: h));
        childView.add(icon);
      }
    }
    if (childView.length == 1) {
      view = childView[0];
    } else {
      if (this.isV) {
        view = Column(mainAxisSize: MainAxisSize.min, children: childView);
      } else {
        view = Row(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: crossAxisAlignment ?? CrossAxisAlignment.center,
          children: childView,
        );
      }
    }
    return adaptChildrenSize ? view : Center(child: view);
  }
}

class Button extends StatelessWidget {
  const Button({
    Key key,
    this.text,
    this.child,
    @required this.onTap,
    this.isCircle = true,
    this.paddingInside,
    this.radius = 20,
    this.decoration,
    this.paddingChild,
    this.size,
    this.sizeH,
    this.icon,
    this.color,
    this.textSize = 40,
    this.paddingOuter,
    this.margin,
    this.pressedOpacity = 0.4,
    this.borderColor,
    this.style,
    this.touchSpaced,
  }) : super(key: key);

  /// 图标按钮
  const Button.img({
    Key key,
    this.text,
    this.child,
    @required this.icon,
    @required this.onTap,
    this.isCircle = true,
    this.paddingInside,
    this.radius = 20,
    this.decoration,
    this.paddingChild = 8,
    this.size = 72,
    this.sizeH,
    this.color,
    this.textSize,
    this.paddingOuter,
    this.margin,
    this.pressedOpacity = 0.4,
    this.borderColor,
    this.touchSpaced,
  })  : this.style = null,
        super(key: key);

  final bool isCircle;
  final Color borderColor;
  final double radius;
  final int touchSpaced;
  final String text;
  final TouchTap onTap;
  final EdgeInsets paddingInside;
  final Decoration decoration;
  final Widget child;

  final num textSize;
  final int paddingChild;
  final EdgeInsets paddingOuter;
  final EdgeInsets margin;
  final IconData icon;

  /// 图标容器大小
  final double size;
  final double sizeH;
  final PrimarySecondary<Color> color;
  final TextStyle style;
  final double pressedOpacity;

  @override
  Widget build(BuildContext context) {
    Widget view;
    ThemeData themeData = Theme.of(context);

    PrimarySecondary _color = color ??
        PrimarySecondary(themeData.iconTheme.color, CConfig.transparent);

    Border border = borderColor == null ? null : Border.all(color: borderColor);

    if (icon != null) {
      view = Container(
        height: size.s,
        width: size.s,
        margin: margin,
        decoration: DecoUtil.normal(
          color: _color.secondary,
          isCircle: isCircle,
          radius: radius,
          border: border,
        ),
        child: Icon(
          icon,
          color: _color.primary,
          size: (size - paddingChild).ssp,
        ),
      );
    } else {
      view = Container(
        width: size == null ? null : size.s,
        height: sizeH == null ? null : sizeH.s,
        margin: margin,
        padding: paddingInside ?? Spacing.all(leftR: 48, topB: 16),
        decoration: decoration ??
            DecoUtil.normal(
              color: _color.secondary,
              isCircle: isCircle,
              radius: radius,
              border: border,
            ),
        child: child ??
            Center(
              widthFactor: 1,
              heightFactor: 1,
              child: Text(text,
                  style: style ??
                      StyleText.normal(color: _color.primary, size: textSize)),
            ),
      );

      if (paddingOuter != null || IntUtil.isNotEmpty(paddingChild)) {
        view = Padding(
          padding: paddingOuter ?? Spacing.all(size: paddingChild),
          child: view,
        );
      }
    }

    if (onTap == null) {
      return view;
    } else {
      return TouchWidget(child: view, onTap: onTap, touchSpaced: touchSpaced);
    }
  }
}

/// 扩展[Card]
class CardEx extends StatelessWidget {
  const CardEx({
    Key key,
    @required this.child,
    this.margin,
    this.padding,
    this.shadow = false,
    this.width,
    this.height,
    this.title,
    this.space,
    this.right,
    this.subTitle = "",
    this.left,
    this.center,
    this.backgroundColor,
    this.titleColor,
    this.subTitleColor,
    this.textColor,
    this.brightness,
    this.gradient,
  }) : super(key: key);

  final EdgeInsets margin;
  final EdgeInsets padding;
  final Widget child;
  final Widget center;
  final Widget right;
  final Widget left;
  final num width;
  final num height;

  /// 阴影 默认false
  final bool shadow;

  final String title;
  final String subTitle;
  final num space;
  final Color backgroundColor;
  final Brightness brightness;
  final Color textColor;
  final Color titleColor;
  final Color subTitleColor;
  final Gradient gradient;
  Widget _child(Color titleColor, Color subTitleColor) {
    var view;
    if (title.en || subTitle.en || center != null) {
      Widget _center = TextRich(color: textColor, children: [
        RichTextItem(
          title ?? "",
          StyleText.one(
            weight: FontWeight.bold,
            color: titleColor,
            brightness: brightness,
          ),
        ),
        RichTextItem(title.e ? "" : "  " + subTitle ?? "",
            StyleText.grey(size: 25, color: subTitleColor))
      ]);

      if (center != null) _center = Row(children: <Widget>[_center, center]);

      Widget _space = Spacing.spacingView(height: space ?? SConfig.listSpace);
      view = Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              Spacing.vView(isShow: left != null, child: () => left),
              Spacing.vView(isShow: left != null, child: () => _space),
              Expanded(child: _center),
              Spacing.vView(isShow: right != null, child: () => _space),
              Spacing.vView(isShow: right != null, child: () => right),
            ],
          ),
          _space,
          child,
        ],
      );
    } else {
      view = child;
    }
    return view;
  }

  @override
  Widget build(BuildContext context) {
    var _padding = padding ?? Spacing.all(size: 20);
    var _margin = margin ?? Spacing.all(size: 0);

    Color color =
        backgroundColor ?? CConfig.getBackground(brightness: brightness);
    Color _titleColor = textColor ?? titleColor;
    Color _subTitleColor = textColor ?? subTitleColor;

    var _view = _child(_titleColor, _subTitleColor);
    if (shadow) {
      return Card(
        margin: _margin,
        color: color,
        child: Padding(padding: _padding, child: _view),
      );
    } else {
      return Container(
        width: width,
        height: height,
        decoration: DecoUtil.normal(color: color, gradient: gradient),
        margin: _margin,
        child: Padding(padding: _padding, child: _view),
      );
    }
  }
}

/// 描述 左边标题  右边内容
class Describe extends StatelessWidget {
  const Describe({
    Key key,
    @required this.title,
    @required this.data,
  })  : child = null,
        super(key: key);

  /// 自定义
  const Describe.custom({
    Key key,
    @required this.title,
    @required this.child,
  })  : data = null,
        super(key: key);

  final String title;
  final String data;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    Widget _child = Spacing.vView();

    if (data.en) _child = Text(data);

    if (child != null) _child = child;

    return DefaultTextStyle(
      style: StyleText.normal(),
      child: Row(children: <Widget>[Text(title), Expanded(child: _child)]),
    );
  }
}

/// list 间距
class ListIntervalView extends StatelessWidget {
  const ListIntervalView({
    Key key,
    this.direction = Axis.vertical,
    this.space = 16,
    this.separator,
    this.height = 0,
    this.margin,
    this.physics,
    this.color,
    this.fullLine = true,
    this.primary = false,
    this.shrinkWrap = true,
    @required this.itemCount,
    @required this.itemBuilder,
    this.mainPadding = 32,
    this.crossPadding = 32,
  })  : this.children = null,
        super(key: key);

  const ListIntervalView.children({
    Key key,
    this.direction = Axis.vertical,
    this.space = 16,
    this.separator,
    this.height = 0,
    this.margin,
    this.physics,
    this.color,
    this.fullLine = true,
    this.primary = false,
    this.shrinkWrap = true,
    @required this.children,
    this.mainPadding = 32,
    this.crossPadding = 32,
  })  : this.itemCount = children.length,
        this.itemBuilder = null,
        super(key: key);

  const ListIntervalView.nested({
    Key key,
    this.direction = Axis.vertical,
    this.space = 16,
    this.separator,
    this.height = 0,
    this.margin,
    this.physics,
    this.color,
    this.fullLine = true,
    this.primary = false,
    this.shrinkWrap = true,
    @required this.itemCount,
    @required this.itemBuilder,
    this.mainPadding = 0,
    this.crossPadding = 0,
  })  : this.children = null,
        super(key: key);

  final List<Widget> children;
  final Axis direction;
  final Widget separator;
  final num space;
  final num mainPadding;
  final num crossPadding;

  final bool shrinkWrap;
  final num height;
  final EdgeInsets margin;
  final int itemCount;
  final IndexedWidgetBuilder itemBuilder;

  final ScrollPhysics physics;
  final Color color;

  /// 整行 item 填充宽度
  final bool fullLine;
  final bool primary;

  Widget _getSeparator() {
    return separator ?? Spacing.spacingView(width: space, height: space);
  }

  Widget _getItem(BuildContext ctx, int index) {
    bool isChild = children.en;
    if (!fullLine)
      return Row(children: <Widget>[
        isChild ? children[index] : itemBuilder(ctx, index)
      ]);
    else
      return isChild ? children[index] : itemBuilder(ctx, index);
  }

  @override
  Widget build(BuildContext context) {
    Widget _separator = _getSeparator();
    bool isH = direction == Axis.horizontal;

    return Container(
      height: isH ? height.s : null,
      color: color,
      child: ListView.separated(
        shrinkWrap: shrinkWrap,
        primary: primary,
        padding: Spacing.all(
          leftR: isH ? mainPadding : crossPadding,
          topB: isH ? crossPadding : mainPadding,
        ),
        physics: physics ?? NeverScrollableScrollPhysics(),
        scrollDirection: direction,
        itemCount: itemCount,
        itemBuilder: _getItem,
        separatorBuilder: (_, __) => _separator,
        cacheExtent: pageHeight,
      ),
    );
  }
}

class GridIntervalView extends StatelessWidget {
  const GridIntervalView({
    Key key,
    this.direction,
    this.separator,
    this.mainSpace = 16,
    this.crossSpace = 16,
    this.mainPadding = 32,
    this.crossPadding = 32,
    this.height,
    this.width,
    this.color,
    this.shrinkWrap = false,
    this.primary = false,
    this.physics = const BouncingScrollPhysics(),
    @required this.itemBuilder,
    this.ratio,
    @required this.crossAxisCount,
    @required this.itemCount,
  })  : children = null,
        super(key: key);

  /// 嵌套的 不能滑动
  const GridIntervalView.nested({
    Key key,
    this.direction,
    this.separator,
    this.mainSpace = 16,
    this.crossSpace = 16,
    this.ratio,
    this.mainPadding = 32,
    this.crossPadding = 32,
    this.height,
    this.width,
    this.color,
    this.shrinkWrap = true,
    this.primary = false,
    this.physics = const NeverScrollableScrollPhysics(),
    @required this.crossAxisCount,
    @required this.itemCount,
    @required this.itemBuilder,
  })  : children = null,
        super(key: key);

  /// 嵌套的 不能滑动
  const GridIntervalView.nestedChildren({
    Key key,
    this.direction,
    this.separator,
    this.mainSpace = 16,
    this.crossSpace = 16,
    this.ratio,
    this.mainPadding = 32,
    this.crossPadding = 32,
    this.height,
    this.width,
    this.color,
    this.shrinkWrap = true,
    this.primary = false,
    this.physics = const NeverScrollableScrollPhysics(),
    @required this.crossAxisCount,
    @required this.children,
  })  : itemCount = children.length,
        itemBuilder = null,
        super(key: key);

  final IndexedWidgetBuilder itemBuilder;
  final Axis direction;
  final Widget separator;
  final num mainSpace;
  final num crossSpace;
  final num height;
  final double width;

  /// padding top  bottom
  final num mainPadding;
  final num crossPadding;

  final int itemCount;
  final crossAxisCount;
  final double ratio;
  final bool shrinkWrap;
  final bool primary;
  final Color color;
  final ScrollPhysics physics;
  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    bool isH = direction == Axis.horizontal;
    var _padding = Spacing.all(
      leftR: isH ? mainPadding : crossPadding,
      topB: isH ? crossPadding : mainPadding,
    );
    return Container(
      height: isH || height != null ? height.s : null,
      width: width != null ? width.s : null,
      color: color,
      alignment: Alignment.topCenter,
      child: GridView.builder(
        shrinkWrap: shrinkWrap,
        primary: primary,
        itemCount: itemCount,
        physics: physics,
        padding: _padding,
        itemBuilder: itemBuilder ?? (_, index) => children[index],
        cacheExtent: pageHeight,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: crossAxisCount,
          childAspectRatio: ratio ?? 1.0,
          mainAxisSpacing: mainSpace.s,
          crossAxisSpacing: crossSpace.s,
        ),
      ),
    );
  }
}

/// 单行 多用于单行item显示
class SingleLine<T> extends StatelessWidget {
  const SingleLine.txt(
    this.name, {
    Key key,
    @required this.iconData,
    this.iconUrl,
    this.padding,
    this.nameTxtStyle,
    this.nameWidget,
    this.leftView,
    this.onDropdownChanged,
    this.dropdownItems,
    this.dropdownValue,
    this.centerTxt,
    this.centerTxtStyle,
    this.centerWidget,
    this.onTap,
    this.rightShow = true,
    this.isPrimary,
    this.rightTxt,
    this.rightTxtStyle,
    this.url,
    this.decoration,
    this.minHeight,
    this.iconHeight,
    this.nameLeftPadding,
    this.nameRightPadding,
    this.backgroundColor,
  })  : assert(name == null || nameWidget == null),
        assert(centerTxt == null || centerWidget == null),
        super(key: key);

  const SingleLine({
    Key key,
    this.padding,
    @required this.iconData,
    this.iconUrl,
    this.onDropdownChanged,
    this.dropdownItems,
    this.dropdownValue,
    this.centerTxt,
    this.centerTxtStyle,
    this.centerWidget,
    this.name,
    this.nameTxtStyle,
    this.nameWidget,
    this.leftView,
    this.onTap,
    this.rightShow = true,
    this.isPrimary,
    this.rightTxt,
    this.rightTxtStyle,
    this.url,
    this.decoration,
    this.minHeight,
    this.iconHeight,
    this.nameLeftPadding,
    this.nameRightPadding,
    this.backgroundColor,
  })  : assert(name == null || nameWidget == null),
        assert(centerTxt == null || centerWidget == null),
        super(key: key);

  const SingleLine.normal({
    Key key,
    this.padding,
    @required this.name,
    this.nameTxtStyle,
    this.nameWidget,
    this.leftView,
    this.onDropdownChanged,
    this.dropdownItems,
    this.dropdownValue,
    this.centerTxt,
    this.centerTxtStyle,
    this.centerWidget,
    this.iconData,
    this.iconUrl,
    this.onTap,
    this.rightShow = true,
    this.isPrimary,
    this.rightTxt,
    this.rightTxtStyle,
    this.url,
    this.decoration,
    this.minHeight,
    this.iconHeight,
    this.nameLeftPadding,
    this.nameRightPadding,
    this.backgroundColor,
  })  : assert(name == null || nameWidget == null),
        assert(centerTxt == null || centerWidget == null),
        super(key: key);

  const SingleLine.custom({
    Key key,
    this.padding,
    @required this.name,
    this.leftView,
    this.nameWidget,
    this.onDropdownChanged,
    this.dropdownItems,
    this.dropdownValue,
    this.nameTxtStyle,
    this.centerTxt,
    this.centerTxtStyle,
    @required this.centerWidget,
    this.iconData,
    this.iconUrl,
    this.onTap,
    this.rightShow = false,
    this.isPrimary,
    this.rightTxt,
    this.rightTxtStyle,
    this.url,
    this.decoration,
    this.minHeight,
    this.iconHeight,
    this.nameLeftPadding,
    this.nameRightPadding,
    this.backgroundColor,
  })  : assert(name == null || nameWidget == null),
        assert(centerTxt == null || centerWidget == null),
        super(key: key);

  const SingleLine.dropdown({
    Key key,
    this.padding,
    @required this.name,
    @required this.onDropdownChanged,
    @required this.dropdownItems,
    this.dropdownValue,
    this.nameTxtStyle,
    this.centerTxt,
    this.centerTxtStyle,
    this.centerWidget,
    this.nameWidget,
    this.leftView,
    this.iconData,
    this.iconUrl,
    this.onTap,
    this.rightShow = false,
    this.isPrimary,
    this.rightTxt,
    this.rightTxtStyle,
    this.url,
    this.decoration,
    this.minHeight,
    this.iconHeight,
    this.nameLeftPadding,
    this.nameRightPadding,
    this.backgroundColor,
  })  : assert(name == null || nameWidget == null),
        assert(centerTxt == null || centerWidget == null),
        super(key: key);

  final String name;
  final TextStyle nameTxtStyle;
  final Widget nameWidget;
  final Widget leftView;
  final String iconUrl;
  final IconData iconData;
  final TouchTap onTap;
  final Color backgroundColor;
  final bool isPrimary;
  final bool rightShow;
  final num minHeight;
  final num iconHeight;
  final num nameLeftPadding;
  final num nameRightPadding;
  final String centerTxt;
  final TextStyle centerTxtStyle;
  final Widget centerWidget;
  final String rightTxt;
  final TextStyle rightTxtStyle;
  final String url;
  final EdgeInsets padding;
  final Decoration decoration;
  final List<DropdownMenuItem<T>> dropdownItems;
  final ValueChanged<T> onDropdownChanged;
  final T dropdownValue;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final IconThemeData iconThemeData = IconTheme.of(context);
    Color bg =
        backgroundColor ?? theme.backgroundColor ?? CConfig.cBackgroundColor;
    Color iconColor = iconThemeData.color;

    var _minHeight = minHeight ?? FastDevelopConfig.singleLineOfMinHeight;
    var _iconHeight = iconHeight ?? FastDevelopConfig.singleLineOfIconHeight;
    var _nameLeftPadding =
        nameLeftPadding ?? FastDevelopConfig.singleLineOfNameLeftPadding;
    var _nameRightPadding =
        nameRightPadding ?? FastDevelopConfig.singleLineOfNameRightPadding;
    var _isPrimary = isPrimary ?? FastDevelopConfig.singleLineOfIsPrimary;
    return TouchWidget(
      onTap: onTap,
      child: ConstrainedBox(
        constraints: BoxConstraints(minHeight: _minHeight.sh),
        child: Container(
          padding: padding ?? Spacing.all(leftR: 32, topB: 16),
          decoration: decoration ?? DecoUtil.normal(color: bg, radius: 15),
          child: Row(children: <Widget>[
            _icon(iconColor, _iconHeight, _nameLeftPadding),
            _name(_nameRightPadding),
            _center(),
            _dropdown(bg),
            Spacing.vView(
              isShow: url.en,
              child: () => ClipRRect(
                borderRadius: SBorderRadius.circle(),
                child: WrapperImage.size(size: 200.s, url: url),
              ),
            ),
            Spacing.vView(
              isShow: rightTxt.en,
              child: () =>
                  Text(rightTxt, style: rightTxtStyle ?? StyleText.grey()),
            ),
            Spacing.vView(
              isShow: rightShow,
              child: () => Container(
                  child: Icon(
                Icons.chevron_right,
                color: _isPrimary ? theme.primaryColor : iconColor,
              )),
            ),
          ]),
        ),
      ),
    );
  }

  Widget _icon(Color iconColor, num iconHeight, num nameLeftPadding) {
    Widget view = leftView;

    if (view == null) {
      if (iconUrl.en) {
        view = WrapperImage.size(
            size: iconHeight.s, url: iconUrl, fit: BoxFit.contain);
      } else {
        view = Spacing.vView(
          isShow: iconData != null,
          child: () => Icon(iconData, size: iconHeight.ssp, color: iconColor),
        );
      }
    }

    return Container(
      margin: Spacing.leftOrRight(size: nameLeftPadding, isLeft: false),
      child: view,
    );
  }

  Widget _name(num nameRightPadding) {
    var leftChild =
        nameWidget ?? Text(name, style: nameTxtStyle ?? StyleText.normal());
    return Container(
      margin: Spacing.leftOrRight(size: nameRightPadding, isLeft: false),
      child: leftChild,
    );
  }

  Widget _center() {
    if (centerWidget != null) {
      return Expanded(child: centerWidget);
    } else if (centerTxt.e && ListUtil.isEmpty(dropdownItems)) {
      return Expanded(child: Spacing.vView());
    } else {
      return Spacing.vView(
        isShow: centerTxt.en,
        child: () => Container(
          child: Text(
            centerTxt,
            style: centerTxtStyle ?? StyleText.grey(size: 32),
          ),
        ),
      );
    }
  }

  Widget _dropdown(Color bg) {
    return Spacing.vView(
      isShow: ListUtil.isNotEmpty(dropdownItems),
      child: () {
        ValueNotifier<T> cause = ValueNotifier(dropdownValue);
        return Expanded(
          child: ValueListenableBuilder(
            valueListenable: cause,
            builder: (_, value, __) {
              return Material(
                color: bg,
                child: DropdownButton(
                  value: value,
                  isExpanded: true,
                  isDense: true,
                  style: centerTxtStyle ?? StyleText.two(),
                  items: dropdownItems,
                  underline: SizedBox(),
                  onChanged: (value) {
                    cause.value = value;
                    onDropdownChanged(value);
                  },
                ),
              );
            },
          ),
        );
      },
    );
  }
}
