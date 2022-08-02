
import '../fast_develop.dart';

class GlobalValue {
  static final Map<int, dynamic> _data = {};

  static const key = "globalKey";

  static int putValue(dynamic value) {
    int key = value.hashCode;
    _data.update(key, (v) => value, ifAbsent: () => value);
    return key;
  }

  static T getValue<T>(key, {bool delete = true}) {
    key = IntUtil.parse(key);
    T value = _data.containsKey(key) ? _data[key] : null;
    if (delete) _data.removeWhere((key, value) => key == key);
    return value;
  }
}
