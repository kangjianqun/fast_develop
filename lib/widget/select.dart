import 'package:flutter/widgets.dart';

import '../fast_develop.dart';

class Select<T> extends StatelessWidget {
  const Select({
    Key key,
    this.onTap,
    @required this.value,
    @required this.valueNotifier,
    @required this.selectedView,
    @required this.unSelectedView,
  }) : super(key: key);

  final Widget selectedView;
  final Widget unSelectedView;
  final T value;
  final Function(T value) onTap;
  final ValueNotifier<T> valueNotifier;

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: valueNotifier,
      builder: (_, v, child) {
        return TouchWidget(
          onTap: (_) {
            if (onTap == null)
              valueNotifier.value = value;
            else
              onTap(value);
          },
          child: Container(
            padding: Spacing.all(topB: 8, leftR: 16),
            child: v == value ? selectedView : unSelectedView,
          ),
        );
      },
    );
  }
}
