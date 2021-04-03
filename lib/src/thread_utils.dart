import 'dart:async';

/// 延迟 setState() or markNeedsBuild() called during build.
void delayed([FutureOr computation()?, int time = 100]) {
  Future.delayed(Duration(milliseconds: time), computation);
}
