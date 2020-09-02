library fast_develop;

import 'package:flutter/material.dart';
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

class FastDevelopConfig {
  factory FastDevelopConfig() => _getInstance();
  static FastDevelopConfig instance = _getInstance();
  static FastDevelopConfig _instance;
  static FastDevelopConfig _getInstance() {
    if (_instance == null) {
      _instance = FastDevelopConfig.init();
    }
    return _instance;
  }

  BuildContext context;

  num singleLineOfMinHeight;
  num singleLineOfIconHeight;
  num singleLineOfNameLeftPadding;
  num singleLineOfNameRightPadding;
  bool singleLineOfIsPrimary;
  IconData singleLineOfRightIconData;

  double touchWidgetOfPressedOpacity;
  double touchWidgetOfPadding;

  num iconTextOfSpacing;
  num iconTextOfIconBottom;

  num myBodyOfPadding;

  num checkboxOfSize;
  num checkboxOfSpacing;
  num checkboxOfPadding;

  num cardExOfPaddingSize;
  num cardExOfMarginSize;

  num titleWidgetOfHeight;
  num titleWidgetOfActionSpacing;

  /// 默认 1920*1080
  FastDevelopConfig.init({
    this.context,
    ToastShow toast,
    SwitchThemeBrightness switchTB,
    IconThemeGenerate iconTheme,
    TextThemeGenerate textTheme,
    this.titleWidgetOfHeight = 144,
    this.titleWidgetOfActionSpacing = 32,
    this.singleLineOfMinHeight = 144,
    this.singleLineOfIconHeight = 90,
    this.singleLineOfNameLeftPadding = 20,
    this.singleLineOfNameRightPadding = 80,
    this.singleLineOfIsPrimary = false,
    this.singleLineOfRightIconData = Icons.chevron_right,
    this.touchWidgetOfPressedOpacity = 0.4,
    this.touchWidgetOfPadding = 0.0,
    this.iconTextOfSpacing = 4,
    this.iconTextOfIconBottom = 8,
    this.myBodyOfPadding = 32,
    this.checkboxOfSize = 50,
    this.checkboxOfSpacing = 16,
    this.checkboxOfPadding = 8,
    this.cardExOfPaddingSize = 20,
    this.cardExOfMarginSize = 0,
  }) {
    initFastDevelopOfData(toast);
    initFastDevelopOfRootLayout(switchTB);
    initFastDevelopOfTitle(iconTheme, textTheme);
    _instance = this;
  }
}
