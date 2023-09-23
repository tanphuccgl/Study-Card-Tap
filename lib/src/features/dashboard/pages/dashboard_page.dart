import 'package:cardtap/src/features/home/router/home_router.dart';
import 'package:cardtap/src/features/home/router/home_wrapper_router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DashboardPage extends StatelessWidget {
  const DashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider(
        create: (_) => HomeCoordinator(),
        child: WillPopScope(
          onWillPop: () async => false,
          child: const Scaffold(
            body: HomeWrapperPage(),
          ),
        ));
  }
}
