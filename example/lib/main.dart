import 'package:fast_develop/fast_develop.dart' hide showToast;
import 'package:flutter/material.dart';
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

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MyScaffold.center(
      title: "菜单页",
      body: (_) => MyBody(children: [
        SingleLine.normal(name: "测试的"),
      ]),
    );
  }
}
