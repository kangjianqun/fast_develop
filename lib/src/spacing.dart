import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../fast_develop.dart';

typedef Child = Widget? Function();

class Spacing {

  static EdgeInsets rootLR({num? size}) {
    size = size ?? FConfig.ins.rootLR;
    return leftAndRight(size: size);
  }

  static EdgeInsets leftAndRight({num? size, num? right}) {
    size = size ?? FConfig.ins.rootLR;
    right = right ?? size;
    return EdgeInsets.only(left: size.ww!, right: right.ww!);
  }

  static EdgeInsets leftOrRight({num? size, bool isLeft = true}) {
    size = size ?? FConfig.ins.rootLR;
    var left = isLeft ? size : 0;
    var right = !isLeft ? size : 0;

    return EdgeInsets.only(left: left.ww!, right: right.ww!);
  }

  static EdgeInsets topAndBottom({num? size, num? bottom}) {
    size = size ?? FConfig.ins.rootTB;
    bottom = bottom ?? size;
    return EdgeInsets.only(top: size.hh!, bottom: bottom.hh!);
  }

  static EdgeInsets topOrBottom({num? size, bool isTop = true}) {
    size = size ?? FConfig.ins.rootTB;
    var top = isTop ? size : 0;
    var bottom = !isTop ? size : 0;

    return EdgeInsets.only(top: top.hh!, bottom: bottom.hh!);
  }

  static EdgeInsets all({num? size, num? leftR = -1, num? topB = -1}) {
    size = size ?? FConfig.ins.padding;

    if (leftR != -1 || topB != -1) size = 0;
    var w = (leftR != -1 ? leftR : size).ww!;
    var h = (topB != -1 ? topB : size).ww!;
    return EdgeInsets.fromLTRB(w, h, w, h);
  }

  static EdgeInsets allNo({num? leftR, num? topB}) {
    leftR ??= FConfig.ins.padding;
    topB ??= FConfig.ins.listSpace;

    var w = leftR.ww!;
    var h = topB.hh!;
    return EdgeInsets.fromLTRB(w, h, w, h);
  }

  static EdgeInsets fromLTRB(num? left, num? top, num? right, num? bottom) {
    return EdgeInsets.fromLTRB(left.ww!, top.ww!, right.ww!, bottom.ww!);
  }

  static Widget spaceList({num? height}) {
    height = height ?? FConfig.ins.listSpace;
    return spacingView(height: height);
  }

  static Widget spacePadding({num? size}) {
    size = size ?? FConfig.ins.padding;
    return spacingView(height: size, width: size);
  }

  /// 用来做间距
  static Widget spacingView({num? width, num? height}) {
    width = width ?? FConfig.ins.space;
    height = height ?? FConfig.ins.space;
    return SizedBox(width: width.ww, height: height.hh);
  }

  static Widget fillView({int flex = 1, Widget? child}) {
    return Expanded(flex: flex, child: child ?? const SizedBox());
  }

  /// [reverse] 反向使用[ValueNotifier]的值
  static Widget vView({
    Child? child,
    ValueNotifier<bool>? vn,
    bool isShow = false,
    bool? noVLB,
    bool reverse = false,
  }) {
    if (isShow || (vn != null && vn.value)) {
      assert(child != null);
    }
    noVLB ??= vn == null;

    if (vn == null && !isShow) {
      return const SizedBox();
    } else if (noVLB && isShow) {
      return child!()!;
    }

    vn ??= ValueNotifier<bool>(isShow);
    return ValueListenableBuilder<bool>(
      valueListenable: vn,
      builder: (_, show, __) {
        show = reverse ? !show : show;
        return Visibility(
            visible: show, child: show ? child!()! : const SizedBox());
      },
    );
  }

  static Widget wireView(
      {Color color = const Color(0xFFE2E2E2), num size = 2, bool isH = true}) {
    return Container(
        height: isH ? size.ww : null,
        width: isH ? null : size.ww,
        color: color);
  }

  static Widget wireView2(
      {Color color = const Color(0xFFE2E2E2), num w = 2, num h = 2}) {
    return Container(height: h.ww, width: w.ww, color: color);
  }

  /// 占位图片
  static Widget placeHolder({double width = 0, double? height}) {
    return SizedBox(
        width: width,
        height: height,
        child: CupertinoActivityIndicator(radius: min(10.0, width / 3)));
  }

  /// 失败图片
  static Widget error(
      {double? width, double? height, double? size, IconData? iconData}) {
    return SizedBox(
      width: width,
      height: height,
      child: Icon(iconData ?? Icons.error_outline, size: size),
    );
  }
}
