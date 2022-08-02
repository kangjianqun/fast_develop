import 'package:fast_develop/widget/theme.dart';
import 'package:fast_router/fast_router.dart';
import 'package:flutter/material.dart' hide Checkbox;
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:oktoast/oktoast.dart';
import 'package:provider/provider.dart';

import 'config.dart';
import 'home_page.dart';

main() => runApp(MyApp(future: initConfig()));

class MyApp extends StatelessWidget {
  final Future future;
  MyApp({Key? key, required this.future}) : super(key: key) {
    FastRouter.configureRouters(FastRouter(), []);
  }

  @override
  Widget build(BuildContext context) => FutureBuilder(
        future: future,
        builder: (ctx, state) {
          if (state.connectionState != ConnectionState.done) {
            return const MaterialApp(
                debugShowCheckedModeBanner: false, home: InitPage());
          }
          return OKToast(
            child: ScreenUtilInit(
              designSize: const Size(1080, 1920),
              builder: (_, __) => MultiProvider(
                providers: providers,
                child: Consumer<ThemeVM>(
                  builder: (_, themeVM, __) => MaterialApp(
                    debugShowCheckedModeBanner: false,
                    title: 'Develop Demo',
                    theme: themeVM.themeData,
                    onGenerateRoute: FastRouter.router.generator,
                    navigatorObservers: [FastRouter.observer],
                    home: const HomePage(),
                  ),
                ),
              ),
            ),
          );
        },
      );
}

/// 用于项目初始化之前显示的页面
class InitPage extends StatelessWidget {
  const InitPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    initConfig(context: context);
    /// 可以自己换配图
    return Container(color: Colors.black);
  }
}
