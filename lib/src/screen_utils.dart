import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

const double width = 1080;
const double height = 1920;

/// 是否不匹配高度
bool pixelMatching = true;

/// TODO 宽高比的问题，用来处理平板，未开发完
void setPixelMatching(bool isPixelMatching) {
  pixelMatching = isPixelMatching ??
      ScreenUtil.screenHeight / ScreenUtil.screenWidth >= 1.5;
//  LogUtil.printLog("-----------" + pixelMatching.toString());
}

extension ScreenUtils on num {
  static get max => double.infinity;

  /// 是否启用屏幕适配
  static bool enable = true;

  num get s => _width(this);
  num get sh => _height(this);
  num get ssp => _fontSize(this, null);
  num get sspA => _fontSize(this, true);

  static double get statusBarH => ScreenUtil.statusBarHeight;
  static double get height => ScreenUtil.screenHeight;
  static double get heightPx => ScreenUtil.screenHeightPx;

  static Offset widgetOffset(BuildContext context) {
    assert(context != null);
    RenderBox h = context.findRenderObject();
    return h.localToGlobal(Offset.zero);
  }

  static num _width(num num) {
    if (num == null) return null;
    if (enable)
      try {
        return ScreenUtil().setWidth(num);
      } catch (e) {
        return num;
      }
    else
      return num;
  }

  static num _height(num num) {
    if (num == null) return null;
    if (enable)
      try {
        return pixelMatching
            ? ScreenUtil().setWidth(num)
            : ScreenUtil().setHeight(num);
      } catch (e) {
        return num;
      }
    else
      return num;
  }

  static num _fontSize(num num, bool allowFontScalingSelf) {
    if (num == null) return null;
    if (enable)
      try {
        return ScreenUtil()
            .setSp(num, allowFontScalingSelf: allowFontScalingSelf);
      } catch (e) {
        return num;
      }
    else
      return num;
  }
}
