import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:fast_router/fast_router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swiper_null_safety/flutter_swiper_null_safety.dart';
import 'package:image_picker/image_picker.dart';
import '../fast_develop.dart';

class ImgHelp {
  String? key;
  String url;
  String? thumbnail;
  late ValueNotifier<String?> vnUrl;

  /// 优先缩略图 然后 原图
  String img() => thumbnail ?? url;

  ImgHelp(this.url, {this.key, this.thumbnail}) {
    vnUrl = ValueNotifier(url);
  }
}

void dialogImageSelect(BuildContext ctx, ValueNotifier<File?> photo,
    {void Function()? next, num size = 40}) {
  showDialogCustom(
    context: ctx,
    location: Location.bottom,
    offsetHandle: fromBottom,
    style: StyleText.normal(size: size),
    builder: (_) => DialogListSelect(
      children: [
        NameFunction("从相册选择", () async {
          var file = await ImagePicker().getImage(source: ImageSource.gallery);
          if (file != null) photo.value = File(file.path);
          if (next != null) next();
        }),
        NameFunction("拍摄", () async {
          var file = await ImagePicker().getImage(source: ImageSource.camera);
          if (file != null) photo.value = File(file.path);
          if (next != null) next();
        }),
      ],
    ),
  );
}

/// 图片选择
class PhotoSelect extends StatelessWidget {
  const PhotoSelect(
    this.photo, {
    Key? key,
    this.imgHelp,
    this.color,
    this.brightness,
  })  : isUrl = imgHelp != null,
        super(key: key);

  final ValueNotifier<File> photo;

  final ImgHelp? imgHelp;
  final bool isUrl;
  final Color? color;
  final Brightness? brightness;

  Widget _imgChild(File? file, String? url, Brightness brightness) {
    if ((imgHelp == null || url.e) && file == null) {
      return Icon(IConfig.add, color: CConfig.getMatching());
    } else {
      return isUrl
          ? WrapperImage.max(
              photo: photo,
              url: imgHelp!.img(),
              browseList: [imgHelp!.url],
              delete: () => imgHelp!.vnUrl.value = null)
          : Image.file(file!, fit: BoxFit.fill);
    }
  }

  Widget _child(Brightness brightness) {
    return ValueListenableBuilder<File>(
      valueListenable: photo,
      builder: (_, file, __) {
        if (isUrl) {
          return ValueListenableBuilder<String?>(
            valueListenable: imgHelp!.vnUrl,
            builder: (_, url, __) {
              return _imgChild(file, url, brightness);
            },
          );
        } else {
          return _imgChild(
            file,
            imgHelp == null ? null : imgHelp!.img(),
            brightness,
          );
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    var _brightness = brightness ?? Theme.of(context).brightness;

    return TouchWidget(
      // onTap: isUrl == null ? null : (_) => dialogImageSelect(context, photo),
      onTap: (_) => dialogImageSelect(context, photo),
      child: Container(
        width: 177.ww,
        height: 177.ww,
        decoration: DecoUtil.border(
            color: color ?? CConfig.getBackground(),
            borderColor: CConfig.getMatching()),
        child: ClipRRect(
          borderRadius: SBorderRadius.normal(),
          child: _child(_brightness),
        ),
      ),
    );
  }
}

/// 图片显示
class WrapperImage extends StatelessWidget {
  WrapperImage({
    Key? key,
    required this.width,
    required this.height,
    required this.url,
    this.fit: BoxFit.contain,
    this.hold = false,
    this.circle = false,
    this.fillet = false,
    this.square = false,
    this.radius = 0,
    this.browseList,
    this.photo,
    this.delete,
    this.placeholderWidgetBuilder,
    this.loadingErrorWidgetBuilder,
  }) : super(key: key);

  /// 图片的大小
  WrapperImage.max({
    Key? key,
    this.width,
    this.height,
    required this.url,
    this.fit: BoxFit.fill,
    this.hold = false,
    this.circle = false,
    this.fillet = false,
    this.square = false,
    this.radius = 0,
    this.browseList,
    this.photo,
    this.delete,
    this.placeholderWidgetBuilder,
    this.loadingErrorWidgetBuilder,
  }) : super(key: key);

  WrapperImage.size({
    Key? key,
    required this.url,
    required num size,
    this.fit: BoxFit.contain,
    this.hold = false,
    this.circle = false,
    this.fillet = false,
    this.square = true,
    this.radius = 0,
    this.browseList,
    this.photo,
    this.delete,
    this.placeholderWidgetBuilder,
    this.loadingErrorWidgetBuilder,
  })  : this.width = size.toDouble(),
        this.height = size.toDouble(),
        super(key: key);

  final String url;
  final double? width;
  final double? height;
  final BoxFit fit;
  final bool hold;

  /// 图片浏览
  final List<String>? browseList;

  /// 圆
  final bool circle;

  /// 圆角
  final bool fillet;

  /// 方形
  final bool square;
  final num radius;
  final ValueNotifier<File>? photo;
  final void Function()? delete;
  final PlaceholderWidgetBuilder? placeholderWidgetBuilder;
  final LoadingErrorWidgetBuilder? loadingErrorWidgetBuilder;

  @override
  Widget build(BuildContext context) {
    Widget widget = Spacing.vView();

    /// 图片空 不显示
    if (url.en || hold)
      widget = Container(
        width: width.ww,
        height: square ? height.rr : height.hh,
        child: CachedNetworkImage(
          imageUrl: url,
          fit: fit,
          placeholder: (_, __) => Spacing.placeHolder(width: 18, height: 18),
          errorWidget: (_, __, ___) => Spacing.error(width: 18, height: 18),
        ),
      );

    if (circle || fillet || radius > 0) {
      var _radius = fillet ? FConfig.ins.radius : radius;

      widget = ClipRRect(
        borderRadius: circle
            ? SBorderRadius.circle()
            : SBorderRadius.normal(radius: _radius),
        child: widget,
      );
    }

    if (browseList.en)
      widget = TouchWidget(
        onTap: (ctx) {
          showDialogCustom(
            context: ctx,
            builder: (context) => DialogView(
              child: ImageBrowse(
                  images: browseList!, photo: photo, delete: delete),
            ),
          );
        },
        child: widget,
      );
    return widget;
  }
}

/// 图片浏览
class ImageBrowse extends StatelessWidget {
  const ImageBrowse({
    Key? key,
    required this.images,
    this.photo,
    this.delete,
    this.square = true,
    this.childHeight = 1028,
    this.childWidth = 1028,
    this.height = 1920,
    this.width = 1080,
    this.operatingTopPhoto = 480,
    this.operatingTop = 100,
    this.closeSize = 90,
    this.closeColor = const Color(0x22000000),
  }) : super(key: key);

  /// 方形
  final bool square;
  final num childHeight;
  final num childWidth;
  final num height;
  final num width;
  final num operatingTopPhoto;
  final num operatingTop;
  final num closeSize;
  final Color closeColor;
  final List<String> images;
  final ValueNotifier<File>? photo;
  final void Function()? delete;

  /// 操作
  List<Widget> _operating() {
    if (photo != null) {
      return [
        Spacing.spacingView(height: operatingTopPhoto),
        Align(
          alignment: Alignment.centerRight,
          child: Button.img(
            icon: IConfig.list,
            color: CConfig.whiteGrey,
            margin: Spacing.rootLR(),
            size: 120,
            paddingChild: 32,
            onTap: (ctx) => dialogImageModify(ctx, photo!, next: () {
              FastRouter.popBackDialog(ctx);
              if (delete != null) delete!();
            }),
          ),
        )
      ];
    } else {
      return [
        Spacing.spacePadding(size: operatingTop),
        TouchWidget(
          onTap: (ctx) => FastRouter.popBackDialog(ctx),
          child: ClipRRect(
            borderRadius: SBorderRadius.circle(),
            child: Container(
              color: closeColor,
              padding: Spacing.all(size: 10),
              child: Icon(IConfig.close, size: closeSize.ssp),
            ),
          ),
        ),
      ];
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: square ? width.rr : width.ww,
      height: square ? height.rr : height.hh,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Container(
            height: square ? childHeight.rr : childHeight.hh,
            child: Swiper(
              itemCount: images.length,
              loop: false,
              containerWidth: square ? childWidth.rr : childWidth.ww,
              containerHeight: square ? childHeight.rr : childHeight.hh,
              pagination: SwiperPagination(),
              itemBuilder: (_, index) => WrapperImage.max(url: images[index]),
            ),
          ),
          ..._operating(),
        ],
      ),
    );
  }

  static void dialogImageModify(BuildContext ctx, ValueNotifier<File?> photo,
      {void Function()? next, num size = 40}) {
    showDialogCustom(
      context: ctx,
      location: Location.bottom,
      offsetHandle: fromBottom,
      style: StyleText.normal(size: size),
      builder: (_) => SafeArea(
        bottom: true,
        child: DialogListSelect(
          children: [
            NameFunction("删除", () async {
              photo.value = null;
              if (next != null) next();
            }),
            NameFunction("替换", () async {
              dialogImageSelect(ctx, photo);
            }),
          ],
        ),
      ),
    );
  }
}
