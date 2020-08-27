///
/// 销毁资源
///
class DisposeUtil {
  static dispose(object) {
    if (object != null) {
      object.dispose();
      object = null;
    }
  }
}
