import 'package:flutter/widgets.dart';

import '../../fast_develop.dart';

/// 子类生成器
typedef ItemBuild<T> = T Function(dynamic data);

class ListKV {
  late List<KeyValue> list;
  ListKV();

  factory ListKV.fromJson(Map<String, dynamic> json) {
    var v = ListKV();
    v..list = KeyValue.list(json);
    return v;
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = Map<String, dynamic>();
    list.forEach((element) => json[element.key] = element.value);
    return json;
  }
}

class KeyValue<T> {
  static List<KeyValue<String>> listStr(json) {
    List<KeyValue<String>> data = [];
    if (json != null && json is Map)
      json.forEach((key, value) => data.add(KeyValue<String>(key, value)));
    return data;
  }

  static List<KeyValue> list(json) {
    List<KeyValue> data = [];
    if (json != null && json is Map)
      json.forEach((key, value) => data.add(KeyValue<String>(key, value)));
    return data;
  }

  String key;
  T value;
  KeyValue(this.key, this.value);
}

enum _CompareType { dayu, dengyu, xiaoyu }

bool versionCompare(String local, String cloud) {
  try {
    List _local = local.split(".");
    List _cloud = cloud.split(".");
    if (_local.length != _cloud.length) {
      return false;
    }

    List<_CompareType> resultList = [];

    for (var i = 0; i < _local.length; i++) {
      int a = IntUtil.parse(_cloud[i]);
      int b = IntUtil.parse(_local[i]);
//      LogUtil.printLog("a: $a --- b: $b");
      if (a > b) {
        resultList.add(_CompareType.dayu);
      } else if (a == b) {
        resultList.add(_CompareType.dengyu);
      } else {
        resultList.add(_CompareType.xiaoyu);
      }
    }

    bool result = false;
    if (resultList[0] == _CompareType.dayu) {
      result = true;
    } else if (resultList[0] == _CompareType.dengyu &&
        resultList[1] == _CompareType.dayu) {
      result = true;
    } else if (resultList[0] == _CompareType.dengyu &&
        resultList[1] == _CompareType.dengyu &&
        resultList[2] == _CompareType.dayu) {
      result = true;
    } else {
      result = false;
    }
    return result;
  } catch (e) {
    return false;
  }
}

List<T> listOf<T>(value, ItemBuild<T> itemBuild) =>
    valueByType<T>(value, List, itemBuild: itemBuild);

List<String> listStrOf(data) => listOf<String>(data, (data) => data);
String strOf(data) => valueByType(data, String);
int intOf(data) => valueByType(data, int);
double doubleOf(data) => valueByType(data, double);
bool boolOf(data) => valueByType(data, bool);

/// 值转换
/// [dValue] 默认值
dynamic valueByType<T>(
  value,
  Type type, {
  String stack: "",
  ItemBuild<T>? itemBuild,
  bool nullable = false,
  T? dValue,
}) {
  if (value == null) {
//    debugPrint("valueByType  $stack : value is null");
    if (nullable) return null;

    if (type == String) {
      return null;
    } else if (type == int) {
      return dValue ?? 0;
    } else if (type == double) {
      return dValue ?? 0.00;
    } else if (type == bool) {
      return dValue ?? false;
    } else if (type == List) {
      return dValue ?? [];
    } else if (type == Map) {
      return dValue ?? {};
    }
    return null;
  } else {
    if (value.runtimeType == type) return value;

//  debugPrint("$stack : ${value.runtimeType} is not $type type");
    if (type == String) {
      return value.toString();
    } else if (type == int) {
      return int.tryParse(value.toString());
    } else if (type == double) {
      return DoubleUtil.parse(value.toString());
    } else if (type == bool) {
      return BoolUtil.parse(value.toString());
    } else if (type == List) {
      return ListUtil.parse<T>(value, itemBuild: itemBuild);
    } else if (type == Map) {
      if (value is List) {
        Map<String, dynamic> newValue = {};
        int index = 0;
        value.forEach((item) {
          newValue.update("$index", (v) => item, ifAbsent: () => item);
        });
        return newValue;
      } else {
        return value;
      }
    }
  }
}

void tryCatch(Function? f) {
  try {
    f?.call();
  } catch (e, stack) {
    debugPrint("$e");
    debugPrint("$stack");
  }
}

/// 判断数据
class JudgeData<T> {
  T? value;
  String? toast;

  JudgeData(this.value, {this.toast});
}

extension StringUtil on String {
  bool get e => isEmpty(this);
  bool get en => isNotEmpty(this);

  bool get b => BoolUtil.parse(this);

  static bool isNotEmpty(String? value) {
    return value != null &&
        value.isNotEmpty &&
        value != "" &&
        value.toLowerCase() != "null";
  }

  /// toast  提示，
  static bool isEmpty(String? value, {String? toast}) {
    var result = value == null ||
        value.isEmpty ||
        value == "" ||
        value.toLowerCase() == "null";
    if (result && isNotEmpty(toast)) showToast(toast);
    return result;
  }

  ///  判断数据是否为空 依赖值[JudgeData] 依赖方法 [isEmpty]
  static bool isListEmpty(List<JudgeData<String>> lists) {
    var emptyData = lists.firstWhere(
      (item) => isEmpty(item.value, toast: item.toast),
      orElse: () => JudgeData<String>(null),
    );
    return emptyData.value != null;
  }

  static String parse(dynamic value) {
    if (value is int) {
      return "$value";
    } else if (value is bool) {
      return value ? "1" : "0";
    }

    return value.toString();
  }
}

class DoubleUtil {
  static double parse(dynamic value) {
    double newValue = 0.0;
    if (value is String) {
      if (value == "0.00")
        newValue = 0.00;
      else
        newValue = double.parse(value);
    } else if (value is int) {
      newValue = value * 1.00;
    }
    return newValue;
  }
}

class IntUtil {
  static int parse(dynamic value) {
    if (value == null || (value is String && StringUtil.isEmpty(value))) {
      return 0;
    }

    if (value is String) {
      if (value.startsWith("-")) {
        return -int.parse(value.replaceAll("-", ""));
      }
      return int.parse(value);
    } else if (value is int) {
      return value;
    }

    return 0;
  }

  static bool isEmpty(int? imgPadding) {
    return imgPadding == null;
  }

  static bool isNotEmpty(int? imgPadding) {
    return imgPadding != null;
  }
}

class NumUtil {
  static num parse(dynamic value) {
    if (value == null || (value is String && StringUtil.isEmpty(value))) {
      return 0;
    }

    if (value is num) {
      return value;
    } else if (value is String) {
      return num.parse(value);
    } else {
      return 0;
    }
  }
}

extension BoolUtil on bool {
  /// 转换 int
  int get toInt => convertInt(this);

  static bool parse(dynamic value) {
//    LogUtil.printLog(value);
    if (value is int) {
      return value == 1;
    } else if (value is String) {
      return value == "1" ||
          value.toLowerCase() == "true" ||
          value.toLowerCase() == "ok";
    } else if (value is bool) {
      return value;
    } else {
      return false;
    }
  }

  static int convertInt(bool? value) {
    if (value == null) return 0;
    return value ? 1 : 0;
  }
}

extension ListUtil on List {
  bool get e => isEmpty(this);
  bool get en => isNotEmpty(this);

  static List<String> parseS(dynamic value) => parse<String>(value);

  static List<T> parse<T>(dynamic value, {ItemBuild<T>? itemBuild}) {
    List? data;

    if (value is List) {
      data = value;
    } else if (value is Map) {
      data = value.values.toList();
    } else {
      data = null;
    }

    if (data == null) {
      return [];
    } else {
      List<T> list = [];
      data.forEach((item) {
        var t;
        if (T == String) {
          t = StringUtil.parse(item);
        } else if (T == int) {
          t = IntUtil.parse(item);
        } else {
          t = itemBuild != null ? itemBuild(item) : item;
        }
        list.add(t);
      });
      return list;
    }
  }

  /// 将list 平分
  static List<List<T>> separate<T>(List list, int count) {
    List<List<T>> allList = [];
    for (int i = 0; i < list.length; i += count) {
      List<T> itemList = [];
      for (int x = 0; x < count; x++) {
        var sum = i + x;
        if (sum < list.length) {
          itemList.add(list[sum]);
        }
      }
      allList.add(itemList);
    }
    return allList;
  }

  /// 将list 拼接
  static String toStr(List list, {String splice = ","}) {
    String content = "";
    if (ListUtil.isEmpty(list)) {
      return content;
    }
    list.forEach((item) => content += (item.toString() + splice));
    return content.substring(0, content.length - 1);
  }

  static isEmpty(List? list) {
    return list == null || list.isEmpty;
  }

  static isNotEmpty(List? list) {
    return list != null && list.isNotEmpty;
  }

  static List<String> strToListStr(String data) {
    return strToList<String>(data);
  }

  static List<T> strToList<T>(String data, {String splice = ","}) {
    List<T> list = [];

    if (StringUtil.isEmpty(data)) {
      return list;
    }

    var oldList = data.split(splice);
    oldList.forEach((item) {
      var t;
      if (T == String) {
        t = StringUtil.parse(item);
      } else if (T == int) {
        t = IntUtil.parse(item);
      } else {
        t = item;
      }
      list.add(t);
    });

    return list;
  }
}

class MapUtil {
  static bool isEmpty(Map? map) {
    return map == null || map.isEmpty;
  }

  static bool isNotEmpty(Map? map) {
    return map != null && map.keys.length > 0;
  }
}
