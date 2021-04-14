import 'package:flutter/widgets.dart';
import 'package:fast_develop/fast_develop.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

const double width = 1080;
const double height = 1920;

/// 是否不匹配高度
bool pixelMatching = true;

/// TODO 宽高比的问题，用来处理平板，未开发完
void setPixelMatching(bool? isPixelMatching) {
  pixelMatching = isPixelMatching ??
      ScreenUtil().screenHeight / ScreenUtil().screenWidth >= 1.5;
//  LogUtil.printLog("-----------" + pixelMatching.toString());
}

extension ScreenUtils on num? {
  static get max => double.infinity;

  /// 是否启用屏幕适配
  static bool enable = true;

  double? get ww => _width(this);

  double? get hh => _height(this);

  double? get rr => _rr(this);

  double? get ssp => _fontSize(this, null);

  double? get sspA => _fontSize(this, true);

  static double get statusBarH => ScreenUtil().statusBarHeight;

  static double get height => ScreenUtil().screenHeight;

  static Offset? widgetOffset(BuildContext context) {
    RenderObject? h = context.findRenderObject();
    if (h is RenderBox) {
      return h.localToGlobal(Offset.zero);
    } else
      return null;
  }

  static double? _width(num? num) {
    if (num == null) return null;
    num = valueByType(num, double);
    if (enable)
      try {
        return ScreenUtil().setWidth(num!);
      } catch (e) {
        return num!.toDouble();
      }
    else
      return num!.toDouble();
  }

  static double? _rr(num? num) {
    if (num == null) return null;
    num = valueByType(num, double);
    if (enable)
      try {
        return pixelMatching
            ? ScreenUtil().radius(num!)
            : ScreenUtil().radius(num!);
      } catch (e) {
        return num!.toDouble();
      }
    else
      return num!.toDouble();
  }

  static double? _height(num? num) {
    if (num == null) return null;
    num = valueByType(num, double);
    if (enable)
      try {
        return pixelMatching
            ? ScreenUtil().setWidth(num!)
            : ScreenUtil().setHeight(num!);
      } catch (e) {
        return num!.toDouble();
      }
    else
      return num!.toDouble();
  }

  static double? _fontSize(num? num, bool? allowFontScalingSelf) {
    if (num == null) return null;
    num = valueByType(num, double);
    if (enable)
      try {
        return ScreenUtil().setSp(num!);
      } catch (e) {
        return num!.toDouble();
      }
    else
      return num!.toDouble();
  }
}
