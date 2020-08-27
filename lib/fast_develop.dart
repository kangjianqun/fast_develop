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
export 'src/data_encryption.dart';
export 'src/thread_utils.dart';
export 'src/common_utils.dart';

export 'src/decoration.dart';
export 'src/globalValue.dart';
export 'src/types.dart';

class FastDevelopConfig {
  static BuildContext context;

  void initFastDevelopConfig({
    BuildContext context,
    ToastShow toast,
    SwitchThemeBrightness switchTB,
    IconThemeGenerate iconTheme,
    TextThemeGenerate textTheme,
  }) {
    context = context;
    switchThemeBrightness = switchTB;
    showToast = toast;
    iconThemeGenerate = iconTheme;
    textThemeGenerate = textTheme;
  }
}
