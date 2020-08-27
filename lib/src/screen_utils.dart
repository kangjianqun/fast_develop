import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

const double width = 1080;
const double height = 1920;

bool pixelMatching = true;

void setPixelMatching() {
  pixelMatching = ScreenUtil.screenHeight / ScreenUtil.screenWidth >= 1.5;
//  LogUtil.printLog("-----------" + pixelMatching.toString());
}

extension ScreenUtils on num {
  static get max => double.infinity;

  num get s => ScreenUtil().setWidth(this);
  num get sh => pixelMatching
      ? ScreenUtil().setWidth(this)
      : ScreenUtil().setHeight(this);
  num get ssp => ScreenUtil().setSp(this);
  num get sspA => ScreenUtil().setSp(this, allowFontScalingSelf: true);

  static double get statusBarH => ScreenUtil.statusBarHeight;
  static double get height => ScreenUtil.screenHeight;
  static double get heightPx => ScreenUtil.screenHeightPx;

  static Offset widgetOffset(BuildContext context) {
    assert(context != null);
    RenderBox h = context.findRenderObject();
    return h.localToGlobal(Offset.zero);
  }
}
