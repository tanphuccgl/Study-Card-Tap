import 'package:bot_toast/bot_toast.dart';

import 'package:cardtap/src/localization/localization_utils.dart';
import 'package:cardtap/src/router/app_router.dart';
import 'package:cardtap/src/router/coordinator.dart';
import 'package:cardtap/src/router/route_observer.dart';
import 'package:cardtap/src/router/router_name.dart';
import 'package:cardtap/src/theme/themes.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter/material.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final botToastBuilder = BotToastInit();

    return ScreenUtilInit(
      builder: (context, child) {
        return MaterialApp(
          navigatorKey: XCoordinator.navigatorKey,
          initialRoute: XRouterName.dashboard,
          onGenerateRoute: XAppRoute.onGenerateRoute,
          navigatorObservers: [XRouteObserver()],
          builder: (context, child) {
            child = botToastBuilder(context, child);

            return child;
          },
          onGenerateTitle: (BuildContext context) =>
              S.of(context).common_appTitle,
          theme: XTheme.light(),
          darkTheme: XTheme.dark(),
          themeMode: ThemeMode.light,
          locale: null,
          localizationsDelegates: [
            S.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          supportedLocales: const [Locale('en', '')],
          debugShowCheckedModeBanner: false,
        );
      },
      designSize: const Size(360, 844),
      useInheritedMediaQuery: true,
    );
  }
}
