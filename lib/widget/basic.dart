import 'package:flutter/material.dart';

import '../fast_develop.dart';

/// 主次显示
class PSDisplay extends StatelessWidget {
  const PSDisplay({
    Key? key,
    this.primary,
    this.secondary,
  }) : super(key: key);
  final Child? primary;
  final Child? secondary;

  @override
  Widget build(BuildContext context) {
    return primary == null || primary!() == null ? secondary!()! : primary!()!;
  }
}

class AutoText extends StatelessWidget {
  const AutoText(
    this.data, {
    Key? key,
    this.style,
    this.child,
    this.alignment = Alignment.centerLeft,
    this.fit = BoxFit.scaleDown,
  })  : assert(child == null),
        super(key: key);

  final Text? child;
  final String data;
  final TextStyle? style;
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
    Key? key,
    required this.child,
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
    Key? key,
    required this.icon,
    required this.text,
    this.isV = true,
    this.iconIsLeftOrTop = true,
    this.spacing,
    this.adaptChildrenSize = false,
    this.iconBottom,
    this.isExpanded = false,
    this.crossAxisAlignment,
  })  : data = null,
        iData = null,
        color = null,
        size = null,
        textSize = null,
        super(key: key);

  const IconText.simple({
    Key? key,
    required this.data,
    required this.iData,
    required this.color,
    required this.size,
    this.textSize,
    this.isV = true,
    this.iconIsLeftOrTop = true,
    this.spacing,
    this.adaptChildrenSize = false,
    this.iconBottom = 4,
    this.isExpanded = false,
    this.crossAxisAlignment,
  })  : text = null,
        icon = null,
        super(key: key);

  const IconText.img({
    Key? key,
    required this.icon,
    this.isV = true,
    this.iconIsLeftOrTop = true,
    this.spacing,
    this.adaptChildrenSize = false,
    this.iconBottom = 0,
    this.isExpanded = false,
    this.crossAxisAlignment,
    this.textSize,
  })  : text = null,
        data = null,
        iData = null,
        color = null,
        size = null,
        super(key: key);

  final Widget? icon;
  final IconData? iData;
  final Widget? text;
  final String? data;
  final Color? color;
  final double? size;
  final double? textSize;
  final num? spacing;
  final double? iconBottom;
  final bool isV;
  final bool iconIsLeftOrTop;
  final bool adaptChildrenSize;
  final bool isExpanded;
  final CrossAxisAlignment? crossAxisAlignment;

  Widget? _text() {
    var view = text;
    if (text == null && data.en) {
      view = Text(data!,
          style: StyleText.normal(size: textSize ?? size, color: color));
    }
    return isExpanded && view != null ? Expanded(child: view) : view;
  }

  Widget? _icon(num iconBottom) {
    var icon_ = Spacing.vView();
    if (icon != null || iData != null) {
      icon_ = Container(
        padding:
            isV ? null : Spacing.topOrBottom(size: iconBottom, isTop: false),
        child: icon ?? Icon(iData, size: ((size ?? 2) - 2).ssp, color: color),
      );
    }
    return icon_;
  }

  @override
  Widget build(BuildContext context) {
    num w = 0;
    num h = 0;
//    ThemeData themeData = Theme.of(context);
    var iconBottom_ = iconBottom ?? FConfig.ins.iconTextOfIconBottom;
    if (isV) {
      h = spacing ?? FConfig.ins.iconTextOfSpacing;
    } else {
      w = spacing ?? FConfig.ins.iconTextOfSpacing;
    }
    List<Widget> childView = [];
    Widget view;
    var icon = _icon(iconBottom_);
    var text = _text();
    if (iconIsLeftOrTop) {
      if (icon != null) childView.add(icon);
      if (text != null) {
        childView.add(Spacing.spacingView(width: w, height: h));
        childView.add(text);
      }
    } else {
      if (text != null) childView.add(text);
      if (icon != null) {
        childView.add(Spacing.spacingView(width: w, height: h));
        childView.add(icon);
      }
    }
    if (childView.length == 1) {
      view = childView[0];
    } else {
      if (isV) {
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
    Key? key,
    this.text,
    this.child,
    required this.onTap,
    this.isCircle = true,
    this.paddingInside,
    this.radius,
    this.decoration,
    this.paddingChild,
    this.size,
    this.sizeH,
    this.icon,
    this.color,
    this.textSize,
    this.paddingOuter,
    this.margin,
    this.pressedOpacity,
    this.borderColor,
    this.style,
    this.touchSpaced,
    this.leftR,
    this.topB,
  }) : super(key: key);

  /// 图标按钮
  const Button.img({
    Key? key,
    this.text,
    this.child,
    required this.icon,
    required this.onTap,
    this.isCircle = true,
    this.paddingInside,
    this.radius,
    this.decoration,
    this.paddingChild = 8,
    this.size,
    this.sizeH,
    this.color,
    this.textSize,
    this.paddingOuter,
    this.margin,
    this.pressedOpacity,
    this.borderColor,
    this.touchSpaced,
    this.leftR,
    this.topB,
  })  : style = null,
        super(key: key);

  final bool isCircle;
  final Color? borderColor;
  final double? radius;
  final int? touchSpaced;
  final String? text;
  final TouchTap? onTap;
  final EdgeInsets? paddingInside;
  final Decoration? decoration;
  final Widget? child;

  final num? leftR;
  final num? topB;
  final num? textSize;
  final num? paddingChild;
  final EdgeInsets? paddingOuter;
  final EdgeInsets? margin;
  final IconData? icon;

  /// 图标容器大小
  final double? size;
  final double? sizeH;
  final PrimarySecondary<Color>? color;
  final TextStyle? style;
  final double? pressedOpacity;

  @override
  Widget build(BuildContext context) {
    Widget view;
    ThemeData themeData = Theme.of(context);

    PrimarySecondary color_ = color ??
        PrimarySecondary(themeData.iconTheme.color, CConfig.transparent);

    Border? border =
        borderColor == null ? null : Border.all(color: borderColor!);

    var radius_ = radius ?? FConfig.ins.radius;
    var lR = leftR ?? FConfig.ins.buttonOfLeftR;
    var tB = topB ?? FConfig.ins.buttonOfTopB;
    var padding = paddingInside ?? Spacing.all(leftR: lR, topB: tB);
    var ts = textSize ?? FConfig.ins.buttonOfTextSize;
    var deco = decoration ??
        DecoUtil.normal(
            color: color_.secondary,
            isCircle: isCircle,
            radius: radius_,
            border: border);
    var style_ = style ?? StyleText.normal(color: color_.primary, size: ts);
    var sH = sizeH ?? FConfig.ins.buttonOfSizeH;
    if (icon != null) {
      var size_ = size ?? FConfig.ins.buttonOfSize;
      view = Container(
        height: size_.rr,
        width: size_.rr,
        margin: margin,
        decoration: DecoUtil.normal(
          color: color_.secondary,
          isCircle: isCircle,
          radius: radius_,
          border: border,
        ),
        child: Icon(
          icon,
          color: color_.primary,
          size: (size! - paddingChild!).ssp,
        ),
      );
    } else {
      view = Container(
        width: size.rr,
        height: sH.rr,
        margin: margin,
        padding: padding,
        decoration: deco,
        child: child ??
            Center(
              widthFactor: 1,
              heightFactor: 1,
              child: Text(text!, style: style_),
            ),
      );

      if (paddingOuter != null || paddingChild != null) {
        view = Padding(
          padding: paddingOuter ?? Spacing.all(size: paddingChild),
          child: view,
        );
      }
    }

    if (onTap == null) {
      return view;
    } else {
      return TouchWidget(onTap: onTap, touchSpaced: touchSpaced, child: view);
    }
  }
}

/// 扩展[Card]
class CardEx extends StatelessWidget {
  const CardEx({
    Key? key,
    required this.child,
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
    this.paddingSize,
    this.marginSize,
    this.shadowColor,
    required this.isChild,
    this.elevation,
    this.clipBehavior,
    this.semanticContainer = true,
    this.borderOnForeground = true,
    this.shape,
  }) : super(key: key);

  final EdgeInsets? margin;
  final EdgeInsets? padding;
  final Widget child;
  final Widget? center;
  final Widget? right;
  final Widget? left;
  final num? width;
  final num? height;
  final num? paddingSize;
  final num? marginSize;

  /// 阴影 默认false
  final bool shadow;
  final bool isChild;
  final bool borderOnForeground;
  final Clip? clipBehavior;
  final bool semanticContainer;
  final ShapeBorder? shape;
  final String? title;
  final String subTitle;
  final num? space;
  final num? elevation;
  final Color? backgroundColor;
  final Color? shadowColor;
  final Brightness? brightness;
  final Color? textColor;
  final Color? titleColor;
  final Color? subTitleColor;
  final Gradient? gradient;

  Widget _child(Color? titleColor, Color? subTitleColor) {
    Widget view;
    if (title.en || subTitle.en || center != null) {
      Widget center_ = TextRich(color: textColor, children: [
        RichTextItem(
          title ?? "",
          StyleText.one(
            weight: FontWeight.bold,
            color: titleColor,
            brightness: brightness,
          ),
        ),
        RichTextItem(title.e ? "" : "  $subTitle",
            StyleText.grey(size: 25, color: subTitleColor))
      ]);

      if (center != null) center_ = Row(children: <Widget>[center_, center!]);

      Widget space_ =
          Spacing.spacingView(height: space ?? FConfig.ins.listSpace);
      view = Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              Spacing.vView(isShow: left != null, child: () => left!),
              Spacing.vView(isShow: left != null, child: () => space_),
              Expanded(child: center_),
              Spacing.vView(isShow: right != null, child: () => space_),
              Spacing.vView(isShow: right != null, child: () => right!),
            ],
          ),
          space_,
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
    var themeData = Theme.of(context);
    var paddingS = paddingSize ?? FConfig.ins.cardExOfPaddingSize;
    var marginS = marginSize ?? FConfig.ins.cardExOfMarginSize;

    var padding_ = padding ?? Spacing.all(size: paddingS);
    var margin_ = margin ?? Spacing.all(size: marginS);
    Brightness brightness_ = brightness ?? themeData.brightness;

    Color? color =
        backgroundColor ?? CConfig.getBackground(brightness: brightness_);
    Color? titleColor_ = textColor ?? titleColor;
    Color? subTitleColor_ = textColor ?? subTitleColor;

    Widget childView = isChild ? child : _child(titleColor_, subTitleColor_);
    if (shadow) {
      color = backgroundColor ?? themeData.cardTheme.color;
      return Card(
        margin: margin_,
        color: color,
        shadowColor: shadowColor,
        elevation: elevation?.toDouble(),
        shape: shape,
        borderOnForeground: borderOnForeground,
        clipBehavior: clipBehavior,
        semanticContainer: semanticContainer,
        child: Padding(padding: padding_, child: childView),
      );
    } else {
      return Container(
        width: width?.toDouble(),
        height: height?.toDouble(),
        decoration: DecoUtil.normal(color: color, gradient: gradient),
        margin: margin_,
        child: Padding(padding: padding_, child: childView),
      );
    }
  }
}

/// 扩展模式， 加入自动配置背景色
class ContainerEx extends StatelessWidget {
  const ContainerEx({
    Key? key,
    this.color,
    this.child,
    this.alignment,
    this.padding,
    this.decoration,
    this.foregroundDecoration,
    this.constraints,
    this.margin,
    this.transform,
    this.clipBehavior = Clip.none,
    this.brightness,
    this.height,
    this.width,
    this.isSquare = false,
  })  : size = null,
        super(key: key);

  const ContainerEx.square({
    Key? key,
    required this.size,
    this.color,
    this.child,
    this.alignment,
    this.padding,
    this.decoration,
    this.foregroundDecoration,
    this.constraints,
    this.margin,
    this.transform,
    this.clipBehavior = Clip.none,
    this.brightness,
  })  : isSquare = true,
        height = null,
        width = null,
        super(key: key);

  final double? height;
  final double? width;
  final double? size;

  /// The [child] contained by the container.
  ///
  /// If null, and if the [constraints] are unbounded or also null, the
  /// container will expand to fill all available space in its parent, unless
  /// the parent provides unbounded constraints, in which case the container
  /// will attempt to be as small as possible.
  ///
  /// {@macro flutter.widgets.child}
  final Widget? child;

  /// Align the [child] within the container.
  ///
  /// If non-null, the container will expand to fill its parent and position its
  /// child within itself according to the given value. If the incoming
  /// constraints are unbounded, then the child will be shrink-wrapped instead.
  ///
  /// Ignored if [child] is null.
  ///
  /// See also:
  ///
  ///  * [Alignment], a class with convenient constants typically used to
  ///    specify an [AlignmentGeometry].
  ///  * [AlignmentDirectional], like [Alignment] for specifying alignments
  ///    relative to text direction.
  final AlignmentGeometry? alignment;

  /// Empty space to inscribe inside the [decoration]. The [child], if any, is
  /// placed inside this padding.
  ///
  /// This padding is in addition to any padding inherent in the [decoration];
  /// see [Decoration.padding].
  final EdgeInsetsGeometry? padding;

  /// The color to paint behind the [child].
  ///
  /// This property should be preferred when the background is a simple color.
  /// For other cases, such as gradients or images, use the [decoration]
  /// property.
  ///
  /// If the [decoration] is used, this property must be null. A background
  /// color may still be painted by the [decoration] even if this property is
  /// null.
  final Color? color;

  /// The decoration to paint behind the [child].
  ///
  /// Use the [color] property to specify a simple solid color.
  ///
  /// The [child] is not clipped to the decoration. To clip a child to the shape
  /// of a particular [ShapeDecoration], consider using a [ClipPath] widget.
  final Decoration? decoration;

  /// The decoration to paint in front of the [child].
  final Decoration? foregroundDecoration;

  /// Additional constraints to apply to the child.
  ///
  /// The constructor `width` and `height` arguments are combined with the
  /// `constraints` argument to set this property.
  ///
  /// The [padding] goes inside the constraints.
  final BoxConstraints? constraints;

  /// Empty space to surround the [decoration] and [child].
  final EdgeInsetsGeometry? margin;

  /// The transformation matrix to apply before painting the container.
  final Matrix4? transform;

  /// The clip behavior when [Container.decoration] has a clipPath.
  ///
  /// Defaults to [Clip.none].
  final Clip clipBehavior;
  final Brightness? brightness;

  /// 宽高适配一致 适合方形
  final bool isSquare;

  @override
  Widget build(BuildContext context) {
    Brightness brightness_ = brightness ?? Theme.of(context).brightness;
    Color? color_ = decoration != null
        ? null
        : (color ?? CConfig.getBackground(brightness: brightness_));

    return Container(
      color: color_,
      width: isSquare ? size.rr : width.ww,
      height: isSquare ? size.rr : height.hh,
      padding: padding,
      decoration: decoration,
      margin: margin,
      alignment: alignment,
      clipBehavior: clipBehavior,
      transform: transform,
      constraints: constraints,
      foregroundDecoration: foregroundDecoration,
      child: child,
    );
  }
}

/// 描述 左边标题  右边内容
class Describe extends StatelessWidget {
  const Describe({
    Key? key,
    required this.title,
    required this.data,
  })  : child = null,
        super(key: key);

  /// 自定义
  const Describe.custom({
    Key? key,
    required this.title,
    required this.child,
  })  : data = null,
        super(key: key);

  final String title;
  final String? data;
  final Widget? child;

  @override
  Widget build(BuildContext context) {
    Widget child_ = Spacing.vView();

    if (data.en) child_ = Text(data!);

    if (child != null) child_ = child!;

    return DefaultTextStyle(
      style: StyleText.normal(),
      child: Row(children: <Widget>[Text(title), Expanded(child: child_)]),
    );
  }
}

/// list 间距
class ListIntervalView extends StatelessWidget {
  const ListIntervalView({
    Key? key,
    this.direction = Axis.vertical,
    this.space,
    this.separator,
    this.height = 0,
    this.margin,
    this.physics,
    this.color,
    this.fullLine = true,
    this.primary = true,
    this.shrinkWrap = true,
    required this.itemCount,
    required this.itemBuilder,
    this.mainPadding,
    this.crossPadding,
    this.cacheExtent,
    this.controller,
    this.fullLineIgnoreOfIndex,
  })  : children = null,
        super(key: key);

  const ListIntervalView.children({
    Key? key,
    this.direction = Axis.vertical,
    this.space,
    this.separator,
    this.height = 0,
    this.margin,
    this.physics,
    this.color,
    this.fullLine = true,
    this.primary = true,
    this.shrinkWrap = true,
    required this.children,
    this.mainPadding,
    this.crossPadding,
    this.cacheExtent,
    this.controller,
    this.fullLineIgnoreOfIndex,
  })  : itemCount = children?.length,
        itemBuilder = null,
        super(key: key);

  const ListIntervalView.nested({
    Key? key,
    this.direction = Axis.vertical,
    this.space,
    this.separator,
    this.height = 0,
    this.margin,
    this.physics,
    this.color,
    this.fullLine = true,
    this.primary = false,
    this.shrinkWrap = true,
    required this.itemCount,
    required this.itemBuilder,
    this.mainPadding = 0,
    this.crossPadding = 0,
    this.cacheExtent,
    this.controller,
    this.fullLineIgnoreOfIndex,
  })  : children = null,
        super(key: key);

  final List<Widget>? children;
  final Axis direction;
  final Widget? separator;
  final num? space;
  final num? mainPadding;
  final num? crossPadding;

  final bool shrinkWrap;
  final num height;
  final num? cacheExtent;
  final EdgeInsets? margin;
  final int? itemCount;
  final IndexedWidgetBuilder? itemBuilder;

  final ScrollPhysics? physics;
  final Color? color;

  /// 整行 item 填充宽度
  final bool fullLine;

  /// 忽略的index  适用于 item 带[Expanded]
  final List<int>? fullLineIgnoreOfIndex;
  final bool primary;
  final ScrollController? controller;

  Widget _getSeparator(num size) {
    return separator ?? Spacing.spacingView(width: size, height: size);
  }

  Widget _getItem(BuildContext ctx, int index) {
    bool isChild = ListUtil.isNotEmpty(children);
    if (fullLine &&
        (fullLineIgnoreOfIndex == null ||
            !fullLineIgnoreOfIndex!.contains(index))) {
      return isChild ? children![index] : itemBuilder!(ctx, index);
    } else {
      return Row(
          children: [isChild ? children![index] : itemBuilder!(ctx, index)]);
    }
  }

  @override
  Widget build(BuildContext context) {
    bool isH = direction == Axis.horizontal;
    var cacheExtent_ = cacheExtent ?? FConfig.ins.listIntervalViewOfCacheExtent;

    var mp = mainPadding ?? FConfig.ins.mainPadding;
    var cp = crossPadding ?? FConfig.ins.crossPadding;
    var space_ = space ?? FConfig.ins.space;
    Widget separator = _getSeparator(space_);
    Widget view = ListView.separated(
      shrinkWrap: shrinkWrap,
      primary: primary,
      padding: Spacing.all(leftR: isH ? mp : cp, topB: isH ? cp : mp),
      physics: physics ?? const NeverScrollableScrollPhysics(),
      scrollDirection: direction,
      itemCount: itemCount!,
      itemBuilder: _getItem,
      controller: controller,
      separatorBuilder: (_, __) => separator,
      cacheExtent: cacheExtent_?.toDouble(),
    );

    if (isH || color != null) {
      var height_ = isH ? height.hh : null;
      view = Container(height: height_, color: color, child: view);
    }
    return view;
  }
}

class GridIntervalView extends StatelessWidget {
  const GridIntervalView({
    Key? key,
    this.direction,
    this.separator,
    this.mainSpace,
    this.crossSpace,
    this.mainPadding,
    this.crossPadding,
    this.height,
    this.width,
    this.color,
    this.shrinkWrap = false,
    this.primary = false,
    this.physics = const BouncingScrollPhysics(),
    required this.itemBuilder,
    this.ratio,
    required this.crossAxisCount,
    required this.itemCount,
    this.cacheExtent,
  })  : children = null,
        super(key: key);

  /// 嵌套的 不能滑动
  const GridIntervalView.nested({
    Key? key,
    this.direction,
    this.separator,
    this.mainSpace,
    this.crossSpace,
    this.ratio,
    this.mainPadding,
    this.crossPadding,
    this.height,
    this.width,
    this.color,
    this.shrinkWrap = true,
    this.primary = false,
    this.physics = const NeverScrollableScrollPhysics(),
    required this.crossAxisCount,
    required this.itemCount,
    required this.itemBuilder,
    this.cacheExtent,
  })  : children = null,
        super(key: key);

  /// 嵌套的 不能滑动
  const GridIntervalView.nestedChildren({
    Key? key,
    this.direction,
    this.separator,
    this.mainSpace,
    this.crossSpace,
    this.ratio,
    this.mainPadding,
    this.crossPadding,
    this.height,
    this.width,
    this.color,
    this.shrinkWrap = true,
    this.primary = false,
    this.physics = const NeverScrollableScrollPhysics(),
    required this.crossAxisCount,
    required this.children,
  })  : itemCount = children?.length,
        itemBuilder = null,
        cacheExtent = null,
        super(key: key);

  final IndexedWidgetBuilder? itemBuilder;
  final Axis? direction;
  final Widget? separator;
  final num? mainSpace;
  final num? crossSpace;
  final num? height;
  final num? width;

  /// padding top  bottom
  final num? mainPadding;
  final num? crossPadding;
  final num? cacheExtent;

  final int? itemCount;
  final int crossAxisCount;
  final num? ratio;
  final bool shrinkWrap;
  final bool primary;
  final Color? color;
  final ScrollPhysics physics;
  final List<Widget>? children;

  @override
  Widget build(BuildContext context) {
    bool isH = direction == Axis.horizontal;

    var mP = mainPadding ?? FConfig.ins.mainPadding;
    var cP = crossPadding ?? FConfig.ins.crossPadding;
    var mS = mainSpace ?? FConfig.ins.space;
    var cS = crossSpace ?? FConfig.ins.space;

    var padding = Spacing.all(leftR: isH ? mP : cP, topB: isH ? cP : mP);
    var cacheExtent_ = cacheExtent ?? FConfig.ins.gridIntervalViewOfCacheExtent;
    return Container(
      height: isH || height != null ? height.ww : null,
      width: width.ww,
      color: color,
      alignment: Alignment.topCenter,
      child: GridView.builder(
        shrinkWrap: shrinkWrap,
        primary: primary,
        itemCount: itemCount,
        physics: physics,
        padding: padding,
        itemBuilder: itemBuilder ?? (_, index) => children![index],
        cacheExtent: cacheExtent_?.toDouble(),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: crossAxisCount,
          childAspectRatio: ratio?.toDouble() ?? 1.0,
          mainAxisSpacing: mS.ww!,
          crossAxisSpacing: cS.ww!,
        ),
      ),
    );
  }
}

/// 单行 多用于单行item显示
class SingleLine<T> extends StatelessWidget {
  const SingleLine({
    Key? key,
    this.padding,
    required this.iconData,
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
    this.urlSize,
    this.decoration,
    this.minHeight,
    this.iconHeight,
    this.nameLeftPadding,
    this.nameRightPadding,
    this.backgroundColor,
    this.rightIconData,
    this.leftRight,
    this.topBottom,
    this.rightWidget,
    this.radius,
  })  : assert(name == null || nameWidget == null),
        assert(centerTxt == null || centerWidget == null),
        super(key: key);

  const SingleLine.normal({
    Key? key,
    this.padding,
    required this.name,
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
    this.urlSize,
    this.decoration,
    this.minHeight,
    this.iconHeight,
    this.nameLeftPadding,
    this.nameRightPadding,
    this.backgroundColor,
    this.rightIconData,
    this.leftRight,
    this.topBottom,
    this.rightWidget,
    this.radius,
  })  : assert(name == null || nameWidget == null),
        assert(centerTxt == null || centerWidget == null),
        super(key: key);

  const SingleLine.custom({
    Key? key,
    this.padding,
    required this.name,
    this.leftView,
    this.nameWidget,
    this.onDropdownChanged,
    this.dropdownItems,
    this.dropdownValue,
    this.nameTxtStyle,
    this.centerTxt,
    this.centerTxtStyle,
    required this.centerWidget,
    this.iconData,
    this.iconUrl,
    this.onTap,
    this.rightShow = false,
    this.isPrimary,
    this.rightTxt,
    this.rightTxtStyle,
    this.url,
    this.urlSize,
    this.decoration,
    this.minHeight,
    this.iconHeight,
    this.nameLeftPadding,
    this.nameRightPadding,
    this.backgroundColor,
    this.rightIconData,
    this.leftRight,
    this.topBottom,
    this.rightWidget,
    this.radius,
  })  : assert(name == null || nameWidget == null),
        assert(centerTxt == null || centerWidget == null),
        super(key: key);

  const SingleLine.dropdown({
    Key? key,
    this.padding,
    required this.name,
    required this.onDropdownChanged,
    required this.dropdownItems,
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
    this.urlSize,
    this.decoration,
    this.minHeight,
    this.iconHeight,
    this.nameLeftPadding,
    this.nameRightPadding,
    this.backgroundColor,
    this.rightIconData,
    this.leftRight,
    this.topBottom,
    this.radius,
  })  : assert(name == null || nameWidget == null),
        assert(centerTxt == null || centerWidget == null),
        rightWidget = null,
        super(key: key);

  final String? name;
  final TextStyle? nameTxtStyle;
  final Widget? nameWidget;
  final Widget? leftView;
  final String? iconUrl;
  final IconData? iconData;
  final TouchTap? onTap;
  final Color? backgroundColor;
  final bool? isPrimary;
  final bool rightShow;
  final IconData? rightIconData;
  final num? minHeight;
  final num? iconHeight;
  final num? leftRight;
  final num? radius;
  final num? topBottom;
  final num? nameLeftPadding;
  final num? nameRightPadding;
  final String? centerTxt;
  final TextStyle? centerTxtStyle;
  final Widget? centerWidget;
  final Widget? rightWidget;
  final String? rightTxt;
  final TextStyle? rightTxtStyle;
  final String? url;
  final num? urlSize;
  final EdgeInsets? padding;
  final Decoration? decoration;
  final List<DropdownMenuItem<T>>? dropdownItems;
  final ValueChanged<T>? onDropdownChanged;
  final T? dropdownValue;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final IconThemeData iconThemeData = IconTheme.of(context);
    Color? bg =
        backgroundColor ?? CConfig.cBackgroundColor ?? theme.backgroundColor;
    Color iconColor = iconThemeData.color!;
    var minH = minHeight ?? FConfig.ins.singleLineOfMinHeight;
    var iconH = iconHeight ?? FConfig.ins.singleLineOfIconHeight;
    var nameLeftP = nameLeftPadding ?? FConfig.ins.singleLineOfNameLeftPadding;
    var nameRightP =
        nameRightPadding ?? FConfig.ins.singleLineOfNameRightPadding;
    var isPrimary_ = isPrimary ?? FConfig.ins.singleLineOfIsPrimary;
    var rightIconData_ = rightIconData ?? FConfig.ins.singleLineOfRightIconData;
    var rightColor_ = isPrimary_ ? theme.primaryColor : iconColor;

    var leftR = leftRight ?? FConfig.ins.singleLineOfLeftRight;
    var topB = topBottom ?? FConfig.ins.singleLineOfTopBottom;
    var urlSize_ = urlSize ?? FConfig.ins.singleLineOfUrlSize;
    var radius_ = radius ?? FConfig.ins.singleLineOfRadius;
    var width_ = FConfig.ins.pageWidth;
    var decoration_ = decoration ?? DecoUtil.normal(color: bg, radius: radius_);
    var nameStyle = nameTxtStyle ??
        FConfig.ins.singleLineOfNameTxtStyle ??
        StyleText.normal();
    return TouchWidget(
      onTap: onTap,
      child: ConstrainedBox(
        constraints: BoxConstraints(
            minHeight: minH.hh!, maxWidth: (width_ - leftR * 2).ww!),
        child: Container(
          padding: padding ?? Spacing.all(leftR: leftR, topB: topB),
          decoration: decoration_,
          child: Row(children: <Widget>[
            _icon(iconColor, iconH, nameLeftP),
            _name(nameRightP, nameStyle),
            _center(),
            _dropdown(bg),
            ..._right(urlSize_, rightColor_, rightIconData_),
          ]),
        ),
      ),
    );
  }

  Widget _icon(Color iconColor, num iconHeight, num nameLeftPadding) {
    Widget? view = leftView;

    if (view == null) {
      if (iconUrl.en) {
        view = WrapperImage.size(
            size: iconHeight.ww!, url: iconUrl!, fit: BoxFit.contain);
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

  Widget _name(num nameRightPadding, TextStyle style) {
    var leftChild = nameWidget ?? Text(name!, style: style);
    return Container(
      margin: Spacing.leftOrRight(size: nameRightPadding, isLeft: false),
      child: leftChild,
    );
  }

  Widget _center() {
    if (centerWidget != null) {
      return Expanded(child: centerWidget!);
    } else if (centerTxt.e && ListUtil.isEmpty(dropdownItems)) {
      return Expanded(child: Spacing.vView());
    } else {
      return Spacing.vView(
        isShow: centerTxt.en,
        child: () =>
            Text(centerTxt!, style: centerTxtStyle ?? StyleText.grey()),
      );
    }
  }

  Widget _dropdown(Color bg) {
    return Spacing.vView(
      isShow: ListUtil.isNotEmpty(dropdownItems),
      child: () {
        ValueNotifier<T> cause = ValueNotifier(dropdownValue as T);
        return Expanded(
          child: ValueListenableBuilder<T>(
            valueListenable: cause,
            builder: (_, value, __) {
              return Material(
                color: bg,
                child: DropdownButton<T>(
                  value: value,
                  isExpanded: true,
                  isDense: true,
                  style: centerTxtStyle ?? StyleText.two(),
                  items: dropdownItems,
                  underline: const SizedBox(),
                  onChanged: (value) {
                    cause.value = value as T;
                    onDropdownChanged!(value);
                  },
                ),
              );
            },
          ),
        );
      },
    );
  }

  List<Widget> _right(num urlSize, Color rightColor, IconData rightIconData) {
    return [
      Spacing.vView(
        isShow: url.en,
        child: () => ClipRRect(
          borderRadius: SBorderRadius.circle(),
          child: WrapperImage.size(size: urlSize.ww!, url: url!),
        ),
      ),
      Spacing.vView(
        isShow: rightTxt.en,
        child: () => Text(rightTxt!, style: rightTxtStyle ?? StyleText.grey()),
      ),
      Spacing.vView(
        isShow: rightShow,
        child: () => PSDisplay(
            primary: () => rightWidget,
            secondary: () => Icon(rightIconData, color: rightColor)),
      ),
    ];
  }
}
