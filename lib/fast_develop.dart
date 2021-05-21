library fast_develop;

import 'package:dio/dio.dart';
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
export 'widget/theme.dart';

export 'picker/flutter_datetime_picker.dart';

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

class FConfig {
  factory FConfig() => _getInstance();
  static FConfig ins = _getInstance();
  static FConfig? _instance;

  static FConfig _getInstance() {
    if (_instance == null) {
      _instance = FConfig.init();
    }

    return _instance!;
  }

  BuildContext? context;
  num pageHeight;
  num pageWidth;

  num listSpace;

  /// 根布局 左右间隔
  num rootLR;
  num rootTB;

  num space;
  num padding;
  num mainPadding;
  num crossPadding;

  num textOne;
  num textTwo;
  num textThree;
  num textFour;

  /// lv Five
  num textFive;

  num radius;
  num radiusOfCircle;

  double titleActionOfIconSize;
  double titleActionOfTxtSize;
  num titleActionOfIconPadding;
  num titleActionOfLeftRSize;
  num titleActionOfTopBSize;

  num dialogViewOfConfirmHeight;
  num dialogViewOfTitleHeight;
  num dialogViewOfTitleSize;
  num dialogViewOfTextSize;
  num dialogViewOfHorizontal;
  num dialogViewOfVertical;
  num dialogViewOfLoadWidth;
  num dialogViewOfLoadTop;
  num dialogViewOfTop;
  num dialogViewOfMinHeight;

  num dialogListSelectOfPaddingChild;
  num dialogListSelectOfWirePadding;

  num imageBrowseOfChildHeight;
  num imageBrowseOfChildWidth;
  num imageBrowseOfHeight;
  num imageBrowseOfWitch;
  num imageBrowseOfOperatingTopPadding;
  num imageBrowseOfOperatingTop;
  num imageBrowseOfCloseSize;
  bool imageBrowseOfSquare;
  Color imageBrowseOfCloseColor;

  num singleLineOfMinHeight;
  num singleLineOfIconHeight;
  num singleLineOfNameLeftPadding;
  num singleLineOfNameRightPadding;
  num singleLineOfLeftRight;
  num singleLineOfTopBottom;
  num singleLineOfUrlSize;
  num singleLineOfRadius;
  bool singleLineOfIsPrimary;
  IconData singleLineOfRightIconData;
  TextStyle? singleLineOfNameTxtStyle;

  double touchWidgetOfPressedOpacity;
  double touchWidgetOfPadding;

  num iconTextOfSpacing;
  num iconTextOfIconBottom;

  num themeSelectedIconSize;
  num themeUnselectedIconSize;
  num themeSelectedLabelSize;
  num themeUnselectedLabelSize;
  num themeFontSize;

  num? listIntervalViewOfCacheExtent;
  num? gridIntervalViewOfCacheExtent;

  num buttonOfLeftR;
  num buttonOfTopB;
  num buttonOfSize;
  num buttonOfTextSize;
  num? buttonOfSizeH;
  num buttonOfPressedOpacity;

  num editTextOfIconRightSpace;
  num editTextOfSignLeftPadding;

  num myBodyOfPadding;
  num? myBodyOfSpace;

  num checkboxOfSize;
  num checkboxOfSpacing;
  num checkboxOfPadding;
  num checkboxOfBorderWidth;

  num cardExOfPaddingSize;
  num cardExOfMarginSize;

  num titleWidgetOfHeight;
  num titleWidgetOfActionSpacing;

  /// 默认 1920*1080
  FConfig.init({
    ToastShow? toast,
    SwitchThemeBrightness? switchTB,
    IconThemeGenerate? iconTheme,
    TextThemeGenerate? textTheme,
    ProcessingExtend? processingExtend,
    RespDataJson? respDataJson,
    bool screenEnable = true,
    BaseOptions? baseOptions,
    JsonDecodeCallback? parseJson,
    DioInit? dioInit,
    ApiInterceptorOnRequest? onRequest,
    bool extraSaveJson = true,
    this.context,
    this.pageWidth = 1080,
    this.pageHeight = 1920,
    this.rootLR = 26,
    this.rootTB = 26,
    this.padding = 20,
    this.listSpace = 26,
    this.themeFontSize = 22,
    this.buttonOfLeftR = 48,
    this.buttonOfTopB = 16,
    this.buttonOfSize = 72,
    this.buttonOfTextSize = 40,
    this.buttonOfSizeH,
    this.buttonOfPressedOpacity = 0.4,
    this.themeSelectedIconSize = 46,
    this.themeUnselectedIconSize = 46,
    this.themeSelectedLabelSize = 25,
    this.themeUnselectedLabelSize = 25,
    this.dialogViewOfConfirmHeight = 140,
    this.dialogViewOfTitleHeight = 96,
    this.dialogViewOfTitleSize = 60,
    this.dialogViewOfTextSize = 40,
    this.dialogViewOfHorizontal = 40,
    this.dialogViewOfVertical = 24,
    this.dialogViewOfLoadWidth = 500,
    this.dialogViewOfLoadTop = 96,
    this.dialogViewOfTop = 48,
    this.dialogViewOfMinHeight = 80,
    this.dialogListSelectOfPaddingChild = 56,
    this.dialogListSelectOfWirePadding = 160,
    this.imageBrowseOfChildHeight = 1028,
    this.imageBrowseOfChildWidth = 1028,
    this.imageBrowseOfHeight = 1920,
    this.imageBrowseOfWitch = 1080,
    this.imageBrowseOfOperatingTopPadding = 480,
    this.imageBrowseOfOperatingTop = 100,
    this.imageBrowseOfCloseSize = 90,
    this.imageBrowseOfSquare = true,
    this.imageBrowseOfCloseColor = const Color(0x22000000),
    this.titleActionOfIconSize = 72,
    this.titleActionOfTxtSize = 25,
    this.titleActionOfIconPadding = 20,
    this.titleActionOfTopBSize = 32,
    this.titleActionOfLeftRSize = 48,
    this.radius = 20,
    this.radiusOfCircle = 100,
    this.titleWidgetOfHeight = 144,
    this.titleWidgetOfActionSpacing = 32,
    this.singleLineOfMinHeight = 144,
    this.singleLineOfIconHeight = 90,
    this.singleLineOfNameLeftPadding = 20,
    this.singleLineOfNameRightPadding = 80,
    this.singleLineOfLeftRight = 32,
    this.singleLineOfTopBottom = 16,
    this.singleLineOfUrlSize = 200,
    this.singleLineOfRadius = 20,
    this.singleLineOfIsPrimary = false,
    this.singleLineOfRightIconData = Icons.chevron_right,
    this.singleLineOfNameTxtStyle,
    this.touchWidgetOfPressedOpacity = 0.4,
    this.touchWidgetOfPadding = 0.0,
    this.iconTextOfSpacing = 4,
    this.iconTextOfIconBottom = 8,
    this.myBodyOfPadding = 32,
    this.myBodyOfSpace,
    this.checkboxOfSize = 50,
    this.checkboxOfSpacing = 16,
    this.checkboxOfPadding = 8,
    this.checkboxOfBorderWidth = 2,
    this.cardExOfPaddingSize = 20,
    this.cardExOfMarginSize = 0,
    this.editTextOfIconRightSpace = 48,
    this.editTextOfSignLeftPadding = 20,
    this.space = 8,
    this.mainPadding = 32,
    this.crossPadding = 32,
    this.textOne = 40,
    this.textTwo = 35,
    this.textThree = 30,
    this.textFour = 25,
    this.textFive = 20,
    this.listIntervalViewOfCacheExtent,
    this.gridIntervalViewOfCacheExtent,
  }) {
    initFastDevelopOfRespData(processingExtend, respDataJson);
    initFastDevelopOfHttp(baseOptions, parseJson, dioInit);
    initFastDevelopOfApiInterceptor(onRequest, extraSaveJson);
    initFastDevelopOfData(toast);
    initFastDevelopOfRootLayout(switchTB);
    initFastDevelopOfTitle(iconTheme, textTheme);
    ScreenUtils.enable = screenEnable;
    _instance = this;
  }
}
