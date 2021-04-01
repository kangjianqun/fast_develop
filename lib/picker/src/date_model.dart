import 'date_format.dart';
import 'datetime_util.dart';
import 'dart:math';

import 'i18n_model.dart';

typedef String StringAtIndex(int index);
typedef int ColumnValueKey();

class ItemData {
  dynamic data;
  String hint;
  String show() => hint;

  ItemData(this.hint, {this.data});
}

class CompleteData {
  DateTime? dateTime;
  List<ItemData>? data;
  CompleteData({this.dateTime, this.data});
}

/// 选择器数据模型的基类
class CommonPickerData {
  Map<int, List<ItemData>> _content = Map<int, List<ItemData>>();
  Map<int, int> _currentIndex = Map<int, int>();
  int columnCount;
  DateTime currentTime;
  LocaleType locale;

  CommonPickerData({this.currentTime, locale, this.columnCount = 3})
      : this.locale = locale ?? LocaleType.en;

  String leftDivider() {
    return "";
  }

  String rightDivider() {
    return "";
  }

  List<int> layoutProportions() {
    return [1, 1, 1];
  }

  CompleteData onComplete() {
    return null;
  }

  int getColumnCount() {
    return this.columnCount;
  }

  int getColumnIndex(int column) {
    return _currentIndex[column] ?? 0;
  }

  String getContentAtIndex(int column, int index) {
    return _content[column][index].show();
  }

  void setColumnIndex(int column, int index) {
    _currentIndex.update(column, (v) => index, ifAbsent: () => index);
  }

  int getColumnItemCount(int column) {
    return _content[column].length;
  }

  void setColumnContent(int column, List<ItemData> contents) {
    _content.update(column, (v) => contents, ifAbsent: () => contents);
  }

  List<ItemData> getColumnItem(int column) {
    return _content[column];
  }
}

class SingleColumnData extends CommonPickerData {
  SingleColumnData(
    List<ItemData> data,
    String itemData, {
    locale,
  }) : super(columnCount: 1, locale: locale ?? LocaleType.en) {
    _content[0] = data;

    var index = data.indexWhere((item) => item.show() == itemData);
    _currentIndex[0] = index == -1 ? 0 : index;
  }

  @override
  CompleteData onComplete() {
    return CompleteData(data: [_content[0][_currentIndex[0]]]);
  }
}

/// a date picker model
/// 日期选择器模型
class DatePickerModel extends CommonPickerData {
  DateTime maxTime;
  DateTime minTime;

  DatePickerModel(
      {DateTime currentTime,
      DateTime maxTime,
      DateTime minTime,
      LocaleType locale})
      : super(locale: locale) {
    this.maxTime = maxTime ?? DateTime(2049, 12, 31);
    this.minTime = minTime ?? DateTime(1970, 1, 1);

    currentTime = currentTime ?? DateTime.now();
    if (currentTime != null) {
      if (currentTime.compareTo(this.maxTime) > 0) {
        currentTime = this.maxTime;
      } else if (currentTime.compareTo(this.minTime) < 0) {
        currentTime = this.minTime;
      }
    }
    this.currentTime = currentTime;

    _fillLeftLists();
    _fillMiddleLists();
    _fillRightLists();
    int minMonth = _minMonthOfCurrentYear();
    int minDay = _minDayOfCurrentMonth();
    _currentIndex[0] = this.currentTime.year - this.minTime.year;
    _currentIndex[1] = this.currentTime.month - minMonth;
    _currentIndex[2] = this.currentTime.day - minDay;
  }

  void _fillLeftLists() {
    List<ItemData> list =
        List.generate(maxTime.year - minTime.year + 1, (int index) {
      return ItemData('${minTime.year + index}${_localeYear()}');
    });
    setColumnContent(0, list);
  }

  int _maxMonthOfCurrentYear() {
    return currentTime.year == maxTime.year ? maxTime.month : 12;
  }

  int _minMonthOfCurrentYear() {
    return currentTime.year == minTime.year ? minTime.month : 1;
  }

  int _maxDayOfCurrentMonth() {
    int dayCount = calcDateCount(currentTime.year, currentTime.month);
    return currentTime.year == maxTime.year &&
            currentTime.month == maxTime.month
        ? maxTime.day
        : dayCount;
  }

  int _minDayOfCurrentMonth() {
    return currentTime.year == minTime.year &&
            currentTime.month == minTime.month
        ? minTime.day
        : 1;
  }

  void _fillMiddleLists() {
    int minMonth = _minMonthOfCurrentYear();
    int maxMonth = _maxMonthOfCurrentYear();

    List<ItemData> list = List.generate(maxMonth - minMonth + 1, (int index) {
      return ItemData('${_localeMonth(minMonth + index)}');
    });
    setColumnContent(1, list);
  }

  void _fillRightLists() {
    int maxDay = _maxDayOfCurrentMonth();
    int minDay = _minDayOfCurrentMonth();
    List<ItemData> list = List.generate(maxDay - minDay + 1, (int index) {
      return ItemData('${minDay + index}${_localeDay()}');
    });
    setColumnContent(2, list);
  }

  @override
  void setColumnIndex(int column, int index) {
    super.setColumnIndex(column, index);
    if (column == 0) {
      setLeftIndex(index);
    } else if (column == 1) {
      setMiddleIndex(index);
    } else if (column == 2) {
      setRightIndex(index);
    }
  }

  @override
  String getContentAtIndex(int column, int index) {
    if (index >= 0 && index < _content[column].length) {
      return _content[column][index].show();
    } else {
      return null;
    }
  }

  void setLeftIndex(int index) {
    int destYear = index + minTime.year;
    int minMonth = _minMonthOfCurrentYear();
    DateTime newTime;
    if (currentTime.month == 2 && currentTime.day == 29) {
      newTime = currentTime.isUtc
          ? DateTime.utc(
              destYear, currentTime.month, calcDateCount(destYear, 2))
          : DateTime(destYear, currentTime.month, calcDateCount(destYear, 2));
    } else {
      newTime = currentTime.isUtc
          ? DateTime.utc(destYear, currentTime.month, currentTime.day)
          : DateTime(destYear, currentTime.month, currentTime.day);
    }
    //min/max check
    if (newTime.isAfter(maxTime)) {
      currentTime = maxTime;
    } else if (newTime.isBefore(minTime)) {
      currentTime = minTime;
    } else {
      currentTime = newTime;
    }

    _fillMiddleLists();
    _fillRightLists();
    minMonth = _minMonthOfCurrentYear();
    int minDay = _minDayOfCurrentMonth();
    _currentIndex[1] = currentTime.month - minMonth;
    _currentIndex[2] = currentTime.day - minDay;
  }

  void setMiddleIndex(int index) {
    //adjust right
    int minMonth = _minMonthOfCurrentYear();
    int destMonth = minMonth + index;
    DateTime newTime;
    //change date time
    int dayCount = calcDateCount(currentTime.year, destMonth);
    newTime = currentTime.isUtc
        ? DateTime.utc(
            currentTime.year,
            destMonth,
            currentTime.day <= dayCount ? currentTime.day : dayCount,
          )
        : DateTime(
            currentTime.year,
            destMonth,
            currentTime.day <= dayCount ? currentTime.day : dayCount,
          );
    //min/max check
    if (newTime.isAfter(maxTime)) {
      currentTime = maxTime;
    } else if (newTime.isBefore(minTime)) {
      currentTime = minTime;
    } else {
      currentTime = newTime;
    }

    _fillRightLists();
    int minDay = _minDayOfCurrentMonth();
    _currentIndex[2] = currentTime.day - minDay;
  }

  void setRightIndex(int index) {
    int minDay = _minDayOfCurrentMonth();
    currentTime = currentTime.isUtc
        ? DateTime.utc(currentTime.year, currentTime.month, minDay + index)
        : DateTime(currentTime.year, currentTime.month, minDay + index);
  }

  String _localeYear() {
    if (locale == LocaleType.zh) {
      return '年';
    } else if (locale == LocaleType.ko) {
      return '년';
    } else {
      return '';
    }
  }

  String _localeMonth(int month) {
    if (locale == LocaleType.zh) {
      return '$month月';
    } else if (locale == LocaleType.ko) {
      return '$month월';
    } else {
      List monthStrings = i18nObjInLocale(locale)['monthLong'];
      return monthStrings[month - 1];
    }
  }

  String _localeDay() {
    if (locale == LocaleType.zh) {
      return '日';
    } else if (locale == LocaleType.ko) {
      return '일';
    } else {
      return '';
    }
  }

  @override
  CompleteData onComplete() {
    return CompleteData(dateTime: currentTime);
  }
}

/// a time picker model
/// 时间选择器模型
class TimePickerModel extends CommonPickerData {
  TimePickerModel({DateTime currentTime, LocaleType locale})
      : super(locale: locale) {
    this.currentTime = currentTime ?? DateTime.now();
    _currentIndex[0] = this.currentTime.hour;
    _currentIndex[1] = this.currentTime.minute;
    _currentIndex[2] = this.currentTime.second;
  }

  @override
  String getContentAtIndex(int column, int index) {
    if (index >= 0 && index < (column == 0 ? 24 : 60)) {
      return digits(index, 2);
    } else {
      return null;
    }
  }

  @override
  String leftDivider() {
    return ":";
  }

  @override
  String rightDivider() {
    return ":";
  }

  @override
  CompleteData onComplete() {
    return CompleteData(
      dateTime: currentTime.isUtc
          ? DateTime.utc(currentTime.year, currentTime.month, currentTime.day,
              _currentIndex[0], _currentIndex[1], _currentIndex[2])
          : DateTime(currentTime.year, currentTime.month, currentTime.day,
              _currentIndex[0], _currentIndex[1], _currentIndex[2]),
    );
  }
}

/// a date&time picker model
/// 日期和时间选择器模型
class DateTimePickerModel extends CommonPickerData {
  DateTime maxTime;
  DateTime minTime;
  DateTimePickerModel(
      {DateTime? currentTime,
      DateTime? maxTime,
      DateTime? minTime,
      LocaleType? locale})
      : super(locale: locale) {
    if (currentTime != null) {
      this.currentTime = currentTime;
      if (maxTime != null && currentTime.isBefore(maxTime)) {
        this.maxTime = maxTime;
      }
      if (minTime != null && currentTime.isAfter(minTime)) {
        this.minTime = minTime;
      }
    } else {
      this.maxTime = maxTime;
      this.minTime = minTime;
      var now = DateTime.now();
      if (this.minTime != null && this.minTime.isAfter(now)) {
        this.currentTime = this.minTime;
      } else if (this.maxTime != null && this.maxTime.isBefore(now)) {
        this.currentTime = this.maxTime;
      } else {
        this.currentTime = now;
      }
    }

    if (this.minTime != null &&
        this.maxTime != null &&
        this.maxTime.isBefore(this.minTime)) {
      this.minTime = null;
      this.maxTime = null;
    }

    _currentIndex[0] = 0;
    _currentIndex[1] = this.currentTime.hour;
    _currentIndex[2] = this.currentTime.minute;
    if (this.minTime != null && isAtSameDay(this.minTime, this.currentTime)) {
      _currentIndex[1] = this.currentTime.hour - this.minTime.hour;
      if (_currentIndex[1] == 0) {
        _currentIndex[2] = this.currentTime.minute - this.minTime.minute;
      }
    }
  }

  bool isAtSameDay(DateTime day1, DateTime day2) {
    return day1 != null &&
        day2 != null &&
        day1.difference(day2).inDays == 0 &&
        day1.day == day2.day;
  }

  @override
  void setColumnIndex(int column, int index) {
    if (column == 0) {
      setLeftIndex(index);
    } else if (column == 1) {
      setMiddleIndex(index);
    }
  }

  void setLeftIndex(int index) {
    DateTime time = currentTime.add(Duration(days: index));
    if (isAtSameDay(minTime, time)) {
      var index = min(24 - minTime.hour - 1, _currentIndex[1]);
      this.setMiddleIndex(index);
    } else if (isAtSameDay(maxTime, time)) {
      var index = min(maxTime.hour, _currentIndex[1]);
      this.setMiddleIndex(index);
    }
  }

  void setMiddleIndex(int index) {
    DateTime time = currentTime.add(Duration(days: _currentIndex[0]));
    if (isAtSameDay(minTime, time) && index == 0) {
      var maxIndex = 60 - minTime.minute - 1;
      if (_currentIndex[2] > maxIndex) {
        _currentIndex[2] = maxIndex;
      }
    } else if (isAtSameDay(maxTime, time) && _currentIndex[1] == maxTime.hour) {
      var maxIndex = maxTime.minute;
      if (_currentIndex[2] > maxIndex) {
        _currentIndex[2] = maxIndex;
      }
    }
  }

  @override
  String getContentAtIndex(int column, int index) {
    if (column == 0) {
      return leftStringAtIndex(index);
    } else if (column == 1) {
      return middleStringAtIndex(index);
    } else if (column == 2) {
      return rightStringAtIndex(index);
    } else {
      return null;
    }
  }

  String leftStringAtIndex(int index) {
    DateTime time = currentTime.add(Duration(days: index));
    if (minTime != null &&
        time.isBefore(minTime) &&
        !isAtSameDay(minTime, time)) {
      return null;
    } else if (maxTime != null &&
        time.isAfter(maxTime) &&
        !isAtSameDay(maxTime, time)) {
      return null;
    }
    return formatDate(time, [ymdw], locale);
  }

  String middleStringAtIndex(int index) {
    if (index >= 0 && index < 24) {
      DateTime time = currentTime.add(Duration(days: _currentIndex[0]));
      if (isAtSameDay(minTime, time)) {
        if (index >= 0 && index < 24 - minTime.hour) {
          return digits(minTime.hour + index, 2);
        } else {
          return null;
        }
      } else if (isAtSameDay(maxTime, time)) {
        if (index >= 0 && index <= maxTime.hour) {
          return digits(index, 2);
        } else {
          return null;
        }
      }
      return digits(index, 2);
    }

    return null;
  }

  String rightStringAtIndex(int index) {
    if (index >= 0 && index < 60) {
      DateTime time = currentTime.add(Duration(days: _currentIndex[0]));
      if (isAtSameDay(minTime, time) && _currentIndex[1] == 0) {
        if (index >= 0 && index < 60 - minTime.minute) {
          return digits(minTime.minute + index, 2);
        } else {
          return null;
        }
      } else if (isAtSameDay(maxTime, time) &&
          _currentIndex[1] >= maxTime.hour) {
        if (index >= 0 && index <= maxTime.minute) {
          return digits(index, 2);
        } else {
          return null;
        }
      }
      return digits(index, 2);
    }

    return null;
  }

  @override
  CompleteData onComplete() {
    DateTime time = currentTime.add(Duration(days: _currentIndex[0]));
    var hour = _currentIndex[1];
    var minute = _currentIndex[2];
    if (isAtSameDay(minTime, time)) {
      hour += minTime.hour;
      if (minTime.hour == hour) {
        minute += minTime.minute;
      }
    }

    return CompleteData(
      dateTime: currentTime.isUtc
          ? DateTime.utc(time.year, time.month, time.day, hour, minute)
          : DateTime(time.year, time.month, time.day, hour, minute),
    );
  }

  @override
  List<int> layoutProportions() {
    return [4, 1, 1];
  }

  @override
  String rightDivider() {
    return ':';
  }
}
