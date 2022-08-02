import 'package:fast_develop/fast_develop.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

export 'src/date_model.dart';
export 'src/datetime_picker_theme.dart';
export 'src/i18n_model.dart';

typedef DateChangedCallback = void Function(CompleteData data);
typedef CreateWidgetList = List<Widget> Function();

///
///数据选择器
///
class DataPicker {
  ///
  /// Display date picker bottom sheet.
  ///
  static Future showDatePicker(
    BuildContext context, {
    bool showTitleActions = true,
    DateTime? minTime,
    DateTime? maxTime,
    DateChangedCallback? onChanged,
    DateChangedCallback? onConfirm,
    locale = LocaleType.zh,
    DateTime? currentTime,
    DatePickerTheme? theme,
  }) {
    return Navigator.push(
        context,
        _DatePickerRoute(
            showTitleActions: showTitleActions,
            onChanged: onChanged,
            onConfirm: onConfirm,
            locale: locale,
            theme: theme,
            barrierLabel:
                MaterialLocalizations.of(context).modalBarrierDismissLabel,
            pickerModel: DatePickerModel(
                currentTime: currentTime,
                maxTime: maxTime,
                minTime: minTime,
                locale: locale)));
  }

  ///
  /// Display time picker bottom sheet.
  ///
  static Future showTimePicker(
    BuildContext context, {
    bool showTitleActions = true,
    DateChangedCallback? onChanged,
    DateChangedCallback? onConfirm,
    locale = LocaleType.zh,
    DateTime? currentTime,
    DatePickerTheme? theme,
  }) {
    return Navigator.push(
        context,
        _DatePickerRoute(
            showTitleActions: showTitleActions,
            onChanged: onChanged,
            onConfirm: onConfirm,
            locale: locale,
            theme: theme,
            barrierLabel:
                MaterialLocalizations.of(context).modalBarrierDismissLabel,
            pickerModel:
                TimePickerModel(currentTime: currentTime, locale: locale)));
  }

  ///
  /// Display date&time picker bottom sheet.
  ///
  static Future showDateTimePicker(
    BuildContext context, {
    bool showTitleActions = true,
    DateTime? minTime,
    DateTime? maxTime,
    DateChangedCallback? onChanged,
    DateChangedCallback? onConfirm,
    locale = LocaleType.zh,
    DateTime? currentTime,
    DatePickerTheme? theme,
  }) {
    return Navigator.push(
        context,
        _DatePickerRoute(
            showTitleActions: showTitleActions,
            onChanged: onChanged,
            onConfirm: onConfirm,
            locale: locale,
            theme: theme,
            barrierLabel:
                MaterialLocalizations.of(context).modalBarrierDismissLabel,
            pickerModel: DateTimePickerModel(
                currentTime: currentTime,
                minTime: minTime,
                maxTime: maxTime,
                locale: locale)));
  }

  /// Display picker bottom sheet witch custom picker model.
  /// 显示选择器底页 自定义选择器模型
  static Future showPicker(
    BuildContext context, {
    bool showTitleActions = true,
    bool? loopList,
    DateChangedCallback? onChanged,
    DateChangedCallback? onConfirm,
    locale = LocaleType.zh,
    CommonPickerData? pickerData,
    DatePickerTheme? theme,
  }) {
    return Navigator.push(
      context,
      _DatePickerRoute(
        showTitleActions: showTitleActions,
        loopList: loopList,
        onChanged: onChanged,
        onConfirm: onConfirm,
        locale: locale,
        theme: theme,
        barrierLabel:
            MaterialLocalizations.of(context).modalBarrierDismissLabel,
        pickerModel: pickerData,
      ),
    );
  }
}

class _DatePickerRoute<T> extends PopupRoute<T> {
  _DatePickerRoute({
    this.showTitleActions = false,
    this.onChanged,
    this.onConfirm,
    theme,
    this.barrierLabel,
    this.locale,
    this.loopList,
    RouteSettings? settings,
    pickerModel,
  })  : pickerModel = pickerModel ?? DatePickerModel(),
        theme = theme ?? DatePickerTheme.autoColor(),
        super(settings: settings);

  final bool showTitleActions;
  final DateChangedCallback? onChanged;
  final DateChangedCallback? onConfirm;
  final DatePickerTheme theme;
  final LocaleType? locale;
  final bool? loopList;
  final CommonPickerData pickerModel;

  @override
  Duration get transitionDuration => const Duration(milliseconds: 200);

  @override
  bool get barrierDismissible => true;

  @override
  final String? barrierLabel;

  @override
  Color get barrierColor => Colors.black54;

  AnimationController? _animationController;

  @override
  AnimationController createAnimationController() {
    _animationController =
        BottomSheet.createAnimationController(navigator!.overlay!);
    return _animationController!;
  }

  @override
  Widget buildPage(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation) {
    Widget bottomSheet = MediaQuery.removePadding(
      context: context,
      removeTop: true,
      child: _DatePickerComponent(
        onChanged: onChanged,
        locale: locale,
        route: this,
        pickerModel: pickerModel,
        loopList: loopList,
      ),
    );
    ThemeData inheritTheme = Theme.of(context);
    bottomSheet = Theme(data: inheritTheme, child: bottomSheet);
    return bottomSheet;
  }
}

class _DatePickerComponent extends StatefulWidget {
  _DatePickerComponent({
    Key? key,
    required this.route,
    this.onChanged,
    this.locale,
    required this.pickerModel,
    bool? loopList,
  })  : loop = loopList ?? pickerModel.columnCount > 1,
        super(key: key);

  final DateChangedCallback? onChanged;

  final _DatePickerRoute route;

  final LocaleType? locale;

  final bool loop;

  final CommonPickerData pickerModel;

  @override
  State<StatefulWidget> createState() {
    return _DatePickerState();
  }
}

class _DatePickerState extends State<_DatePickerComponent> {
  List<FixedExtentScrollController> scrollList = [];
  List<ValueNotifier<int>> changers = [];

  @override
  void initState() {
    super.initState();
    init();
  }

  void init() {
    scrollList.clear();
    changers.clear();
    var allCount = widget.pickerModel.getColumnCount();
    List.generate(allCount, (columnIndex) {
      var index = widget.pickerModel.getColumnIndex(columnIndex);
//      LogUtil.printLog("index: $index");
      scrollList.add(FixedExtentScrollController(initialItem: index));
      changers.add(ValueNotifier(0));
    });
  }

  void refreshScrollOffset(int currentColumn) {
    if (currentColumn < scrollList.length - 1) {
      for (var i = currentColumn + 1; i < scrollList.length; ++i) {
        var columnIndex = widget.pickerModel.getColumnIndex(i);
//        LogUtil.printLog("refresh--> column: $i -- index: $columnIndex");
//        scrollList[i] = FixedExtentScrollController(initialItem: columnIndex);
        scrollList[i].jumpToItem(columnIndex);
        changers[i].value++;
      }
    }
  }

  void refreshColumnIndex(int columnIndex, int itemIndex) {
    widget.pickerModel.setColumnIndex(columnIndex, itemIndex);
  }

  @override
  Widget build(BuildContext context) {
    DatePickerTheme theme = widget.route.theme;

    return GestureDetector(
      child: AnimatedBuilder(
        animation: widget.route.animation!,
        builder: (BuildContext context, Widget? child) {
          return ClipRect(
            child: CustomSingleChildLayout(
              delegate: _BottomPickerLayout(
                widget.route.animation!.value,
                theme,
                showTitleActions: widget.route.showTitleActions,
              ),
              child: GestureDetector(
                child: Material(
                  color: Colors.transparent,
                  child: _renderPickerView(theme),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  void _notifyDateChanged() {
    if (widget.onChanged != null) {
      widget.onChanged!(widget.pickerModel.onComplete()!);
    }
  }

  Widget _renderPickerView(DatePickerTheme theme) {
    Widget itemView = _renderItemView(theme);
    if (widget.route.showTitleActions) {
      return Column(
        children: <Widget>[
          _renderTitleActionsView(theme),
          itemView,
        ],
      );
    }
    return itemView;
  }

  /// 滑动Column
  Widget _renderItemView(DatePickerTheme theme) {
    return Container(
      color: theme.backgroundColor ?? Colors.white,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: _getColumnsView(theme),
      ),
    );
  }

  List<Widget> _getColumnsView(DatePickerTheme theme) {
    var allCount = widget.pickerModel.getColumnCount();

    List<Widget> allWidget = [];
    List.generate(
      allCount,
      (columnIndex) {
        if (columnIndex > 0) {
          allWidget.add(
            Text(widget.pickerModel.leftDivider(), style: theme.itemStyle),
          );
        }
        allWidget.add(
          _PickerColumn(
            theme: theme,
            loopList: widget.loop,
            column: columnIndex,
            controller: scrollList[columnIndex],
            viewRefresh: changers[columnIndex],
            changer: (itemIndex) {
              refreshColumnIndex(columnIndex, itemIndex);
            },
            changerEnd: (index) {
              refreshScrollOffset(columnIndex);
              _notifyDateChanged();
            },
            createWidgetList: () {
              return widget.pickerModel.getColumnItem(columnIndex).map((v) {
                return Align(
                  alignment: Alignment.center,
                  child: Text(v.show(), style: theme.itemStyle),
                );
              }).toList();
            },
          ),
        );
      },
    );
    return allWidget;
  }

  /// Title View
  /// 标题
  Widget _renderTitleActionsView(DatePickerTheme theme) {
    String done = _localeDone();
    String cancel = _localeCancel();

    return Container(
      height: theme.titleHeight,
      decoration: BoxDecoration(color: theme.backgroundColor ?? Colors.white),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          SizedBox(
            height: theme.titleHeight,
            child: CupertinoButton(
              pressedOpacity: 0.3,
              padding: const EdgeInsets.only(left: 16, top: 0),
              child: Text(cancel, style: theme.cancelStyle),
              onPressed: () => Navigator.pop(context),
            ),
          ),
          SizedBox(
            height: theme.titleHeight,
            child: CupertinoButton(
              pressedOpacity: 0.3,
              padding: const EdgeInsets.only(right: 16, top: 0),
              child: Text(done, style: theme.doneStyle),
              onPressed: () {
                Navigator.pop(context);
                if (widget.route.onConfirm != null) {
                  widget.route.onConfirm!(widget.pickerModel.onComplete()!);
                }
              },
            ),
          ),
        ],
      ),
    );
  }

  String _localeDone() {
    return i18nObjInLocale(widget.locale!)?['done'];
  }

  String _localeCancel() {
    return i18nObjInLocale(widget.locale!)?['cancel'];
  }
}

class _PickerColumn extends StatefulWidget {
  const _PickerColumn({
    Key? key,
    this.column,
    required this.createWidgetList,
    this.controller,
    required this.theme,
    required this.changer,
    this.changerEnd,
    required this.viewRefresh,
    this.loopList = true,
  }) : super(key: key);

  final bool loopList;
  final CreateWidgetList createWidgetList;
  final FixedExtentScrollController? controller;
  final DatePickerTheme theme;
  final ValueChanged<int> changer;
  final ValueChanged<int>? changerEnd;
  final ValueNotifier<int> viewRefresh;

  final int? column;

  @override
  State createState() {
    return _PickerColumnState();
  }
}

class _PickerColumnState extends State<_PickerColumn> {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ValueListenableBuilder(
        valueListenable: widget.viewRefresh,
        builder: (_, ___, ____) {
          return Container(
            padding: const EdgeInsets.all(8.0),
            height: widget.theme.containerHeight,
            decoration: BoxDecoration(
                color: widget.theme.backgroundColor ?? Colors.white),
            child: NotificationListener(
              onNotification: (ScrollNotification notification) {
                if (notification.depth == 0 &&
                    widget.changerEnd != null &&
                    notification is ScrollEndNotification &&
                    notification.metrics is FixedExtentMetrics) {
                  final FixedExtentMetrics metrics =
                      valueByType(notification.metrics, FixedExtentMetrics);
                  final int currentItemIndex = metrics.itemIndex;
                  widget.changerEnd!(currentItemIndex);
                }
                return false;
              },
              child: CupertinoPicker(
                looping: widget.loopList,
                backgroundColor: widget.theme.backgroundColor ?? Colors.white,
                scrollController: widget.controller,
                itemExtent: widget.theme.itemHeight,
                onSelectedItemChanged: (int index) {
                  widget.changer(index);
                },
                useMagnifier: true,
                children: widget.createWidgetList(),
              ),
            ),
          );
        },
      ),
    );
  }
}

class _BottomPickerLayout extends SingleChildLayoutDelegate {
  _BottomPickerLayout(this.progress, this.theme,
      {this.itemCount, this.showTitleActions});

  final double progress;
  final int? itemCount;
  final bool? showTitleActions;
  final DatePickerTheme theme;

  @override
  BoxConstraints getConstraintsForChild(BoxConstraints constraints) {
    double maxHeight = theme.containerHeight;
    if (showTitleActions != null && showTitleActions!) {
      maxHeight += theme.titleHeight;
    }

    return BoxConstraints(
        minWidth: constraints.maxWidth,
        maxWidth: constraints.maxWidth,
        minHeight: 0.0,
        maxHeight: maxHeight);
  }

  @override
  Offset getPositionForChild(Size size, Size childSize) {
    double height = size.height - childSize.height * progress;
    return Offset(0.0, height);
  }

  @override
  bool shouldRelayout(_BottomPickerLayout oldDelegate) {
    return progress != oldDelegate.progress;
  }
}
