import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../fast_develop.dart';

const Widget DefaultSpace = const Text(
  ' : ',
  style: TextStyle(
    color: Colors.red,
  ),
);

class CountDown extends StatefulWidget {
  const CountDown({
    Key? key,
    this.space = DefaultSpace,
    this.duration = const Duration(hours: 10, minutes: 30, seconds: 0),
    this.textStyle =
        const TextStyle(color: Colors.white, backgroundColor: Colors.red),
    this.borderRadius = const BorderRadius.all(Radius.circular(3)),
    this.only = false,
    this.onlyAutoStart = false,
    this.onlyHint = "",
    this.onTap,
    this.timeOver,
    this.backgroundColor,
  })  : this.build = null,
        super(key: key);

  const CountDown.only({
    this.only = true,
    this.onlyAutoStart = false,
    this.space,
    this.timeOver,
    this.duration = const Duration(seconds: 60),
    required this.onlyHint,
    required this.onTap,
    required this.build,
    this.textStyle =
        const TextStyle(color: Colors.white, backgroundColor: Colors.red),
    this.borderRadius = const BorderRadius.all(Radius.circular(3)),
  }) : this.backgroundColor = null;

  final bool only;
  final bool onlyAutoStart;
  final String onlyHint;
  final Duration duration;
  final Color? backgroundColor;
  final Widget? space;
  final Future<bool?> Function()? onTap;
  final void Function()? timeOver;
  final TextStyle textStyle;
  final BorderRadius borderRadius;
  final Widget Function(BuildContext buildContext, Widget child)? build;

  @override
  CountDownState createState() => CountDownState();
}

enum TimeType { Hours, Minutes, Seconds }

class CountDownState extends State<CountDown> with TickerProviderStateMixin {
  late Timer? _timer;
  late int _allSeconds;
  bool timeFinish = true;
  late Color backgroundColor;
  ValueNotifier<String> _vNDay = ValueNotifier("");
  ValueNotifier<String> _vNHour = ValueNotifier("");
  ValueNotifier<String> _vNMinute = ValueNotifier("");
  ValueNotifier<String> _vNSecond = ValueNotifier("");

  //时间格式化，根据总秒数转换为对应的 hh:mm:ss 格式
  _constructTime(int seconds) {
    Duration duration = Duration(seconds: seconds);
    int day = duration.inDays;
    int hour = duration.inHours % 60 % 24;
    int minute = seconds % 3600 ~/ 60;
    int second = seconds % 60;

    try {
      if (ModalRoute.of(context)!.isCurrent) {
        _vNDay.value = _formatTime(day);
        _vNHour.value = _formatTime(hour);
        _vNMinute.value = _formatTime(minute);
        _vNSecond.value = _formatTime(second);
      }
    } catch (e) {}
  }

  //数字格式化，将 0~9 的时间转换为 00~09
  String _formatTime(int timeNum) {
    return timeNum < 10 ? "0" + timeNum.toString() : timeNum.toString();
  }

  void _initOnly() {
    _vNSecond.value = widget.onlyHint;
  }

  void _startTimer() {
    timeFinish = false;
    //设置 1 秒回调一次
    const period = const Duration(seconds: 1);
    _timer = Timer.periodic(period, (timer) {
      //更新界面
      _allSeconds--;
      if (_allSeconds < 0) {
        timeFinish = true;
        //倒计时秒数为0，取消定时器
        _cancelTimer();
        if (widget.timeOver != null) {
          widget.timeOver!();
        } else {
          if (widget.only) _initOnly();
        }
      } else {
        _constructTime(_allSeconds);
      }
    });
  }

  void _cancelTimer() {
    if (_timer != null) {
      _timer!.cancel();
      _timer = null;
    }
  }

  @override
  void initState() {
    super.initState();
    _allSeconds = widget.duration.inSeconds;
    backgroundColor = widget.backgroundColor!;
    _constructTime(_allSeconds);

    if (widget.only) {
      _initOnly();
      if (widget.onlyAutoStart) {
        _startTimer();
      }
    } else {
      _startTimer();
    }
  }

  @override
  void dispose() {
    super.dispose();
    _cancelTimer();
  }

  Widget _only() {
    return ValueListenableBuilder<String>(
      valueListenable: _vNSecond,
      builder: (ctx, value, child) {
        Widget view = ClipRRect(
          borderRadius: widget.borderRadius,
          child: widget.build!(ctx, Text(value, style: widget.textStyle)),
        );

        if (widget.onTap != null) {
          view = TouchWidget(
            onTap: (_) {
              if (timeFinish) {
                widget.onTap!().then((start) {
                  if (start != null && start) _startTimer();
                });
              }
            },
            child: view,
          );
        }

        return view;
      },
    );
  }

  Widget _allTime() {
    return Container(
      child: Row(children: <Widget>[
        ClipRRect(
          borderRadius: widget.borderRadius,
          child: Container(
            color: backgroundColor,
            height: 65.hh,
            alignment: Alignment.center,
            child: ValueListenableBuilder<String>(
              valueListenable: _vNDay,
              builder: (_, value, ___) {
                if (value == "00")
                  return SizedBox();
                else
                  return Text(" " + value + " 天 ", style: widget.textStyle);
              },
            ),
          ),
        ),
        Spacing.spacingView(),
        ClipRRect(
          borderRadius: widget.borderRadius,
          child: Container(
            color: backgroundColor,
            width: 45.ww,
            height: 65.hh,
            alignment: Alignment.center,
            child: ValueListenableBuilder<String>(
              valueListenable: _vNHour,
              builder: (_, value, ___) => Text(value, style: widget.textStyle),
            ),
          ),
        ),
        widget.space!,
        ClipRRect(
          borderRadius: widget.borderRadius,
          child: Container(
            color: backgroundColor,
            width: 45.ww,
            height: 65.hh,
            alignment: Alignment.center,
            child: ValueListenableBuilder<String>(
              valueListenable: _vNMinute,
              builder: (_, value, ___) => Text(value, style: widget.textStyle),
            ),
          ),
        ),
        widget.space!,
        ClipRRect(
          borderRadius: widget.borderRadius,
          child: Container(
            color: backgroundColor,
            width: 45.ww,
            height: 65.hh,
            alignment: Alignment.center,
            child: ValueListenableBuilder<String>(
              valueListenable: _vNSecond,
              builder: (_, value, ___) => Text(value, style: widget.textStyle),
            ),
          ),
        ),
      ]),
    );
  }

  @override
  Widget build(BuildContext context) {
    return widget.only ? _only() : _allTime();
  }
}
