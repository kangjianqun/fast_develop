import 'package:fast_router/fast_router.dart';
import 'package:flutter/material.dart';

import '../fast_develop.dart';

Set<String> _dict = {};
bool _loadStatue = false;

class DialogSimple {
  static const String _s = "临时弹窗";

  static showS() => show(_s);

  static closeS() => close(_s);

  static show(String url, {String? content}) {
    _dict.add(url);
    if (_loadStatue || _dict.length >= 2) {
      return;
    }
    _loadStatue = true;
    showDialogCustom(
      context: FConfig.ins.context!,
      barrierDismissible: false,
      builder: (_) => WillPopScope(
        onWillPop: () async => false,
        child: const DialogView.load(content: "加载中"),
      ),
    );
  }

  static close(String url, {bool clear = false}) {
//    Navigator.of(context, rootNavigator: true).pop();
    if (clear) {
      _dict.clear();
    } else {
      _dict.remove(url);
    }

    if (_dict.isEmpty && _loadStatue) {
      _loadStatue = false;
      tryCatch(() => FastRouter.popBackDialog(FConfig.ins.context!));
    }
  }
}

class NameFunction {
  String name;
  GestureTapCallback? function;

  NameFunction(this.name, this.function);
}

class DialogListSelect extends StatelessWidget {
  const DialogListSelect({
    Key? key,
    required this.children,
    this.color,
    this.margin,
    this.wirePadding,
    this.paddingChild,
  }) : super(key: key);

  final List<NameFunction> children;
  final Color? color;
  final num? wirePadding;
  final num? paddingChild;
  final EdgeInsetsGeometry? margin;

  @override
  Widget build(BuildContext context) {
    var paddingChild_ =
        paddingChild ?? FConfig.ins.dialogListSelectOfPaddingChild;
    var wireP = wirePadding ?? FConfig.ins.dialogListSelectOfWirePadding;
    List<Widget> view = [];
    children.add(NameFunction("取消", null));
    for (var item in children) {
      view.add(
        Button(
          size: null,
          paddingInside: Spacing.all(size: 0),
          paddingChild: paddingChild_,
          onTap: (_) {
            FastRouter.popBack();
            if (item.function != null) item.function!();
          },
          child: Center(child: Text(item.name)),
        ),
      );
      if (children.indexOf(item) < children.length - 1) {
        view.add(Spacing.wireView2(w: width - wireP));
      }
    }
    return DialogCustom.body(
      color: CConfig.getBackground(color: color),
      rootMargin: margin,
      children: view,
    );
  }
}

class DialogView extends Dialog {
  const DialogView({
    Key? key,
    required child,
    this.isShowTitle = false,
    this.isConfirm = false,
    this.isLoad = false,
    this.fullScreen = true,
    this.content,
    this.title = "温馨提示",
    this.okHint = "确定",
    this.noHint = "取消",
    this.onOk,
    this.onNo,
    this.expanded = false,
    backgroundColor,
    this.confirmHeight,
    this.titleHeight,
    this.horizontal,
    this.vertical,
    this.minHeight,
    this.titleSize,
    this.textSize,
    this.loadWidth,
    this.loadTop,
    this.top,
    insetAnimationCurve = Curves.decelerate,
    insetAnimationDuration = const Duration(milliseconds: 100),
  }) : super(
          key: key,
          backgroundColor: backgroundColor,
          child: child,
          insetAnimationCurve: insetAnimationCurve,
          insetAnimationDuration: insetAnimationDuration,
        );

  /// 显示确定与取消
  const DialogView.confirm({
    Key? key,
    child,
    this.isShowTitle = true,
    this.isConfirm = true,
    this.isLoad = false,
    this.fullScreen = false,
    this.title = "温馨提示",
    this.okHint = "确定",
    this.noHint = "取消",
    required this.content,
    required this.onOk,
    this.onNo,
    this.expanded = false,
    backgroundColor,
    this.confirmHeight,
    this.titleHeight,
    this.horizontal,
    this.vertical,
    this.minHeight,
    this.titleSize,
    this.textSize,
    this.loadWidth,
    this.loadTop,
    this.top,
    insetAnimationCurve = Curves.decelerate,
    insetAnimationDuration = const Duration(milliseconds: 100),
  }) : super(
          key: key,
          backgroundColor: backgroundColor,
          child: child,
          insetAnimationCurve: insetAnimationCurve,
          insetAnimationDuration: insetAnimationDuration,
        );

  /// 显示标题 内容
  const DialogView.hint({
    Key? key,
    child,
    this.isShowTitle = true,
    this.isConfirm = false,
    this.isLoad = false,
    this.fullScreen = false,
    this.title = "温馨提示",
    this.okHint = "确定",
    this.noHint = "取消",
    required this.content,
    this.onOk,
    this.onNo,
    this.expanded = false,
    backgroundColor,
    this.confirmHeight,
    this.titleHeight,
    this.horizontal,
    this.vertical,
    this.minHeight,
    this.titleSize,
    this.textSize,
    this.loadWidth,
    this.loadTop,
    this.top,
    insetAnimationCurve = Curves.decelerate,
    insetAnimationDuration = const Duration(milliseconds: 100),
  }) : super(
          key: key,
          backgroundColor: backgroundColor,
          child: child,
          insetAnimationCurve: insetAnimationCurve,
          insetAnimationDuration: insetAnimationDuration,
        );

  ///
  const DialogView.load({
    Key? key,
    child = const CircularProgressIndicator(),
    this.isShowTitle = false,
    this.isConfirm = false,
    this.isLoad = true,
    this.fullScreen = false,
    this.title,
    this.okHint,
    this.noHint,
    this.content = "加载中",
    this.onOk,
    this.onNo,
    this.expanded = false,
    backgroundColor,
    this.confirmHeight,
    this.titleHeight,
    this.horizontal,
    this.vertical,
    this.minHeight,
    this.titleSize,
    this.textSize,
    this.loadWidth,
    this.loadTop,
    this.top,
    insetAnimationCurve = Curves.decelerate,
    insetAnimationDuration = const Duration(milliseconds: 100),
  }) : super(
          key: key,
          backgroundColor: backgroundColor,
          child: child,
          insetAnimationCurve: insetAnimationCurve,
          insetAnimationDuration: insetAnimationDuration,
        );

  final bool isShowTitle;
  final bool isConfirm;
  final bool isLoad;
  final bool fullScreen;
  final bool expanded;
  final String? title;
  final String? content;
  final String? okHint;
  final String? noHint;
  final num? confirmHeight;
  final num? titleHeight;
  final num? horizontal;
  final num? vertical;
  final num? minHeight;
  final num? titleSize;
  final num? textSize;
  final num? loadWidth;
  final num? loadTop;
  final num? top;

  final TouchTap? onOk;
  final TouchTap? onNo;

  Widget _confirm(BuildContext context, num height) {
    return SizedBox(
      height: height.hh,
      child: Row(children: <Widget>[
        Expanded(
          child: TouchWidget(
            onTap: (_) {
              FastRouter.popBack();
              if (onOk != null) onOk!(context);
            },
            child: Container(
              alignment: Alignment.center,
              child: Text(okHint ?? ""),
            ),
          ),
        ),
        Spacing.wireView(isH: false),
        Expanded(
          child: TouchWidget(
            onTap: (_) {
              FastRouter.popBack();
              if (onNo != null) onNo!(context);
            },
            child: Container(
              alignment: Alignment.center,
              child: Text(noHint ?? ""),
            ),
          ),
        ),
      ]),
    );
  }

  Widget _title(num height, titleSize) {
    return Container(
      height: height.hh,
      alignment: Alignment.center,
      child: Text(title ?? "", style: StyleText.one(size: titleSize)),
    );
  }

  Widget _defaultTxt(num minHeight) {
    Widget view = ConstrainedBox(
      constraints: BoxConstraints(minHeight: minHeight.hh!),
      child: ListIntervalView.children(
        physics: const BouncingScrollPhysics(),
        children: [
          Container(
            margin: Spacing.topAndBottom(size: 32),
            padding: Spacing.leftAndRight(size: 64),
            alignment: Alignment.center,
            child: Text(content ?? ""),
          ),
        ],
      ),
    );
    if (expanded) view = Expanded(child: view);
    return view;
  }

  @override
  Widget build(BuildContext context) {
//    LogUtil.printLog(onOk);
    if (fullScreen) return child!;

    final DialogTheme dialogTheme = DialogTheme.of(context);
    var height = confirmHeight ?? FConfig.ins.dialogViewOfConfirmHeight;
    var titleHeight = confirmHeight ?? FConfig.ins.dialogViewOfTitleHeight;
    var horizontal_ = horizontal ?? FConfig.ins.dialogViewOfHorizontal;
    var vertical_ = vertical ?? FConfig.ins.dialogViewOfVertical;
    var titleSize_ = titleSize ?? FConfig.ins.dialogViewOfTitleSize;
    var textSize_ = textSize ?? FConfig.ins.dialogViewOfTextSize;
    var minHeight_ = minHeight ?? FConfig.ins.dialogViewOfTitleSize;
    var loadWidth_ = loadWidth ?? FConfig.ins.dialogViewOfLoadWidth;
    var loadTop_ = loadTop ?? FConfig.ins.dialogViewOfLoadTop;
    var top_ = top ?? FConfig.ins.dialogViewOfTop;

    var view = child ?? _defaultTxt(minHeight_);

    return AnimatedContainer(
      padding: MediaQuery.of(context).viewInsets +
          EdgeInsets.symmetric(
              horizontal: horizontal_.ww!, vertical: vertical_.hh!),
      duration: insetAnimationDuration,
      curve: insetAnimationCurve,
      child: MediaQuery.removeViewInsets(
        removeLeft: true,
        removeTop: true,
        removeRight: true,
        removeBottom: true,
        context: context,
        child: DefaultTextStyle(
          style: StyleText.normal(size: textSize_),
          child: Container(
            padding: Spacing.topOrBottom(size: isLoad ? loadTop_ : top_),
            width: isLoad ? loadWidth_.ww : null,
            decoration: BoxDecoration(
              color: backgroundColor ??
                  dialogTheme.backgroundColor ??
                  Theme.of(context).dialogBackgroundColor,
              borderRadius: SBorderRadius.normal(),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Spacing.vView(
                  isShow: isShowTitle,
                  child: () => _title(titleHeight, titleSize_),
                ),
                view,
                Spacing.vView(
                  isShow: child != null && content != null,
                  child: () => _defaultTxt(minHeight_),
                ),
                Spacing.vView(
                  isShow: isConfirm,
                  child: () => Spacing.wireView(),
                ),
                Spacing.vView(
                  isShow: isConfirm,
                  child: () => _confirm(context, height),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class DialogCustom extends StatelessWidget {
  const DialogCustom({
    Key? key,
    required this.name,
    required this.height,
    this.margin = 32,
    this.color,
    this.decoration,
    this.operate,
    this.children,
    this.rootMargin,
  })  : isBody = false,
        super(key: key);

  /// 只有中间可以滑动的部分
  const DialogCustom.body({
    Key? key,
    this.height,
    this.margin = 0,
    this.color,
    this.decoration,
    this.children,
    this.rootMargin,
  })  : name = null,
        operate = null,
        isBody = true,
        super(key: key);

  final bool isBody;
  final double? height;
  final int margin;
  final Decoration? decoration;
  final Color? color;
  final String? name;
  final Widget? operate;
  final List<Widget>? children;

  final EdgeInsetsGeometry? rootMargin;

  Widget _title() {
    return Container(
      width: width.ww,
      margin: Spacing.all(size: margin),
      child: Stack(
        children: <Widget>[
          Container(
            alignment: Alignment.center,
            child: Text(name!, style: StyleText.normal(size: 48)),
          ),
          Positioned(
            right: 0,
            child: Button.img(
              onTap: (_) => FastRouter.popBack(),
              icon: Icons.close,
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    Widget body;

    if (isBody) {
      body =
          Center(child: easyRefreshList(children: children!, shrinkWrap: true));
    } else {
      body = Column(
        children: <Widget>[
          Spacing.vView(isShow: name.en, child: () => _title()),
          Expanded(
            child: Container(
              margin: Spacing.all(size: margin),
              child: easyRefreshList(children: children!),
            ),
          ),
          Spacing.vView(isShow: operate != null, child: () => operate!),
        ],
      );
    }

    return Container(
      height: height.ww,
      margin: rootMargin,
      decoration: decoration ??
          DecoUtil.unilateral(1,
              color: color ?? CConfig.cScaffoldBackgroundColor),
      child: body,
    );
  }
}

Widget _buildMaterialDialogTransitions(
  BuildContext context,
  Animation<double> animation,
  Animation<double> secondaryAnimation,
  Widget child,
) {
  return FadeTransition(
    opacity: CurvedAnimation(
      parent: animation,
      curve: Curves.easeOut,
    ),
    child: child,
  );
}

enum Location { left, right, top, bottom, center }

typedef OffsetHandle = Offset Function(Animation animation);

RouteTransitionsBuilder offsetAnim(OffsetHandle oh) {
  return (_, animation, __, child) {
    return FractionalTranslation(translation: oh(animation), child: child);
  };
}

Offset fromLeft(Animation animation) => Offset(animation.value - 1, 0);

Offset fromRight(Animation animation) =>
    Offset(valueByType(1 - animation.value, double), 0);

Offset fromTop(Animation animation) => Offset(0, animation.value - 1);

Offset fromBottom(Animation animation) =>
    Offset(0, valueByType(1 - animation.value, double));

Offset fromTopLeft(Animation anim) => fromLeft(anim) + fromTop(anim);

/// [cushion] 垫层  [offset]偏移值
Future<T?> showDialogCustom<T>({
  required BuildContext context,
  required WidgetBuilder builder,
  Duration? duration,
  Color barrierColor = Colors.black54,
  bool barrierDismissible = true,
  bool cushion = true,
  double offset = 0,
  Location location = Location.center,
  OffsetHandle? offsetHandle,
  TextStyle? style,
}) {
  assert(debugCheckHasMaterialLocalizations(context));
  var targetContext = context;
//  final ThemeData theme = Theme.of(context, shadowThemeOnly: true);

  var transition = offsetHandle == null ? null : offsetAnim(offsetHandle);

  return showGeneralDialog(
    context: context,
    barrierColor: barrierColor,
    barrierDismissible: barrierDismissible,
    barrierLabel: MaterialLocalizations.of(context).modalBarrierDismissLabel,
    transitionDuration: duration ?? const Duration(milliseconds: 200),
    transitionBuilder: transition ?? _buildMaterialDialogTransitions,
    pageBuilder: (
      BuildContext buildContext,
      Animation<double> animation,
      Animation<double> secondaryAnimation,
    ) {
      final Widget pageChild = Builder(
        builder: (context) => DefaultTextStyle(
          style: style ?? StyleText.normal(),
          child: builder(context),
        ),
      );

      return Builder(
        builder: (BuildContext context) {
          if (transition != null) {
            switch (location) {
              case Location.center:
                return pageChild;

              case Location.left:
              case Location.right:
                return Row(
                  children: <Widget>[Spacing.fillView(), pageChild],
                );
              case Location.top:
                return Column(
                  children: <Widget>[pageChild, Spacing.fillView()],
                );
              case Location.bottom:
                return Column(
                  children: <Widget>[Spacing.fillView(), pageChild],
                );
            }
          }

          RenderBox renderBox = targetContext.findRenderObject() as RenderBox;
          Offset boxOffset = renderBox.localToGlobal(Offset.zero);
          double left = 0;
          double top = 0;
          switch (location) {
            case Location.center:
              return Container(
                alignment: Alignment.center,
                child: pageChild,
              );
            case Location.left:
              left = boxOffset.dx + offset;
              break;
            case Location.right:
              left = boxOffset.dx + renderBox.size.width + offset;
              break;
            case Location.top:
              top = boxOffset.dy + offset;
              break;
            case Location.bottom:
              top = boxOffset.dy + renderBox.size.height + offset;
              break;
          }

          /// 判断是否需要自己设置灰色阴影层 并点击关闭dialog
          Widget _child() {
            if (location == Location.center) {
              return pageChild;
            } else {
              return Stack(
                children: <Widget>[
                  Spacing.vView(
                    isShow: cushion,
                    child: () => TouchWidget(
                      pressedOpacity: 0,
                      onTap: (_) => FastRouter.popBack(),
                      child: Container(color: Colors.black54),
                    ),
                  ),
                  pageChild,
                ],
              );
            }
          }

          return Container(
            padding: EdgeInsets.fromLTRB(left, top, 0, 0),
            child: _child(),
          );
        },
      );
    },
  );
}
