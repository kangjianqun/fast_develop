import 'package:flutter/widgets.dart';

typedef ToastShow = Function(String hint);

///  toast
ToastShow _showToast;

initFastDevelopOfData(ToastShow toastShow) {
  _showToast = toastShow;
}

void showToast(String hint) {
  if (_showToast != null) _showToast(hint);
}

class LogUtil {
  static const String _TAG = "projectDebugLog";
  static const bool _DEBUG_PRINT = true;

  static void printLog(Object msg) {
    var content = "$_TAG: ";

    content += msg.toString();

    if (_DEBUG_PRINT) {
      debugPrint(content);
    } else {
      print(content);
    }
  }
}
