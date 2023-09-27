import 'package:auto_start_flutter/auto_start_flutter.dart';

import 'package:bot_toast/bot_toast.dart';

import 'package:cardtap/src/localization/localization_utils.dart';
import 'package:cardtap/src/router/app_router.dart';
import 'package:cardtap/src/router/coordinator.dart';
import 'package:cardtap/src/router/route_observer.dart';
import 'package:cardtap/src/router/router_name.dart';
import 'package:cardtap/src/theme/themes.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter/material.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final GlobalKey<ScaffoldMessengerState> _messengerKey =
      GlobalKey<ScaffoldMessengerState>();

  @override
  void initState() {
    super.initState();
    //call in init state;
    initAutoStart();
  }

  //initializing the autoStart with the first build.
  Future<void> initAutoStart() async {
    try {
      //check auto-start availability.
      var test = await isAutoStartAvailable;

      //if available then navigate to auto-start setting page.
      if (test == true) await getAutoStartPermission();
    } on PlatformException catch (e) {
      debugPrint("initAutoStart: $e");
    }
    if (!mounted) return;
  }

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
