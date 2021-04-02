import 'package:flutter/widgets.dart';

import '../fast_develop.dart';

typedef ToastShow = Function(String? hint);

///  toast
ToastShow? _showToast;

initFastDevelopOfData(ToastShow? toastShow) {
  if (toastShow != null) _showToast = toastShow;
}

void showToast(String? hint) {
  if (_showToast != null && StringUtil.isNotEmpty(hint)) _showToast!(hint!);
}

class LogUtil {
  static const String _TAG = "projectDebugLog";
  static bool isDebugPrint = true;

  static void printLog(Object msg) {
    var content = "$_TAG: ";
    content += msg.toString();
    if (isDebugPrint)
      debugPrint(content);
    else
      print(content);
  }
}
