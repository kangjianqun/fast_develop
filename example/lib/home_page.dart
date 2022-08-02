import 'dart:io';

import 'package:fast_develop/fast_develop.dart';
import 'package:fast_mvvm/fast_mvvm.dart';
import 'package:flutter/widgets.dart';

Http http = Http("http://34.96.139.218:8925",
    contentType: ContentType.parse('application/x-www-form-urlencoded').value);

class HomePageVM extends BaseViewModel {
  ValueNotifier<bool> vnCheck = ValueNotifier(false);

  modifyCheck(bool value) {
    vnCheck.value = value;
  }

  testNet() async {
    await requestHttp(
      RequestType.post,
      http,
      "/user/sms_code",
      p: {"_data": "asdasd"},
      isShowDialog: false,
      dialogAllClear: false,
      isShowError: true,
      disposeJson: false,
      notLogin: () {
        // UserVM.loginFailure();
        // if (notLoginIsPop) FastRouter.popBack();
        // UserRouter.login(home: true);
      },
      failure: (d) => printLog(d),
      succeed: (response) {
        printLog(response);
      },
    );
  }
}

class HomePage extends StatelessWidget with BaseView<HomePageVM> {
  const HomePage({Key? key}) : super(key: key);

  @override
  ViewConfig<HomePageVM> initConfig() => ViewConfig.noLoad(vm: HomePageVM());

  @override
  Widget vBuild(context, HomePageVM vm, Widget? child, Widget? state) {
    return MyScaffold.center(
      stateWidget: state,
      title: "菜单页",
      body: (_) => MyBody(children: [
        const SingleLine.normal(name: "测试的"),
        SingleLine.normal(
          name: "弹窗",
          onTap: (ctx) {
            showDialogCustom(
              context: ctx,
              builder: (_) => DialogView.confirm(
                content: "这是个弹窗",
                // onOk: (_) => showToast("关闭弹窗"),
                onOk: (_) {
                  vm.testNet();
                },
              ),
            );
          },
        ),
        SingleLine.normal(
          name: "选择",
          rightWidget: ValueListenableBuilder<bool>(
            valueListenable: vm.vnCheck,
            builder: (_, check, __) => Checkbox(
              value: check,
              onChanged: vm.modifyCheck,
            ),
          ),
        ),
        const EditText.text(name: "输入框"),
      ]),
    );
  }
}
