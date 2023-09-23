import 'package:cardtap/src/features/common/pages/not_found_page.dart';
import 'package:cardtap/src/features/home/pages/home_page.dart';
import 'package:cardtap/src/router/base_coordinator.dart';
import 'package:flutter/material.dart';

class XHomeRouterName {
  static const String home = '/home';
}

class HomeCoordinator extends BaseCoordinator {
  @override
  String get initialRoute => XHomeRouterName.home;

  @override
  Route<dynamic>? onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case XHomeRouterName.home:
        return MaterialPageRoute(builder: (_) => const HomePage());

      default:
        return MaterialPageRoute(builder: (_) => const NotFoundPage());
    }
  }
}
