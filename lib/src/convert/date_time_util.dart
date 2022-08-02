extension DateTimeUtil on int {
  String get time => _time(this);

  DateTime get dateTime => _dateTime(this);

  static String _time(int time) {
    time = _timeCompletion(time);
    var timeStr = DateTime.fromMillisecondsSinceEpoch(time).toString();

    int i = timeStr.indexOf(".");
    return timeStr.substring(0, i);
  }

  static DateTime _dateTime(int time) {
    time = _timeCompletion(time);
    return DateTime.fromMillisecondsSinceEpoch(time);
  }

  /// 时间补全
  static int _timeCompletion(int time) {
    var timeLength = time.toString().length;
    if (timeLength == 10) {
      time *= 1000;
    } else if (timeLength == 11) {
      time *= 100;
    } else if (timeLength == 12) {
      time *= 10;
    }
    return time;
  }
}
