library fast_develop;

import 'package:flutter/widgets.dart';
import 'package:fast_develop/fast_develop.dart';

export 'page/crop_page.dart';

export 'widget/banner_image.dart';
export 'widget/checkbox.dart';
export 'widget/count_down.dart';
export 'widget/dialog.dart';
export 'widget/image.dart';
export 'widget/refresh.dart';
export 'widget/root_layout.dart';
export 'widget/touch.dart';
export 'widget/title.dart';
export 'widget/basic.dart';
export 'widget/select.dart';
export 'src/status_bar.dart';
export 'widget/edit_text.dart';
export 'widget/rating_bar.dart';
export 'widget/level_linkage.dart';
export 'widget/refresh.dart';
export 'widget/primary_scroll_container.dart';
export 'widget/text.dart';
export 'widget/unread_hint.dart';

export 'picker/flutter_datetime_picker.dart';
export 'scrollable_positioned/scrollable_positioned_list.dart';

export 'src/convert/data.dart';
export 'src/convert/date_time_util.dart';

export 'src/platform_utils.dart';
export 'src/screen_utils.dart';
export 'src/storage_manager.dart';
export 'src/style_manager.dart';
export 'src/spacing.dart';
export 'src/net/interceptor.dart';
export 'src/net/http.dart';
export 'src/log.dart';
export 'src/oss_util.dart';
export 'src/dispose_util.dart';
export 'src/thread_utils.dart';
export 'src/common_utils.dart';
export 'src/launch_util.dart';
export 'src/data_encryption.dart';

export 'src/decoration.dart';
export 'src/globalValue.dart';
export 'src/types.dart';

/// 默认 1920*1080
void initFastDevelopConfig({
  BuildContext context,
  ToastShow toast,
  SwitchThemeBrightness switchTB,
  IconThemeGenerate iconTheme,
  TextThemeGenerate textTheme,
  num singleLineOfMinHeight = 144,
  num singleLineOfIconHeight = 90,
  num singleLineOfNameLeftPadding = 20,
  num singleLineOfNameRightPadding = 80,
  double touchWidgetOfPressedOpacity = 0.4,
  bool singleLineOfIsPrimary = false,
  num iconTextOfSpacing = 4,
  num iconTextOfIconBottom = 8,
  double touchWidgetOfPadding = 0.0,
  num myBodyOfPadding = 32,
  num checkboxOfSize = 50,
  num checkboxOfSpacing = 16,
  num checkboxOfPadding = 8,
  num cardExOfPaddingSize = 20,
  num cardExOfMarginSize = 0,
}) {
  FastDevelopConfig.context = context;

  FastDevelopConfig.singleLineOfMinHeight = singleLineOfMinHeight;
  FastDevelopConfig.singleLineOfIconHeight = singleLineOfIconHeight;
  FastDevelopConfig.singleLineOfNameLeftPadding = singleLineOfNameLeftPadding;
  FastDevelopConfig.singleLineOfNameRightPadding = singleLineOfNameRightPadding;
  FastDevelopConfig.singleLineOfIsPrimary = singleLineOfIsPrimary;

  FastDevelopConfig.iconTextOfSpacing = iconTextOfSpacing;
  FastDevelopConfig.iconTextOfIconBottom = iconTextOfIconBottom;

  FastDevelopConfig.touchWidgetOfPressedOpacity = touchWidgetOfPressedOpacity;
  FastDevelopConfig.touchWidgetOfPadding = touchWidgetOfPadding;

  FastDevelopConfig.myBodyOfPadding = myBodyOfPadding;

  FastDevelopConfig.checkboxOfSize = checkboxOfSize;
  FastDevelopConfig.checkboxOfSpacing = checkboxOfSpacing;
  FastDevelopConfig.checkboxOfPadding = checkboxOfPadding;

  FastDevelopConfig.cardExOfPaddingSize = cardExOfPaddingSize;
  FastDevelopConfig.cardExOfMarginSize = cardExOfMarginSize;
  initFastDevelopOfData(toast);
  initFastDevelopOfRootLayout(switchTB);
  initFastDevelopOfTitle(iconTheme, textTheme);
}

class FastDevelopConfig {
  static BuildContext context;

  static num singleLineOfMinHeight;
  static num singleLineOfIconHeight;
  static num singleLineOfNameLeftPadding;
  static num singleLineOfNameRightPadding;
  static bool singleLineOfIsPrimary;

  static double touchWidgetOfPressedOpacity;
  static double touchWidgetOfPadding;

  static num iconTextOfSpacing;
  static num iconTextOfIconBottom;

  static num myBodyOfPadding;

  static num checkboxOfSize;
  static num checkboxOfSpacing;
  static num checkboxOfPadding;

  static num cardExOfPaddingSize;
  static num cardExOfMarginSize;
}
