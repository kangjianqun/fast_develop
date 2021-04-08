import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../fast_develop.dart';

typedef Child = Widget? Function();

class Spacing {
  static EdgeInsets rootLR({num? size}) {
    var _size = size ?? FConfig.ins.rootLR;
    return leftAndRight(size: _size);
  }

  static EdgeInsets leftAndRight({num? size, num? right}) {
    var _size = size ?? FConfig.ins.rootLR;
    var _right = right ?? _size;
    return EdgeInsets.only(left: _size.ww!, right: _right.ww!);
  }

  static EdgeInsets leftOrRight({num? size, bool isLeft = true}) {
    var _size = size ?? FConfig.ins.rootLR;
    var left = isLeft ? _size : 0;
    var right = !isLeft ? _size : 0;

    return EdgeInsets.only(left: left.ww!, right: right.ww!);
  }

  static EdgeInsets topAndBottom({num? size, num? bottom}) {
    var _size = size ?? FConfig.ins.rootTB;
    var _bottom = bottom ?? _size;
    return EdgeInsets.only(top: _size.hh!, bottom: _bottom.hh!);
  }

  static EdgeInsets topOrBottom({num? size, bool isTop = true}) {
    var _size = size ?? FConfig.ins.rootTB;
    var top = isTop ? _size : 0;
    var bottom = !isTop ? _size : 0;

    return EdgeInsets.only(top: top.hh!, bottom: bottom.hh!);
  }

  static EdgeInsets all({num? size, num? leftR = -1, num? topB = -1}) {
    var _size = size ?? FConfig.ins.padding;

    if (leftR != -1 || topB != -1) _size = 0;
    var w = (leftR != -1 ? leftR : _size).ww!;
    var h = (topB != -1 ? topB : _size).ww!;
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
    var _h = height ?? FConfig.ins.listSpace;
    return spacingView(height: _h);
  }

  static Widget spacePadding({num? size}) {
    var _size = size ?? FConfig.ins.padding;
    return spacingView(height: _size, width: _size);
  }

  /// 用来做间距
  static Widget spacingView({num? width, num? height}) {
    var _w = width ?? FConfig.ins.space;
    var _h = height ?? FConfig.ins.space;
    return SizedBox(width: _w.ww, height: _h.hh);
  }

  static Widget fillView({int flex = 1, Widget? child}) {
    return Expanded(flex: flex, child: child ?? SizedBox());
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
      return SizedBox();
    } else if (noVLB && isShow) {
      return child!()!;
    }

    vn ??= ValueNotifier<bool>(isShow);
    return ValueListenableBuilder<bool>(
      valueListenable: vn,
      builder: (_, show, __) {
        var _show = reverse ? !show : show;
        return Visibility(
            visible: _show, child: _show ? child!()! : SizedBox());
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
