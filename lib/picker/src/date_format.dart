import 'i18n_model.dart';

/// Outputs year as four digits
///
/// Example:
///     formatDate(new DateTime(2018,8,31), [ymdw]);
///     // => Today
const String ymdw = 'ymdw';

///
/// Example:
///     formatDate(new DateTime(1989), [yyyy]);
///     // => 1989
const String _yyyy = 'yyyy';

/// Outputs year as two digits
///
/// Example:
///     formatDate(new DateTime(1989), [yy]);
///     // => 89
const String _yy = 'yy';

/// Outputs month as two digits
///
/// Example:
///     formatDate(new DateTime(1989, 11), [mm]);
///     // => 11
///     formatDate(new DateTime(1989, 5), [mm]);
///     // => 05
const String _mm = 'mm';

/// Outputs month compactly
///
/// Example:
///     formatDate(new DateTime(1989, 11), [mm]);
///     // => 11
///     formatDate(new DateTime(1989, 5), [m]);
///     // => 5
const String _m = 'm';

/// Outputs month as long name
///
/// Example:
///     formatDate(new DateTime(1989, 2), [MM]);
///     // => february
const String _MM = 'MM';

/// Outputs month as short name
///
/// Example:
///     formatDate(new DateTime(1989, 2), [M]);
///     // => feb
const String _M = 'M';

/// Outputs day as two digits
///
/// Example:
///     formatDate(new DateTime(1989, 2, 21), [dd]);
///     // => 21
///     formatDate(new DateTime(1989, 2, 5), [dd]);
///     // => 05
const String _dd = 'dd';

/// Outputs day compactly
///
/// Example:
///     formatDate(new DateTime(1989, 2, 21), [d]);
///     // => 21
///     formatDate(new DateTime(1989, 2, 5), [d]);
///     // => 5
const String _d = 'd';

/// Outputs week in month
///
/// Example:
///     formatDate(new DateTime(1989, 2, 21), [w]);
///     // => 4
const String _w = 'w';

/// Outputs week in year as two digits
///
/// Example:
///     formatDate(new DateTime(1989, 12, 31), [W]);
///     // => 53
///     formatDate(new DateTime(1989, 2, 21), [W]);
///     // => 08
const String _WW = 'WW';

/// Outputs week in year compactly
///
/// Example:
///     formatDate(new DateTime(1989, 2, 21), [W]);
///     // => 8
const String _W = 'W';

/// Outputs week day as long name
///
/// Example:
///     formatDate(new DateTime(2018, 1, 14), [D]);
///     // => sun
const String _D = 'D';

/// Outputs hour (0 - 11) as two digits
///
/// Example:
///     formatDate(new DateTime(1989, 02, 1, 15), [hh]);
///     // => 03
const String _hh = 'hh';

/// Outputs hour (0 - 11) compactly
///
/// Example:
///     formatDate(new DateTime(1989, 02, 1, 15), [h]);
///     // => 3
const String _h = 'h';

/// Outputs hour (0 to 23) as two digits
///
/// Example:
///     formatDate(new DateTime(1989, 02, 1, 15), [HH]);
///     // => 15
const String _HH = 'HH';

/// Outputs hour (0 to 23) compactly
///
/// Example:
///     formatDate(new DateTime(1989, 02, 1, 5), [H]);
///     // => 5
const String _H = 'H';

/// Outputs minute as two digits
///
/// Example:
///     formatDate(new DateTime(1989, 02, 1, 15, 40), [nn]);
///     // => 40
///     formatDate(new DateTime(1989, 02, 1, 15, 4), [nn]);
///     // => 04
const String _nn = 'nn';

/// Outputs minute compactly
///
/// Example:
///     formatDate(new DateTime(1989, 02, 1, 15, 4), [n]);
///     // => 4
const String _n = 'n';

/// Outputs second as two digits
///
/// Example:
///     formatDate(new DateTime(1989, 02, 1, 15, 40, 10), [ss]);
///     // => 10
///     formatDate(new DateTime(1989, 02, 1, 15, 40, 5), [ss]);
///     // => 05
const String _ss = 'ss';

/// Outputs second compactly
///
/// Example:
///     formatDate(new DateTime(1989, 02, 1, 15, 40, 5), [s]);
///     // => 5
const String _s = 's';

/// Outputs millisecond as three digits
///
/// Example:
///     formatDate(new DateTime(1989, 02, 1, 15, 40, 10, 999), [SSS]);
///     // => 999
///     formatDate(new DateTime(1989, 02, 1, 15, 40, 10, 99), [SS]);
///     // => 099
///     formatDate(new DateTime(1989, 02, 1, 15, 40, 10, 0), [SS]);
///     // => 009
const String _SSS = 'SSS';

/// Outputs millisecond compactly
///
/// Example:
///     formatDate(new DateTime(1989, 02, 1, 15, 40, 10, 999), [SSS]);
///     // => 999
///     formatDate(new DateTime(1989, 02, 1, 15, 40, 10, 99), [SS]);
///     // => 99
///     formatDate(new DateTime(1989, 02, 1, 15, 40, 10, 9), [SS]);
///     // => 9
const String _S = 'S';

/// Outputs microsecond as three digits
///
/// Example:
///     formatDate(new DateTime(1989, 02, 1, 15, 40, 10, 0, 999), [uuu]);
///     // => 999
///     formatDate(new DateTime(1989, 02, 1, 15, 40, 10, 0, 99), [uuu]);
///     // => 099
///     formatDate(new DateTime(1989, 02, 1, 15, 40, 10, 0, 9), [uuu]);
///     // => 009
const String _uuu = 'uuu';

/// Outputs millisecond compactly
///
/// Example:
///     formatDate(new DateTime(1989, 02, 1, 15, 40, 10, 0, 999), [u]);
///     // => 999
///     formatDate(new DateTime(1989, 02, 1, 15, 40, 10, 0, 99), [u]);
///     // => 99
///     formatDate(new DateTime(1989, 02, 1, 15, 40, 10, 0, 9), [u]);
///     // => 9
const String _u = 'u';

/// Outputs if hour is AM or PM
///
/// Example:
///     print(formatDate(new DateTime(1989, 02, 1, 5), [am]));
///     // => AM
///     print(formatDate(new DateTime(1989, 02, 1, 15), [am]));
///     // => PM
const String _am = 'am';

/// Outputs timezone as time offset
///
/// Example:
///
const String _z = 'z';
const String Z = 'Z';

String formatDate(DateTime date, List<String> formats, LocaleType locale) {
  if (formats.first == ymdw) {
    final now = DateTime.now();
    if (date.year == now.year &&
        date.month == now.month &&
        date.day == now.day) {
      //today
      return i18nObjInLocale(locale)?['today'];
    } else if (date.year == now.year) {
      if (locale == LocaleType.zh) {
        return formatDate(date, [_mm, '月', _dd, '日 ', _D], locale);
      } else if (locale == LocaleType.nl) {
        return formatDate(date, [_D, ' ', _dd, ' ', _M], locale);
      } else if (locale == LocaleType.ko) {
        return formatDate(date, [_mm, '월', _dd, '일 ', _D], locale);
      } else if (locale == LocaleType.de) {
        return formatDate(date, [_D, ', ', _dd, '. ', _M], locale);
      } else if (locale == LocaleType.id) {
        return formatDate(date, [_D, ', ', _dd, ' ', _M], locale);
      } else {
        return formatDate(date, [_D, ' ', _M, ' ', _dd], locale);
      }
    } else {
      if (locale == LocaleType.zh) {
        return formatDate(date, [_yyyy, '年', _mm, '月', _dd, '日 ', _D], locale);
      } else if (locale == LocaleType.nl) {
        return formatDate(date, [_D, ' ', _dd, ' ', _M, ' ', _yyyy], locale);
      } else if (locale == LocaleType.ko) {
        return formatDate(date, [_yyyy, '년', _mm, '월', _dd, '일 ', _D], locale);
      } else if (locale == LocaleType.de) {
        return formatDate(date, [_D, ', ', _dd, '. ', _M, ' ', _yyyy], locale);
      } else if (locale == LocaleType.id) {
        return formatDate(date, [_D, ', ', _dd, ' ', _M, ' ', _yyyy], locale);
      } else {
        return formatDate(date, [_D, ' ', _M, ' ', _dd, ', ', _yyyy], locale);
      }
    }
  }

  final sb = new StringBuffer();

  for (String format in formats) {
    if (format == _yyyy) {
      sb.write(digits(date.year, 4));
    } else if (format == _yy) {
      sb.write(digits(date.year % 100, 2));
    } else if (format == _mm) {
      sb.write(digits(date.month, 2));
    } else if (format == _m) {
      sb.write(date.month);
    } else if (format == _MM) {
      String monthLong = i18nObjInLocale(locale)?['monthLong'][date.month - 1];
      sb.write(monthLong);
    } else if (format == _M) {
      String monthShort =
          i18nObjInLocale(locale)?['monthShort'][date.month - 1];
      sb.write(monthShort);
    } else if (format == _dd) {
      sb.write(digits(date.day, 2));
    } else if (format == _d) {
      sb.write(date.day);
    } else if (format == _w) {
      sb.write((date.day + 7) ~/ 7);
    } else if (format == _W) {
      sb.write((dayInYear(date) + 7) ~/ 7);
    } else if (format == _WW) {
      sb.write(digits((dayInYear(date) + 7) ~/ 7, 2));
    } else if (format == _D) {
      String day = i18nObjInLocale(locale)?['day'][date.weekday - 1];
      if (locale == LocaleType.ko) {
        day = "($day)";
      }
      sb.write(day);
    } else if (format == _HH) {
      sb.write(digits(date.hour, 2));
    } else if (format == _H) {
      sb.write(date.hour);
    } else if (format == _hh) {
      sb.write(digits(date.hour % 12, 2));
    } else if (format == _h) {
      sb.write(date.hour % 12);
    } else if (format == _am) {
      sb.write(date.hour < 12
          ? i18nObjInLocale(locale)!['am']
          : i18nObjInLocale(locale)!['pm']);
    } else if (format == _nn) {
      sb.write(digits(date.minute, 2));
    } else if (format == _n) {
      sb.write(date.minute);
    } else if (format == _ss) {
      sb.write(digits(date.second, 2));
    } else if (format == _s) {
      sb.write(date.second);
    } else if (format == _SSS) {
      sb.write(digits(date.millisecond, 3));
    } else if (format == _S) {
      sb.write(date.second);
    } else if (format == _uuu) {
      sb.write(digits(date.microsecond, 2));
    } else if (format == _u) {
      sb.write(date.microsecond);
    } else if (format == _z) {
      if (date.timeZoneOffset.inMinutes == 0) {
        sb.write('Z');
      } else {
        if (date.timeZoneOffset.isNegative) {
          sb.write('-');
          sb.write(digits((-date.timeZoneOffset.inHours) % 24, 2));
          sb.write(digits((-date.timeZoneOffset.inMinutes) % 60, 2));
        } else {
          sb.write('+');
          sb.write(digits(date.timeZoneOffset.inHours % 24, 2));
          sb.write(digits(date.timeZoneOffset.inMinutes % 60, 2));
        }
      }
    } else if (format == Z) {
      sb.write(date.timeZoneName);
    } else {
      sb.write(format);
    }
  }

  return sb.toString();
}

String digits(int value, int length) {
  return '$value'.padLeft(length, "0");
}

int dayInYear(DateTime date) =>
    date.difference(new DateTime(date.year, 1, 1)).inDays;
