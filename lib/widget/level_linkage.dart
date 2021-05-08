import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../fast_develop.dart';

typedef ChangeData = void Function(Map<String, dynamic> map);
typedef DataItemBuild<T extends BaseItem> = T Function(int index, dynamic data);

abstract class BaseItem {
  String hint();

  String value();

  List<BaseItem> lists();
}

class DefaultItem extends BaseItem {
  String text;
  String data;
  List<BaseItem> list = [];

  DefaultItem({required this.text, required this.data, required this.list});

  @override
  String hint() => text;

  @override
  List<BaseItem> lists() => list;

  @override
  String value() => data;
}

class CityPicker {
  /// 数据装填全部
  static void dataAddAll<T extends BaseItem>(
      List<T> list, DataItemBuild<T> one) {
    if (list[0].hint() == "全部") return;
    list.forEach((T element) {
      element.lists().forEach((e) => e.lists().insert(0, one(2, e.value())));
      element.lists().insert(0, one(1, element.value()));
    });
    list.insert(0, one(0, null));
  }

  static void showPicker<T extends BaseItem>(
    BuildContext context, {
    String? regionJson,
    List<T>? regionList,
    ChangeData? selectProvince,
    ChangeData? selectCity,
    ChangeData? selectArea,
  }) {
    List<T>? data;
    if (regionJson != null) {
      data = json.decode(regionJson);
    } else {
      data = regionList;
    }
    Navigator.push(
      context,
      _CityPickerRoute<T>(
          data: data,
          selectProvince: selectProvince,
          selectCity: selectCity,
          selectArea: selectArea,
          theme: Theme.of(context),
          barrierLabel:
              MaterialLocalizations.of(context).modalBarrierDismissLabel),
    );
  }
}

class _CityPickerRoute<T extends BaseItem> extends PopupRoute {
  _CityPickerRoute({
    this.theme,
    this.barrierLabel,
    this.data,
    this.selectProvince,
    this.selectCity,
    this.selectArea,
  });

  final ThemeData? theme;
  final String? barrierLabel;
  final List<T>? data;
  final ChangeData? selectProvince;
  final ChangeData? selectCity;
  final ChangeData? selectArea;

  @override
  Duration get transitionDuration => Duration(milliseconds: 2000);

  @override
  Color get barrierColor => Colors.black54;

  @override
  bool get barrierDismissible => true;

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
      removeTop: true,
      context: context,
      child: _CityPickerWidget<T>(
        route: this,
        data: data,
        selectProvince: selectProvince,
        selectCity: selectCity,
        selectArea: selectArea,
      ),
    );
    if (theme != null) bottomSheet = Theme(data: theme!, child: bottomSheet);
    return bottomSheet;
  }
}

class _CityPickerWidget<T extends BaseItem> extends StatefulWidget {
  _CityPickerWidget({
    Key? key,
    required this.route,
    this.data,
    this.selectProvince,
    this.selectCity,
    this.selectArea,
  }) : super(key: key);

  final _CityPickerRoute route;
  final List<T>? data;
  final ChangeData? selectProvince;
  final ChangeData? selectCity;
  final ChangeData? selectArea;

  @override
  State createState() => _CityPickerState();
}

class _CityPickerState<T extends BaseItem> extends State<_CityPickerWidget> {
  late FixedExtentScrollController? provinceController;
  late FixedExtentScrollController? cityController;
  late FixedExtentScrollController? areaController;
  int provinceIndex = 0, cityIndex = 0, areaIndex = 0;
  late List<BaseItem>? province = [];
  late List<BaseItem>? city;
  late List<BaseItem>? area;

  @override
  void initState() {
    super.initState();
    provinceController = FixedExtentScrollController();
    cityController = FixedExtentScrollController();
    areaController = FixedExtentScrollController();
    setState(() => setData(0));
  }

  setData(int index) {
    if (index == 0) province = widget.data;
    if (index == 0 || index == 1)
      city = widget.data?[provinceIndex].lists() ?? [];
    if (index == 0 || index >= 1) {
      var areaList = widget.data![provinceIndex].lists();
      area = areaList.e ? [] : (areaList[cityIndex].lists());
    }
  }

  Widget _bottomView() {
    return Container(
      width: double.infinity,
      color: CConfig.cBackgroundColor,
      child: Column(children: <Widget>[
        Expanded(
          child: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text(
                  '取消',
                  style: TextStyle(
                    color: Theme.of(context).primaryColor,
                  ),
                ),
              ),
              TextButton(
                onPressed: () {
                  Map<String, dynamic> provinceMap = {
                    "code": province![provinceIndex].value(),
                    "name": province![provinceIndex].hint(),
                  };
                  var cityList = province![provinceIndex].lists();
                  Map<String, dynamic> cityMap = {
                    "code": cityList.e ? "" : cityList[cityIndex].value(),
                    "name": cityList.e ? "" : cityList[cityIndex].hint(),
                  };
                  var areaList =
                      cityList.e ? null : cityList[cityIndex].lists();
                  Map<String, dynamic> areaMap = {
                    "code": areaList.e ? "" : areaList![areaIndex].value(),
                    "name": areaList.e ? "" : areaList![areaIndex].hint(),
                  };
                  if (widget.selectProvince != null)
                    widget.selectProvince!(provinceMap);
                  if (widget.selectCity != null) widget.selectCity!(cityMap);
                  if (widget.selectArea != null) widget.selectArea!(areaMap);
                  Navigator.pop(context);
                },
                child: Text(
                  '确定',
                  style: TextStyle(
                    color: Theme.of(context).primaryColor,
                  ),
                ),
              ),
            ],
          ),
        ),
        Row(children: <Widget>[
          _MyCityPicker(
            key: Key('province'),
            controller: provinceController,
            createWidgetList: () {
              return province!.map((v) {
                return Center(
                  child: Text(
                    v.hint(),
                    style: StyleText.normal(),
                    textScaleFactor: 1.2,
                  ),
                );
              }).toList();
            },
            changed: (index) {
              setState(() {
                provinceIndex = index;
                cityIndex = 0;
                areaIndex = 0;
                cityController?.jumpToItem(0);
                areaController?.jumpToItem(0);
                setData(1);
              });
            },
          ),
          _MyCityPicker(
            key: Key('city'),
            controller: cityController,
            createWidgetList: () {
              return city!.map((v) {
                return Center(
                  child: Text(
                    v.hint(),
                    style: StyleText.normal(),
                    textScaleFactor: 1.2,
                  ),
                );
              }).toList();
            },
            changed: (index) {
              setState(() {
                cityIndex = index;
                areaIndex = 0;
                areaController?.jumpToItem(0);
                setData(2);
              });
            },
          ),
          _MyCityPicker(
            key: Key('area'),
            controller: areaController,
            createWidgetList: () {
              return area!.map((v) {
                return Center(
                  child: Text(
                    v.hint(),
                    style: StyleText.normal(),
                    textScaleFactor: 1.2,
                  ),
                );
              }).toList();
            },
            changed: (index) {
              setState(() {
                areaIndex = index;
              });
            },
          ),
        ])
      ]),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: AnimatedBuilder(
        animation: widget.route.animation!,
        builder: (BuildContext context, Widget? child) {
          return ClipRect(
            child: CustomSingleChildLayout(
              delegate: _BottomPickerLayout(widget.route.animation!.value),
              child: GestureDetector(
                child: Material(
                  color: Colors.transparent,
                  child: Container(
                    width: double.infinity,
                    height: 260.0,
                    child: _bottomView(),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

class _MyCityPicker extends StatefulWidget {
  _MyCityPicker({
    this.createWidgetList,
    this.key,
    this.controller,
    this.changed,
  });

  final CreateWidgetList? createWidgetList;
  final Key? key;
  final FixedExtentScrollController? controller;
  final ValueChanged<int>? changed;

  @override
  State createState() => _MyCityPickerState();
}

class _MyCityPickerState extends State<_MyCityPicker> {
  @override
  Widget build(BuildContext context) {
    if (widget.createWidgetList!().e) return Spacing.vView();
    return Expanded(
      child: Container(
        height: 220.0,
        child: CupertinoPicker(
          backgroundColor: CConfig.cBackgroundColor,
          scrollController: widget.controller,
          key: widget.key,
          itemExtent: 30.0,
          onSelectedItemChanged: (index) {
            if (widget.changed != null) widget.changed!(index);
          },
          children: widget.createWidgetList!().length > 0
              ? widget.createWidgetList!()
              : [Center(child: Text(""))],
        ),
      ),
    );
  }
}

class _BottomPickerLayout extends SingleChildLayoutDelegate {
  _BottomPickerLayout(this.progress, {this.itemCount, this.showTitleActions});

  final double progress;
  final int? itemCount;
  final bool? showTitleActions;

  @override
  BoxConstraints getConstraintsForChild(BoxConstraints constraints) {
    double maxHeight = 300.0;

    return BoxConstraints(
      minWidth: constraints.maxWidth,
      maxWidth: constraints.maxWidth,
      minHeight: 0.0,
      maxHeight: maxHeight,
    );
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
