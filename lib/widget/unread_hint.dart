import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../fast_develop.dart';

/// 未读提示
class UnreadHintWidget extends StatelessWidget {
  const UnreadHintWidget({
    Key? key,
    required this.child,
    required this.count,
    this.right,
    this.bottom,
    this.top,
    this.left,
  }) : super(key: key);

  final Widget Function(BuildContext context, int count) child;
  final ValueNotifier<int> count;
  final num? right;
  final num? bottom;
  final num? top;
  final num? left;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Stack(
        clipBehavior: Clip.none,
        children: <Widget>[
          ValueListenableBuilder<int>(
            valueListenable: count,
            builder: (_, count, __) => child(context, count),
          ),
          Positioned(
            right: valueByType(right, double, dValue: 8),
            bottom: valueByType(bottom, double, dValue: 18),
            top: valueByType(top, double),
            left: valueByType(left, double),
            child: _hintGroup(),
          ),
        ],
      ),
    );
  }

  Widget _hintGroup() {
    return ValueListenableBuilder<int>(
      valueListenable: count,
      builder: (_, count, child) {
        return Spacing.vView(
          isShow: count > 0,
          child: () => ClipOval(
            child: Container(
              color: Colors.red,
              width: 40.rr,
              height: 40.rr,
              alignment: Alignment.center,
              child: _hintCount(count),
            ),
          ),
        );
      },
    );
  }

  Widget _hintCount(int count) {
    if (count > 0) {
      count = count > 99 ? 99 : count;
    } else {
      count = 0;
    }
    String hint = count > 0 ? count.toString() : "";
    return Text(hint, style: StyleText.white(size: 26));
  }
}
