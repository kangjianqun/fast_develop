import 'package:flutter/widgets.dart';

import '../fast_develop.dart';

///https://www.jianshu.com/p/ab473fb8ceb0
///
class PrimaryScrollContainer extends StatefulWidget {
  final Widget child;

  PrimaryScrollContainer(
    GlobalKey<PrimaryScrollContainerState> key,
    this.child,
  ) : super(key: key);

  @override
  State<StatefulWidget> createState() => PrimaryScrollContainerState();
}

ScrollController? getNestedScrollViewInner(BuildContext context) {
  final PrimaryScrollController? primaryScrollController =
      context.dependOnInheritedWidgetOfExactType<PrimaryScrollController>();
  if (primaryScrollController == null) {
    throw ("未找到NestedScrollView");
  } else {
    return primaryScrollController.controller;
  }
}

class PrimaryScrollContainerState extends State<PrimaryScrollContainer> {
  late ScrollControllerWrapper _scrollController;

  get scrollController {
    _scrollController.inner = getNestedScrollViewInner(context)!;
    return _scrollController;
  }

  @override
  void initState() {
//    print('initstate');
    _scrollController = ScrollControllerWrapper();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return PrimaryScrollControllerWrapper(
      child: widget.child,
      scrollController: scrollController,
    );
  }

  void onPageChange(bool show) {
    _scrollController.onAttachChange(show);
  }
}

class PrimaryScrollControllerWrapper extends InheritedWidget
    implements PrimaryScrollController {
  final ScrollController scrollController;

  const PrimaryScrollControllerWrapper({
    Key? key,
    required Widget child,
    required this.scrollController,
  }) : super(key: key, child: child);

  get runtimeType => PrimaryScrollController;

  get controller => scrollController;

  @override
  bool updateShouldNotify(PrimaryScrollControllerWrapper oldWidget) =>
      controller != oldWidget.controller;
}

//代理
class ScrollControllerWrapper implements ScrollController {
  static int a = 1;

  late ScrollController inner;

  int code = a++;

  ScrollPosition? interceptedAttachPosition; //拦截的position
  ScrollPosition? lastPosition;

  bool showing = true;

  @override
  void addListener(listener) => inner.addListener(listener);

  @override
  Future<void> animateTo(double offset,
          {required Duration duration, required Curve curve}) =>
      inner.animateTo(offset, duration: duration, curve: curve);

  @override
  void attach(ScrollPosition position) {
//    print('{$code}:attach start {$showing}');
//    if (position == interceptedAttachPosition) print("attach by inner");
    position.hasListeners;
//    print('{$code}:attach end {$showing}');
    if (inner.positions.contains(position)) return;
    if (showing) {
      inner.attach(position);
      lastPosition = position;
    } else {
      interceptedAttachPosition = position;
    }
  }

  @override
  void detach(ScrollPosition position, {bool fake = false}) {
    assert(() {
//      print('{$code}:detach start {$showing}');
      return true;
    }.call());
//    if (fake) print("detach is innner");
    if (inner.positions.contains(position)) {
      inner.detach(position);
    }
    if (position == interceptedAttachPosition && !fake) {
//      print('{$code}:set null {$showing}');
      interceptedAttachPosition = null;
    }
    if (position == lastPosition && !fake) {
//      print('{$code}:set null {$showing}');
      lastPosition = null;
    }
    if (fake) {
      interceptedAttachPosition = position;
    }
    assert(() {
//      print('{$code}:detach end {$showing}');
      return true;
    }.call());
  }

  void onAttachChange(bool b) {
//    print('{$code}:change{$b}');
    showing = b;
    if (!showing) {
      if (lastPosition != null) detach(lastPosition!, fake: true);
    } else {
      if (interceptedAttachPosition != null) attach(interceptedAttachPosition!);
    }
  }

  @override
  ScrollPosition createScrollPosition(ScrollPhysics physics,
          ScrollContext context, ScrollPosition? oldPosition) =>
      inner.createScrollPosition(physics, context, oldPosition);

  @override
  void debugFillDescription(List<String> description) =>
      inner.debugFillDescription(description);

  @override
  String? get debugLabel => inner.debugLabel;

  @override
  void dispose() => inner.dispose();

  @override
  bool get hasClients => inner.hasClients;

  @override
  bool get hasListeners => inner.hasListeners;

  @override
  double get initialScrollOffset => inner.initialScrollOffset;

  @override
  void jumpTo(double value) => inner.jumpTo(value);

  @override
  bool get keepScrollOffset => inner.keepScrollOffset;

  @override
  void notifyListeners() => inner.notifyListeners();

  @override
  double get offset => inner.offset;

  @override
  ScrollPosition get position => inner.position;

  @override
  Iterable<ScrollPosition> get positions => inner.positions;

  @override
  void removeListener(listener) => inner.removeListener(listener);

  @override
  int get hashCode => inner.hashCode;

  @override
  bool operator ==(other) {
    return hashCode == (other.hashCode);
  }
}

class ScrollSwitchWidget extends StatelessWidget {
  const ScrollSwitchWidget({
    Key? key,
    this.unfoldChild,
    required this.child,
    required this.scrollableNotifier,
    required this.maxOfExtent,
    required this.minOfExtent,
  })   : this.heightRatio = 1 - (minOfExtent / maxOfExtent),
        super(key: key);

  final Widget child;
  final Widget? unfoldChild;
  final ValueNotifier<double> scrollableNotifier;
  final double maxOfExtent;
  final double minOfExtent;
  final double heightRatio;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Stack(children: <Widget>[
        ValueListenableBuilder<double>(
          valueListenable: scrollableNotifier,
          builder: (_, shrinkOffset, ___) {
            var opacity = shrinkOffset / maxOfExtent;
            if (opacity > 1) {
              opacity = 1;
            } else if (opacity < 0.0) {
              opacity = 0.0;
            }
            return Positioned(
              top: 0,
              child: Opacity(
                child: this.child,
                opacity: opacity >= heightRatio ? 1 : opacity,
              ),
            );
          },
        ),
        Spacing.vView(
          isShow: unfoldChild != null,
          child: () => ValueListenableBuilder<double>(
            valueListenable: scrollableNotifier,
            builder: (_, shrinkOffset, ___) {
              if (shrinkOffset < 0) {
                shrinkOffset = 0.0;
              } else {
                shrinkOffset =
                    shrinkOffset > maxOfExtent ? maxOfExtent : shrinkOffset;
              }

              return Positioned(
                top: 0,
                child: Opacity(
                  child: unfoldChild,
                  opacity: 1 - (shrinkOffset / maxOfExtent),
                ),
              );
            },
          ),
        ),
      ]),
    );
  }
}
