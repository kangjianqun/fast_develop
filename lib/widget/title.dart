import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:fast_mvvm/fast_mvvm.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

import '../fast_develop.dart';

/// 生成
typedef IconThemeGenerate = IconThemeData Function(
    {Brightness brightness, Color color});
typedef TextThemeGenerate = TextTheme Function(
    {Brightness brightness, Color color});

IconThemeGenerate _iconThemeGenerate;
TextThemeGenerate _textThemeGenerate;

initFastDevelopOfTitle(IconThemeGenerate? iconThemeGenerate,
    TextThemeGenerate? textThemeGenerate) {
  if (iconThemeGenerate != null) _iconThemeGenerate = iconThemeGenerate;
  if (textThemeGenerate != null) _textThemeGenerate = textThemeGenerate;
}

class TitleAction extends StatelessWidget {
  const TitleAction({
    Key key,
    this.onTap,
    this.iconData,
    this.imgUrl,
    this.txt,
    this.color,
    this.child,
    this.textStyle,
  })  : assert(iconData == null || imgUrl == null),
        this.negative = null,
        super(key: key);

  const TitleAction.all({
    Key key,
    @required this.onTap,
    @required this.iconData,
    @required this.txt,
    this.imgUrl,
    this.color,
    this.child,
    this.textStyle,
  })  : assert(iconData == null || imgUrl == null),
        this.negative = null,
        super(key: key);

  /// 强调
  const TitleAction.stress({
    Key key,
    this.onTap,
    this.iconData,
    this.imgUrl,
    this.txt,
    this.color,
    this.child,
    this.textStyle,
  })  : assert(iconData == null || imgUrl == null),
        this.negative = false,
        super(key: key);

  /// 消极
  const TitleAction.negative({
    Key key,
    this.onTap,
    this.iconData,
    this.imgUrl,
    this.txt,
    this.color,
    this.child,
    this.textStyle,
  })  : assert(iconData == null || imgUrl == null),
        this.negative = true,
        super(key: key);

  final TouchTap onTap;
  final IconData iconData;
  final String imgUrl;
  final String txt;
  final Widget child;
  final Color color;
  final bool negative;
  final TextStyle textStyle;

  @override
  Widget build(BuildContext context) {
    return TouchWidget(onTap: onTap, child: child ?? _child(context));
  }

  Widget _child(BuildContext context) {
    if (iconData != null && txt.en) {
      return IconText.simple(
        iData: iconData,
        size: 72,
        data: txt,
        color: CConfig.textColorThree,
        textSize: 25,
      );
    }

    if (iconData != null) {
      return Container(
        padding: Spacing.all(),
        child: IconText.img(icon: Icon(iconData, size: 30)),
      );
    }

    if (txt.en) {
      bool _stress = negative != null && !negative;
      var _color = color ??
          (_stress ? Theme.of(context).primaryColor : CConfig.negativeColor);
      return Container(
        margin: Spacing.topAndBottom(size: 32),
        padding: Spacing.all(leftR: 48),
        decoration:
            _stress ? DecoUtil.normal(isCircle: true, color: _color) : null,
        alignment: Alignment.center,
        child: Text(
          txt,
          style: textStyle ??
              (_stress
                  ? StyleText.white(size: 32)
                  : StyleText.three(color: color)),
        ),
      );
    }
    return Container();
  }
}

class TitleVM extends BaseViewModel {
  String _title = "";

  get title => _title;

  setTitle(String title, {notify = true, bool allowNull = false}) {
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
    Key key,
    this.title,
    this.titleIsCenter = false,
    this.backgroundColor,
    this.actions,
    this.actionSpacing,
    this.tWidget,
    this.height,
    this.brightness,
  }) : super(key: key);

  final num height;
  final num actionSpacing;
  final String title;
  final Widget tWidget;
  final bool titleIsCenter;
  final Color backgroundColor;
  final List<Widget> actions;
  final Brightness brightness;

  @override
  Size get preferredSize => Size.fromHeight(
      (height ?? FastDevelopConfig.instance.titleWidgetOfHeight).sh);

  @override
  Widget build(BuildContext context) {
    var _actionSpacing =
        actionSpacing ?? FastDevelopConfig.instance.titleWidgetOfActionSpacing;
    getVM<TitleVM>(context)
        .setTitle(title, notify: false, allowNull: tWidget != null);
    var iconTheme =
        brightness == null ? null : _iconThemeGenerate(brightness: brightness);
    var textTheme =
        brightness == null ? null : _textThemeGenerate(brightness: brightness);
    return Consumer<TitleVM>(
      builder: (_, titleVm, __) {
//        LogUtil.printLog("titleTxtNameChanger: ${titleVm.title}");
        List<Widget> actionChild;
        if (actions != null) {
          actionChild = [];
          actionChild.addAll(actions);
          actionChild.add(Spacing.spacingView(width: _actionSpacing));
        }

        Widget view = AppBar(
          brightness: brightness,
          iconTheme: iconTheme,
          textTheme: textTheme,
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
