import 'package:cardtap/src/network/domain.dart';
import 'package:cardtap/src/services/user_prefs.dart';
import 'package:cardtap/src/theme/themes.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

import 'features/common/app_cubit/bloc_observer.dart';

class ConfigApp {
  static Future<void> initializeApp() async {
    WidgetsFlutterBinding.ensureInitialized();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
    SystemChrome.setSystemUIOverlayStyle(XTheme.barOverLayStyle);
    _locator();
    await Future.wait([
      UserPrefs.instance.initialize(),
    ]);

    Bloc.observer = XBlocObserver();
  }

  static void _locator() {
    GetIt.I.registerLazySingleton(() => Domain());
  }
}
