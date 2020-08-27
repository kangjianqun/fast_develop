import 'package:fast_mvvm/fast_mvvm.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';

import '../fast_develop.dart';

Widget easyRefreshList({
  @required List<Widget> children,
  EasyRefreshController controller,
  OnRefreshCallback refresh,
  OnLoadCallback load,
  num space = 16,
  bool slide = true,
  bool isInterval = true,
  bool shrinkWrap = false,
  num mainPadding = 0,
  num crossPadding = 0,
  bool fullLine = true,
  Footer footer,
  Header header,
}) {
  List<Widget> child = [];
  if (isInterval) {
    child.add(ListIntervalView.children(
        children: children,
        space: space,
        fullLine: fullLine,
        mainPadding: mainPadding,
        crossPadding: crossPadding));
  } else {
    child.addAll(children);
  }

  Widget view = EasyRefresh.custom(
    controller: controller,
    onRefresh: refresh,
    onLoad: load,
    shrinkWrap: shrinkWrap,
    topBouncing: slide,
    bottomBouncing: slide,
    footer: footer,
    header: header,
    cacheExtent: pageHeight,
    slivers: <Widget>[SliverList(delegate: SliverChildListDelegate(child))],
  );

  if (!isInterval) {
    view = Container(
      padding: Spacing.all(leftR: crossPadding, topB: mainPadding),
      child: view,
    );
  }

  return view;
}

Widget easyRefresh({
  @required itemCount,
  @required IndexedWidgetBuilder itemBuilder,
  EasyRefreshController controller,
  OnRefreshCallback refresh,
  OnLoadCallback load,
  num space = 16,
  bool slide = true,
  bool shrinkWrap = false,
  num mainPadding = 0,
  num crossPadding = 0,
  bool fullLine = true,
  Footer footer,
  Header header,
}) {
  List<Widget> child = [
    ListIntervalView(
        itemCount: itemCount,
        itemBuilder: itemBuilder,
        space: space,
        fullLine: fullLine,
        mainPadding: mainPadding,
        crossPadding: crossPadding)
  ];

  return EasyRefresh.custom(
    controller: controller,
    onRefresh: refresh,
    onLoad: load,
    shrinkWrap: shrinkWrap,
    topBouncing: slide,
    bottomBouncing: slide,
    footer: footer,
    header: header,
    cacheExtent: pageHeight,
    slivers: <Widget>[SliverList(delegate: SliverChildListDelegate(child))],
  );
}
