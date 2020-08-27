import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../fast_develop.dart';
/// 未读提示
class UnreadHintWidget extends StatelessWidget {
  const UnreadHintWidget({
    Key key,
    this.child,
    this.count,
  }) : super(key: key);

  final Widget Function(BuildContext context, int count) child;
  final ValueNotifier<int> count;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Stack(
        overflow: Overflow.visible,
        children: <Widget>[
          ValueListenableBuilder(
            valueListenable: count,
            builder: (_, count, __) => child(context, count),
          ),
          Positioned(right: 8, bottom: 18, child: _hintGroup()),
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
              width: 40.s,
              height: 40.s,
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
