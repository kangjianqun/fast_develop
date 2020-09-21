import 'package:fast_develop/fast_develop.dart';
import 'package:fast_mvvm/fast_mvvm.dart';
import 'package:flutter/widgets.dart';

class HomePageVM extends BaseViewModel {
  ValueNotifier<bool> vnCheck = ValueNotifier(false);

  modifyCheck(bool value) {
    vnCheck.value = value;
  }
}

class HomePage extends StatelessWidget with BaseView<HomePageVM> {
  @override
  ViewConfig<HomePageVM> initConfig(BuildContext context) =>
      ViewConfig.noLoad(vm: HomePageVM());

  @override
  Widget vmBuild(
      BuildContext context, HomePageVM vm, Widget child, Widget state) {
    return MyScaffold.center(
      title: "菜单页",
      body: (_) => MyBody(children: [
        SingleLine.normal(name: "测试的"),
        SingleLine.normal(
          name: "弹窗",
          onTap: (ctx) {
            showDialogCustom(
              context: ctx,
              builder: (_) => DialogView.confirm(
                content: "这是个弹窗",
                onOk: (_) => showToast("关闭弹窗"),
              ),
            );
          },
        ),
        SingleLine.normal(
          name: "选择",
          rightWidget: ValueListenableBuilder(
            valueListenable: vm.vnCheck,
            builder: (_, check, __) => Checkbox(
              value: check,
              onChanged: vm.modifyCheck,
            ),
          ),
        ),
        EditText.text(name: "输入框"),
      ]),
    );
  }
}
