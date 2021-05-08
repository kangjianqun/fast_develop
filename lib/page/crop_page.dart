import 'dart:io';
import 'dart:ui';

import 'package:fast_mvvm/fast_mvvm.dart';
import 'package:fast_router/fast_router.dart';
import 'package:crop/crop.dart';
import 'package:flutter/widgets.dart';
import '../fast_develop.dart';

class CropVM extends BaseViewModel {
  final controller = CropController();

  crop() async {
    var img = await controller.crop();
    var byteData = await img.toByteData(format: ImageByteFormat.png);
    FastRouter.popBack(result: byteData);
  }
}

/// 裁剪页面
class CropPage extends StatelessWidget with BaseView<CropVM> {
  CropPage({Key? key, required this.filePath}) : super(key: key);

  final String filePath;

  @override
  ViewConfig<CropVM> initConfig() => ViewConfig.noLoad(vm: CropVM());

  @override
  Widget vmBuild(context, CropVM vm, Widget? child, Widget? state) {
    return MyScaffold.center(
      title: "裁剪",
      nextWidget: (_) => TitleAction.stress(
        onTap: (_) => vm.crop(),
        txt: "裁剪",
      ),
      body: (_) => Crop(
        child: Image.file(File(filePath)),
        controller: vm.controller,
        // shape: CropShape.oval,
        shape: BoxShape.circle,
      ),
    );
  }
}
