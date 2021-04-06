import 'package:fast_router/fast_router.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../fast_develop.dart';

Set<String> _dict = Set();
bool _loadStatue = false;

class DialogSimple {
  static String _s = "临时弹窗";

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
        child: DialogView.load(content: "加载中"),
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

    if (_dict.length == 0 && _loadStatue) {
      _loadStatue = false;
      tryCatch(
          () => FastRouter.popBackDialog(FConfig.ins.context!));
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
  }) : super(key: key);

  final List<NameFunction> children;
  final Color? color;
  final EdgeInsetsGeometry? margin;

  @override
  Widget build(BuildContext context) {
    List<Widget> _view = [];
    children.add(NameFunction("取消", null));
    children.forEach((item) {
      _view.add(
        Button(
          size: null,
          paddingInside: Spacing.all(size: 0),
          paddingChild: 56,
          onTap: (_) {
            FastRouter.popBack();
            if (item.function != null) item.function!();
          },
          child: Center(child: Text(item.name)),
        ),
      );
      if (children.indexOf(item) < children.length - 1)
        _view.add(Spacing.wireView2(w: width - 160));
    });
    return DialogCustom.body(
      color: CConfig.getBackground(color: color),
      children: _view,
      rootMargin: margin,
    );
  }
}

class DialogView extends Dialog {
  const DialogView({
    Key? key,
    required this.child,
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
    this.backgroundColor,
    this.insetAnimationCurve = Curves.decelerate,
    this.insetAnimationDuration = const Duration(milliseconds: 100),
  }) : super(key: key);

  /// 显示确定与取消
  const DialogView.confirm({
    Key? key,
    this.child,
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
    this.backgroundColor,
    this.insetAnimationCurve = Curves.decelerate,
    this.insetAnimationDuration = const Duration(milliseconds: 100),
  }) : super(key: key);

  /// 显示标题 内容
  const DialogView.hint({
    Key? key,
    this.child,
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
    this.backgroundColor,
    this.insetAnimationCurve = Curves.decelerate,
    this.insetAnimationDuration = const Duration(milliseconds: 100),
  }) : super(key: key);

  ///
  const DialogView.load({
    Key? key,
    this.child = const CircularProgressIndicator(),
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
    this.backgroundColor,
    this.insetAnimationCurve = Curves.decelerate,
    this.insetAnimationDuration = const Duration(milliseconds: 100),
  }) : super(key: key);

  final bool isShowTitle;
  final bool isConfirm;
  final bool isLoad;
  final bool fullScreen;
  final bool expanded;
  final Color? backgroundColor;
  final Widget? child;
  final String? title;
  final String? content;
  final String? okHint;
  final String? noHint;

  final TouchTap? onOk;
  final TouchTap? onNo;

  /// The duration of the animation to show when the system keyboard intrudes
  /// into the space that the dialog is placed in.
  ///
  /// Defaults to 100 milliseconds.
  final Duration insetAnimationDuration;

  /// The curve to use for the animation shown when the system keyboard intrudes
  /// into the space that the dialog is placed in.
  ///
  /// Defaults to [Curves.fastOutSlowIn].
  final Curve insetAnimationCurve;

  Widget _confirm(BuildContext context) {
    return Container(
      height: 140.ww,
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

  Widget _title() {
    return Container(
      height: 96.ww,
      alignment: Alignment.center,
      child: Text(title ?? "", style: StyleText.normal(size: 60)),
    );
  }

  Widget _defaultTxt() {
    Widget view = ConstrainedBox(
      constraints: BoxConstraints(minHeight: 80.0),
      child: ListIntervalView.children(
        physics: BouncingScrollPhysics(),
        children: [
          Container(
            margin: Spacing.topAndBottom(size: 32),
            padding: Spacing.leftAndRight(size: 64),
            alignment: Alignment.center,
            child: Text(content ?? ""),
          )
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

    var view = child ?? _defaultTxt();

    return AnimatedContainer(
      padding: MediaQuery.of(context).viewInsets +
          const EdgeInsets.symmetric(horizontal: 40.0, vertical: 24.0),
      duration: insetAnimationDuration,
      curve: insetAnimationCurve,
      child: MediaQuery.removeViewInsets(
        removeLeft: true,
        removeTop: true,
        removeRight: true,
        removeBottom: true,
        context: context,
        child: DefaultTextStyle(
          style: StyleText.normal(size: 40),
          child: Container(
            padding: Spacing.topOrBottom(size: isLoad ? 96 : 48),
            width: isLoad ? 500.ww : null,
            decoration: BoxDecoration(
              color: backgroundColor ??
                  dialogTheme.backgroundColor ??
                  Theme.of(context).dialogBackgroundColor,
              borderRadius: SBorderRadius.normal(),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Spacing.vView(isShow: isShowTitle, child: () => _title()),
                view,
                Spacing.vView(
                  isShow: child != null && content != null,
                  child: () => _defaultTxt(),
                ),
                Spacing.vView(
                  isShow: isConfirm,
                  child: () => Spacing.wireView(),
                ),
                Spacing.vView(
                  isShow: isConfirm,
                  child: () => _confirm(context),
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
            child: Text(name!, style: StyleText.normal(size: 48)),
            alignment: Alignment.center,
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
          Spacing.vView(isShow: name!.en, child: () => _title()),
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
      height: height?.ww,
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

typedef Offset OffsetHandle(Animation animation);
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
  var _targetContext = context;
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

          RenderBox renderBox = _targetContext.findRenderObject() as RenderBox;
          Offset _offset = renderBox.localToGlobal(Offset.zero);
          double left = 0;
          double top = 0;
          switch (location) {
            case Location.center:
              return Container(
                alignment: Alignment.center,
                child: pageChild,
              );
            case Location.left:
              left = _offset.dx + offset;
              break;
            case Location.right:
              left = _offset.dx + renderBox.size.width + offset;
              break;
            case Location.top:
              top = _offset.dy + offset;
              break;
            case Location.bottom:
              top = _offset.dy + renderBox.size.height + offset;
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
