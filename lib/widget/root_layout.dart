import 'package:flutter/material.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:fast_mvvm/fast_mvvm.dart';
import '../fast_develop.dart';

typedef ChildBuild<T> = T Function(BuildContext? context);

typedef SwitchThemeBrightness = ThemeData Function(
    Brightness brightness, ThemeData themeData);

SwitchThemeBrightness? _switchThemeBrightness;

initFastDevelopOfRootLayout(SwitchThemeBrightness? stb) {
  if (stb != null) _switchThemeBrightness = stb;
}

class SafePadding {
  bool left, top, right, bottom;

  SafePadding({
    this.left = false,
    this.top = false,
    this.right = false,
    this.bottom = false,
  });
}

class MyScaffold extends StatelessWidget {
  const MyScaffold.normal({
    Key? kye,
    this.appBar,
    required this.body,
    this.actions,
    this.title,
    this.drawer,
    this.drawerIsLeft = true,
    this.titleIsCenter = false,
    this.isMaterial = true,
    this.isShowTitle = true,
    this.isBottom = false,
    this.isSafeArea,
    this.bgColor,
    this.titleBackgroundColor,
    this.bottom,
    this.titleWidget,
    this.stateWidget,
    this.nextWidget,
    this.brightness,
    this.appBarBrightness,
    this.themeData,
    this.defaultTextColor,
  })  : immerse = false,
        backgroundWidget = null,
        super(key: kye);

  const MyScaffold.center({
    Key? kye,
    required this.title,
    this.appBar,
    required this.body,
    this.actions,
    this.drawer,
    this.drawerIsLeft = true,
    this.titleIsCenter = true,
    this.isMaterial = true,
    this.isShowTitle = true,
    this.isSafeArea,
    this.bgColor,
    this.titleBackgroundColor,
    this.isBottom = false,
    this.bottom,
    this.titleWidget,
    this.stateWidget,
    this.nextWidget,
    this.brightness,
    this.appBarBrightness,
    this.themeData,
    this.defaultTextColor,
  })  : immerse = false,
        backgroundWidget = null,
        super(key: kye);

  /// 沉浸式
  const MyScaffold.immerse({
    Key? kye,
    this.appBar,
    this.title,
    required this.body,
    this.backgroundWidget,
    this.actions,
    this.drawer,
    this.drawerIsLeft = true,
    this.titleIsCenter = true,
    this.isMaterial = true,
    this.isShowTitle = true,
    this.isSafeArea,
    this.bgColor,
    this.titleBackgroundColor,
    this.isBottom = false,
    this.bottom,
    this.titleWidget,
    this.stateWidget,
    this.nextWidget,
    this.brightness,
    this.appBarBrightness,
    this.themeData,
    this.defaultTextColor,
  })  : immerse = true,
        super(key: kye);

  /// 状态页面   显示当前页面加载状态  优先度最高
  final Widget? stateWidget;

  final bool immerse;
  final ChildBuild<Widget>? appBar;
  final ChildBuild<Widget> body;
  final ChildBuild<Widget>? bottom;
  final ChildBuild<Widget>? drawer;
  final bool drawerIsLeft;
  final Color? titleBackgroundColor;
  final Color? bgColor;
  final Color? defaultTextColor;
  final bool isShowTitle;
  final SafePadding? isSafeArea;
  final bool isMaterial;
  final bool isBottom;
  final ChildBuild<Widget>? backgroundWidget;
  final String? title;
  final ChildBuild<Widget>? titleWidget;
  final bool titleIsCenter;
  final ChildBuild<Widget>? nextWidget;
  final ChildBuild<List<Widget>>? actions;

  final ThemeData? themeData;

  /// 全局主题配置
  final Brightness? brightness;

  /// 如果单独设置标题栏则使用 否则使用[brightness]设置全局
  final Brightness? appBarBrightness;

  static void setTitle(String title, {BuildContext? context}) {
    context ??= FConfig.ins.context;
    delayed(() => getVM<TitleVM>(context!).setTitle(title));
  }

  /// 生成top
  Widget? _resultTop(BuildContext? ctx) {
    var brightness_ = appBarBrightness ?? brightness;
    Widget? top = appBar == null ? null : appBar!(ctx);

    List<Widget> actions_ = actions == null ? [] : actions!(ctx);
    if (nextWidget != null) actions_ = [nextWidget!(ctx)];

    if (top == null && isShowTitle) {
      var bgIsTr = stateWidget == null && immerse && backgroundWidget != null;

      var bgColor = titleBackgroundColor;
      bgColor ??= backgroundWidget != null
          ? CConfig.transparent
          : (themeData?.appBarTheme.backgroundColor ??
              CConfig.getBackground(
                  brightness: brightness_,
                  context: ctx,
                  color: (bgIsTr || backgroundWidget != null)
                      ? CConfig.transparent
                      : null));

      top = TitleWidget(
        titleIsCenter: titleIsCenter,
        backgroundColor: bgColor,
        title: title,
        brightness: brightness_,
        tWidget: titleWidget == null ? null : titleWidget!(ctx),
        actions: stateWidget != null ? null : actions_,
      );
    }
    return top;
  }

  Widget _resultView(BuildContext context, Widget? top) {
    /// 判断是否有状态需要显示  优先显示状态
    var style = StyleText.normal(
        color: defaultTextColor ??
            CConfig.getTwo(brightness: brightness, context: context));
    Widget bodyView =
        DefaultTextStyle(style: style, child: stateWidget ?? body(context));

    Widget? bottom_ = bottom == null ? null : bottom!(context);
    if (bottom_ != null) {
      bottom_ = DefaultTextStyle(style: style, child: stateWidget ?? bottom_);
    }

    Widget? drawer_ = drawer == null ? null : drawer!(context);

    /// 不显示标题和不是沉浸式  填充标题栏颜色
    if (!isShowTitle && !immerse) {
      bodyView = Column(
        children: <Widget>[
          Container(
            height: ScreenUtils.statusBarH,
            color: CConfig.getBackground(color: titleBackgroundColor),
          ),
          Expanded(child: bodyView),
        ],
      );
    }

    var bgColor_ = bgColor ?? Theme.of(context).scaffoldBackgroundColor;
    var isTransparent = immerse && backgroundWidget != null;

    if (isMaterial) {
      bodyView = Scaffold(
        appBar: top as PreferredSizeWidget,
        body: bodyView,
        resizeToAvoidBottomInset: isBottom,
        drawer: drawerIsLeft && stateWidget == null ? drawer_ : null,
        endDrawer: !drawerIsLeft && stateWidget == null ? drawer_ : null,
        backgroundColor: !isTransparent ? bgColor_ : CConfig.transparent,
        bottomNavigationBar: bottom_,
      );

      if (stateWidget == null && isTransparent) {
        bodyView = Stack(children: [
          Container(color: bgColor_),
          backgroundWidget!(context),
          bodyView,
        ]);
      }
    } else {
      Widget view;

      Widget center = bottom != null && stateWidget == null
          ? Container(
              height: ScreenUtils.height,
              decoration: const BoxDecoration(),
              child: Column(
                  children: [Expanded(child: bodyView), bottom!(context)]))
          : bodyView;

      /// 如果使用 [TitleWidget] 则需要限制高度
      if (top != null && isShowTitle && top is TitleWidget) {
        top = ConstrainedBox(
          constraints: BoxConstraints(maxHeight: top.preferredSize.height),
          child: top,
        );
      }

      if (stateWidget == null && isTransparent) {
        view = top == null
            ? Stack(children: [backgroundWidget!(context), center])
            : Stack(children: [backgroundWidget!(context), center, top]);
      } else {
        view = top == null ? center : Column(children: [top, center]);
      }

      /// 安全间距
      EdgeInsets? safePadding;
      if (isSafeArea != null) {
        var padding = MediaQuery.of(context).padding;
        safePadding = Spacing.fromLTRB(
            isSafeArea!.left ? padding.left : 0,
            isSafeArea!.top ? padding.top : 0,
            isSafeArea!.right ? padding.right : 0,
            isSafeArea!.bottom ? padding.bottom : 0);
      }
      bodyView = Container(color: bgColor_, padding: safePadding, child: view);
    }
    return bodyView;
  }

  Widget _child(BuildContext context) {
    return _resultView(context, _resultTop(context));
  }

  @override
  Widget build(BuildContext context) {
    var themeData_ = themeData;
    if (themeData_ == null && brightness != null) {
      themeData_ = Theme.of(context);
      if (_switchThemeBrightness != null) {
        themeData_ = _switchThemeBrightness!(brightness!, themeData_);
      }
    }

    if (themeData_ != null) {
      return Theme(data: themeData_, child: Builder(builder: _child));
    } else {
      return _child(context);
    }
  }
}

enum ShowType { normal, hide }

class MyBody extends StatelessWidget {
  const MyBody({
    Key? key,
    required this.children,
    this.topWidget,
    this.padding,
    this.left = 0,
    this.top = 0,
    this.right = 0,
    this.space,
    this.bottom = true,
    this.slide = false,
    this.backgroundColor,
    this.decoration,
    this.controller,
    this.refresh,
    this.load,
    this.fullLine = true,
    this.noList = false,
    this.listEx,
    this.header,
    this.footer,
    this.topShrink = false,
    this.cacheExtent,
  })  : child = null,
        itemBuilder = null,
        itemCount = null,
        super(key: key);

  const MyBody.itemBuilder({
    Key? key,
    required this.itemCount,
    required this.itemBuilder,
    this.topWidget,
    this.padding,
    this.left = 0,
    this.top = 0,
    this.right = 0,
    this.space,
    this.bottom = true,
    this.slide = false,
    this.backgroundColor,
    this.decoration,
    this.controller,
    this.refresh,
    this.load,
    this.fullLine = true,
    this.noList = false,
    this.listEx,
    this.header,
    this.footer,
    this.topShrink = false,
    this.cacheExtent,
  })  : child = null,
        children = null,
        super(key: key);

  /// 非list 需自己处理或者[noList] = true;
  const MyBody.child({
    Key? key,
    required this.child,
    this.topWidget,
    this.padding,
    this.left = 0,
    this.top = 0,
    this.right = 0,
    this.space,
    this.bottom = true,
    this.slide = false,
    this.backgroundColor,
    this.decoration,
    this.controller,
    this.refresh,
    this.load,
    this.fullLine = true,
    this.noList = true,
    this.listEx,
    this.header,
    this.footer,
    this.topShrink = false,
    this.cacheExtent,
  })  : children = null,
        itemBuilder = null,
        itemCount = null,
        super(key: key);

  final List<Widget>? children;
  final IndexedWidgetBuilder? itemBuilder;
  final Widget? child;

  /// top 收缩
  final bool topShrink;
  final Widget? topWidget;
  final Color? backgroundColor;
  final Decoration? decoration;
  final bool bottom;
  final bool noList;
  final bool slide;
  final num? padding;
  final int left;
  final int top;
  final int right;
  final num? space;
  final int? itemCount;
  final double? cacheExtent;
  final EasyRefreshController? controller;
  final OnRefreshCallback? refresh;
  final OnLoadCallback? load;

  /// 整行 item 填充宽度
  final bool fullLine;

  /// 是否 [ListIntervalView]扩展
  final bool? listEx;

  final Header? header;
  final Footer? footer;

  Widget _content(num padding, space) {
    List<Widget>? children_ = children ?? (child == null ? [] : [child!]);

    Widget? view;
    if (noList) {
      view = child;
    } else {
      view = easyRefresh(
        itemCount: itemCount ?? children_.length,
        itemBuilder: itemBuilder ?? (_, index) => children_[index],
        controller: controller,
        refresh: refresh,
        mainPadding: padding,
        crossPadding: padding,
        load: load,
        fullLine: fullLine,
        space: space,
        slide: slide,
        cacheExtent: cacheExtent,
        header: header,
        footer: footer,
      );
    }

    return Container(
      margin: Spacing.fromLTRB(left, topShrink ? 0 : top, right, 0),
      decoration: decoration,
      width: ScreenUtils.max,
      height: ScreenUtils.max,
      color: decoration == null ? backgroundColor : null,
      child: view,
    );
  }

  @override
  Widget build(BuildContext context) {
    var padding_ = padding ?? FConfig.ins.myBodyOfPadding;
    var space_ = space ?? FConfig.ins.myBodyOfSpace ?? FConfig.ins.listSpace;
    Widget view = _content(padding_, space_);
    if (topWidget != null) {
      Widget topWidget_ = topWidget!;
      if (topShrink) {
        topWidget_ =
            Container(margin: Spacing.all(size: padding_), child: topWidget);
      }
      view = Column(children: [topWidget_, Expanded(child: view)]);
    }
    return view;
  }
}

/// 持久头用的
class SPHDelegate extends SliverPersistentHeaderDelegate {
  final ChildBuild child;
  final Widget? unfoldChild;
  final double maxOfExtent;
  final double minOfExtent;
  final Widget? background;
  final double heightRatio;

  ShowType? showType = ShowType.normal;

  SPHDelegate({
    this.unfoldChild,
    this.background,
    this.showType,
    required this.maxOfExtent,
    required this.minOfExtent,
    required this.child,
  }) : heightRatio = 1 - (minOfExtent / maxOfExtent);

  /// 高度 最大/最小相同
  SPHDelegate.same({
    this.background,
    required this.child,
    this.unfoldChild,
    required extent,
  })  : maxOfExtent = extent,
        minOfExtent = extent,
        heightRatio = 1;

  @override
  Widget build(context, double shrinkOffset, bool overlapsContent) {
    Widget view;
//    LogUtil.printLog(aa);
    var opacity = shrinkOffset / maxOfExtent;
    switch (showType) {
      case ShowType.hide:
        view = Stack(children: <Widget>[
          background!,
          Positioned(
            top: 0,
            child: Opacity(
              child: child(context),
              opacity: opacity >= heightRatio ? 1 : opacity,
            ),
          ),
          Spacing.vView(
            isShow: unfoldChild != null,
            child: () => Positioned(
              top: 0,
              child: Opacity(
                opacity: 1 - (shrinkOffset / maxOfExtent),
                child: unfoldChild,
              ),
            ),
          ),
        ]);
        break;
      default:
        view = child(context);
        break;
    }
    return view;
  }

  @override
  double get maxExtent => maxOfExtent;

  @override
  double get minExtent => minOfExtent;

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) {
    return true;
  }
}

class BodyE extends StatelessWidget {
  const BodyE({
    Key? key,
    this.topHint,
    this.operate,
    required this.children,
    this.child,
    this.padding = 32,
    this.left = 0,
    this.top = 0,
    this.right = 0,
    this.space = 0,
    this.bottom = true,
    this.slide = false,
    this.backgroundColor,
    this.decoration,
    this.controller,
    this.refresh,
    this.load,
    this.fullLine = true,
    this.noList = false,
  }) : super(key: key);

  const BodyE.child({
    Key? key,
    this.topHint,
    this.operate,
    required this.child,
    this.padding = 32,
    this.left = 0,
    this.top = 0,
    this.right = 0,
    this.space = 0,
    this.bottom = true,
    this.slide = false,
    this.backgroundColor,
    this.decoration,
    this.controller,
    this.refresh,
    this.load,
    this.fullLine = true,
    this.noList = true,
  })  : children = null,
        super(key: key);

  final List<Widget>? children;
  final Widget? child;
  final Widget? operate;
  final Widget? topHint;
  final Color? backgroundColor;
  final Decoration? decoration;
  final bool bottom;
  final bool noList;
  final bool slide;
  final double padding;
  final int left;
  final int top;
  final int right;
  final double space;
  final EasyRefreshController? controller;
  final OnRefreshCallback? refresh;
  final OnLoadCallback? load;

  /// 整行 item 填充宽度
  final bool fullLine;

  Widget _content() {
    List<Widget> children_ = children ?? [child!];

    Widget? view;
    if (noList) {
      view = child;
    } else {
      view = slide
          ? easyRefreshList(
              children: children_,
              controller: controller,
              refresh: refresh,
              mainPadding: padding,
              crossPadding: padding,
              load: load,
              isInterval: space != 0,
              space: space,
            )
          : ListIntervalView(
              space: space,
              mainPadding: padding,
              crossPadding: padding,
              fullLine: fullLine,
              itemCount: children_.length,
              itemBuilder: (_, index) => children_[index],
            );
    }

    return Container(
      margin: Spacing.fromLTRB(left, top, right, 0),
      decoration: decoration,
      width: ScreenUtils.max,
      height: ScreenUtils.max,
      color: decoration == null ? backgroundColor : null,
      child: view,
    );
  }

  Widget _view() {
    Widget view = _content();
    if (operate != null || topHint != null) {
      view = Column(
        children: <Widget>[
          Spacing.vView(isShow: topHint != null, child: () => topHint!),
          Expanded(child: view),
          Spacing.vView(isShow: operate != null, child: () => operate!),
        ],
      );
    }
    return view;
  }

  @override
  Widget build(BuildContext context) {
    Widget view = _view();
    return view;
  }
}
