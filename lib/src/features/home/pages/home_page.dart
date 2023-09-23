import 'package:cardtap/src/features/home/cubit/home_bloc.dart';
import 'package:cardtap/widgets/common/indicator.dart';
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
          if (state.cardInfo == null) {
            return const Center(child: Text("Quét thẻ NFC"));
          }
          final studentData = state.cardInfo!.data!.single;
          const gap10 = SizedBox(height: 10);
          return Scaffold(
              appBar: AppBar(
                automaticallyImplyLeading: false,
                title: const Text('Student Information'),
              ),
              body: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        const Text(
                          'Student Information',
                          style: TextStyle(
                              fontSize: 24, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 20),
                        Text('Student ID: ${studentData.studentID}'),
                        gap10,
                        Text('Titkul Code: ${studentData.titkulCode}'),
                        gap10,
                        Text('Card ID: ${studentData.cardID}'),
                        gap10,
                        Text('Tên: ${studentData.fullName}'),
                        gap10,
                        Text('Số điện thoại: ${studentData.phoneNumber}'),
                        gap10,
                        Text('Lớp: ${studentData.className}'),
                        const SizedBox(height: 20),
                        if (state.isLoadingCallApi)
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: const [
                              XIndicator(),
                              SizedBox(width: 10),
                              Text('Đang kết nối với số điện thoại ...'),
                            ],
                          ),
                        if (state.isLoadingCallApi) const SizedBox(height: 20),
                        ElevatedButton(
                            onPressed: () =>
                                context.read<HomeBloc>().onResetData(),
                            child: const Text("Quét thẻ NFC mới")),
                        const SizedBox(height: 20),
                        Text('Làm mới trong: ${state.countdown}'),
                        const SizedBox(height: 20),
                        const Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                                'Lưu ý: Sau 30 giây thông tin thẻ sẽ tự động biến mất')),
                      ],
                    ),
                  )));
        },
      ),
    );
  }
}
