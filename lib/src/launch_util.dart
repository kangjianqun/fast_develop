import 'package:url_launcher/url_launcher.dart';

import '../fast_develop.dart';

class LaunchUtil {
  static void launchTel(String phone) async {
    showDialogCustom(
      context: FastDevelopConfig.context,
      builder: (_) => DialogView.confirm(
        content: "立即拨号：$phone",
        onOk: (_) => LaunchUtil.launchUrl("tel:$phone"),
      ),
    );
  }

  static Future<bool> launchUrl(String url) async {
    if (await canLaunch(url)) {
      return await launch(url);
    } else {
      return false;
    }
  }

  static Future<bool> launchQQ(String uid, {bool isGroup = false}) async {
    String url;
    if (isGroup) {
      url = "mqqapi://card/show_pslcard?src_type=internal&version=1&uin=$uid"
          "&card_type=group&source=qrcode";
    } else {
      url = "mqqwpa://im/chat?chat_type=wpa&uin=$uid"
          "&version=1&src_type=web&web_src=oicqzone.com";
    }
    return launchUrl(url);
  }
}
