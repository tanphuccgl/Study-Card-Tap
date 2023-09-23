import 'package:cardtap/src/features/home/router/home_router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeWrapperPage extends StatelessWidget {
  const HomeWrapperPage({super.key});

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider.value(
      value: (_) => context.read<HomeCoordinator>(),
      child: context.read<HomeCoordinator>().getNavigator(),
    );
  }
}
