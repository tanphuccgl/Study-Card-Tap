import 'package:cardtap/src/features/home/cubit/home_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => HomeBloc(),
      child: BlocBuilder<HomeBloc, HomeState>(
        builder: (context, state) {
          return Scaffold(
              body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  "Card info",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 20),
                if (state.cardInfo != null)
                  Text(
                    state.cardInfo!.toJson().toString(),
                  ),
                const SizedBox(height: 50),
                const Divider(),
                const SizedBox(height: 50),
                const Text(
                  "NFC data",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 20),
                if (state.nfcData != null)
                  Text(
                    state.nfcData!.data.toString(),
                    style: const TextStyle(color: Colors.red),
                  )
              ],
            ),
          ));
        },
      ),
    );
  }
}
