import 'package:fast_develop/fast_develop.dart' hide showToast;
import 'package:fast_mvvm/fast_mvvm.dart';
import 'package:flutter/material.dart' hide Checkbox;
import 'package:oktoast/oktoast.dart';
import 'package:provider/provider.dart';

import 'config.dart';

main() => runApp(MyApp(future: initConfig()));

class MyApp extends StatelessWidget {
  final Future future;
  MyApp({this.future});

  @override
  Widget build(BuildContext context) => FutureBuilder(
      future: future,
      builder: (ctx, state) {
        if (state.connectionState != ConnectionState.done)
          return MaterialApp(
              debugShowCheckedModeBanner: false, home: InitPage());
        return OKToast(
          child: MultiProvider(
            providers: providers,
            child: Consumer<ThemeVM>(
              builder: (_, themeVM, __) => MaterialApp(
                debugShowCheckedModeBanner: false,
                title: 'Develop Demo',
                theme: themeVM.themeData,
                home: HomePage(),
              ),
            ),
          ),
        );
      });
}

/// 用于项目初始化之前显示的页面
class InitPage extends StatelessWidget {
  Widget build(BuildContext context) {
    initConfig(context: context);

    /// 可以自己换配图
    return Container(color: Colors.black);
  }
}

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
      body: (_) => MyBody(fullLine: false, children: [
        SingleLine.normal(name: "测试的"),
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
      ]),
    );
  }
}
