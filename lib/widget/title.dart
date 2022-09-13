import 'package:flutter/material.dart';
import 'package:fast_mvvm/fast_mvvm.dart';
import 'package:provider/provider.dart';

import '../fast_develop.dart';

/// 生成
typedef IconThemeGenerate = IconThemeData Function(
    {Brightness brightness, Color color});
typedef TextThemeGenerate = TextTheme Function(
    {Brightness brightness, Color color});

IconThemeGenerate? _iconThemeGenerate;
TextThemeGenerate? _textThemeGenerate;

initFastDevelopOfTitle(IconThemeGenerate? iconThemeGenerate,
    TextThemeGenerate? textThemeGenerate) {
  if (iconThemeGenerate != null) _iconThemeGenerate = iconThemeGenerate;
  if (textThemeGenerate != null) _textThemeGenerate = textThemeGenerate;
}

class TitleAction extends StatelessWidget {
  const TitleAction({
    Key? key,
    this.onTap,
    this.iconData,
    this.imgUrl,
    this.txt,
    this.color,
    this.child,
    this.textStyle,
    this.txtSize,
    this.iconSize,
    this.iconPadding,
    this.leftRSize,
    this.topAndBottomSize,
  })  : assert(iconData == null || imgUrl == null),
        negative = null,
        super(key: key);

  const TitleAction.all({
    Key? key,
    required this.onTap,
    required this.iconData,
    required this.txt,
    this.imgUrl,
    this.color,
    this.child,
    this.textStyle,
    this.txtSize,
    this.iconSize,
    this.iconPadding,
    this.leftRSize,
    this.topAndBottomSize,
  })  : assert(iconData == null || imgUrl == null),
        negative = null,
        super(key: key);

  /// 强调
  const TitleAction.stress({
    Key? key,
    this.onTap,
    this.iconData,
    this.imgUrl,
    this.txt,
    this.color,
    this.child,
    this.textStyle,
    this.txtSize,
    this.iconSize,
    this.iconPadding,
    this.leftRSize,
    this.topAndBottomSize,
  })  : assert(iconData == null || imgUrl == null),
        negative = false,
        super(key: key);

  /// 消极
  const TitleAction.negative({
    Key? key,
    this.onTap,
    this.iconData,
    this.imgUrl,
    this.txt,
    this.color,
    this.child,
    this.textStyle,
    this.txtSize,
    this.iconSize,
    this.iconPadding,
    this.leftRSize,
    this.topAndBottomSize,
  })  : assert(iconData == null || imgUrl == null),
        negative = true,
        super(key: key);

  final TouchTap? onTap;
  final IconData? iconData;
  final double? iconSize;
  final num? iconPadding;
  final num? leftRSize;
  final num? topAndBottomSize;
  final String? imgUrl;
  final String? txt;
  final double? txtSize;
  final Widget? child;
  final Color? color;
  final bool? negative;
  final TextStyle? textStyle;

  @override
  Widget build(BuildContext context) {
    return TouchWidget(onTap: onTap, child: child ?? _child(context));
  }

  Widget _child(BuildContext context) {
    var iconSize_ = iconSize ?? FConfig.ins.titleActionOfIconSize;
    if (iconData != null && txt.en) {
      return IconText.simple(
        iData: iconData,
        size: iconSize_,
        data: txt,
        color: CConfig.textColorThree,
        textSize: txtSize ?? FConfig.ins.titleActionOfTxtSize,
      );
    }

    if (iconData != null) {
      var padding = iconPadding ?? FConfig.ins.titleActionOfIconPadding;
      return Container(
        padding: Spacing.all(size: padding),
        child: IconText.img(icon: Icon(iconData, size: iconSize_)),
      );
    }

    if (txt.en) {
      bool stress = negative != null && !negative!;
      var color_ = color ??
          (stress ? Theme.of(context).primaryColor : CConfig.negativeColor);
      var deco = stress ? DecoUtil.normal(isCircle: true, color: color_) : null;
      var leftR = leftRSize ?? FConfig.ins.titleActionOfLeftRSize;
      var topB = leftRSize ?? FConfig.ins.titleActionOfTopBSize;
      return Container(
        margin: Spacing.topAndBottom(size: topB),
        padding: Spacing.all(leftR: leftR),
        decoration: deco,
        alignment: Alignment.center,
        child: Text(
          txt!,
          style: textStyle ??
              (stress ? StyleText.white() : StyleText.three(color: color)),
        ),
      );
    }
    return Container();
  }
}

class TitleVM extends BaseViewModel {
  String _title = "";

  get title => _title;

  setTitle(String? title, {notify = true, bool allowNull = false}) {
    if (!allowNull && title.e || title == _title) {
      return;
    }
    _title = title ?? "";
    if (notify) {
      notifyListeners();
    }
  }
}

class TitleWidget extends StatelessWidget implements PreferredSizeWidget {
  const TitleWidget({
    Key? key,
    this.title,
    this.titleIsCenter = false,
    this.backgroundColor,
    this.actions,
    this.actionSpacing,
    this.tWidget,
    this.height,
    this.brightness,
  }) : super(key: key);

  final num? height;
  final num? actionSpacing;
  final String? title;
  final Widget? tWidget;
  final bool? titleIsCenter;
  final Color? backgroundColor;
  final List<Widget>? actions;
  final Brightness? brightness;

  @override
  Size get preferredSize =>
      Size.fromHeight((height ?? FConfig.ins.titleWidgetOfHeight).hh!);

  @override
  Widget build(BuildContext context) {
    var actionS = actionSpacing ?? FConfig.ins.titleWidgetOfActionSpacing;
    getVM<TitleVM>(context)
        .setTitle(title, notify: false, allowNull: tWidget != null);
    var iconTheme = brightness == null || _iconThemeGenerate == null
        ? null
        : _iconThemeGenerate!(brightness: brightness!);
    var textTheme = brightness == null || _textThemeGenerate == null
        ? null
        : _textThemeGenerate!(brightness: brightness!);
    return Consumer<TitleVM>(
      builder: (_, titleVm, __) {
        // printLog("titleTxtNameChanger: ${titleVm.title}");
        List<Widget>? actionChild;
        if (ListUtil.isNotEmpty(actions)) {
          actionChild = [];
          actionChild.addAll(actions!);
          actionChild.add(Spacing.spacingView(width: actionS));
        }

        Widget view = AppBar(
          centerTitle: titleIsCenter,
          title: tWidget ?? Text(titleVm.title),
          backgroundColor: backgroundColor,
          actions: actionChild,
        );

        return view;
      },
    );
  }
}
