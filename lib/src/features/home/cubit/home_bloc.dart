import 'dart:async';

import 'package:cardtap/src/network/domain.dart';
import 'package:cardtap/src/network/model/login/card_id_info.dart';
import 'package:cardtap/widgets/dialogs/toast_wrapper.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:nfc_manager/nfc_manager.dart';

part 'home_state.dart';

class HomeBloc extends Cubit<HomeState> {
  HomeBloc() : super(const HomeState()) {
    init();
  }

  Domain get _domain => GetIt.I<Domain>();
  late Timer timer;

  void init() {
    startNfcSession();
  }

  void reloadTime() {
    var countdown = state.countdown;
    timer = Timer.periodic(const Duration(seconds: 1), (Timer t) {
      countdown--;
      emit(state.copyWith(countdown: countdown));
      if (state.countdown == 0) {
        onResetData();
        t.cancel();
      }
    });
  }

  void startNfcSession() async {
    bool isAvailable = await NfcManager.instance.isAvailable();
    if (isAvailable == false) {
      XToast.show("Không hỗ trợ NFC");
      return;
    }

    NfcManager.instance.startSession(
      onDiscovered: (NfcTag tag) async {
        if (tag.data.containsKey('nfca') &&
            tag.data['nfca'].containsKey('identifier')) {
          _processNFCData(tag.data['nfca']['identifier']);
        } else if (tag.data.containsKey('mifareclassic') &&
            tag.data['mifareclassic'].containsKey('identifier')) {
          _processNFCData(tag.data['mifareclassic']['identifier']);
        } else if (tag.data.containsKey('ndefformatable') &&
            tag.data['ndefformatable'].containsKey('identifier')) {
          _processNFCData(tag.data['ndefformatable']['identifier']);
        } else {
          XToast.show("Thẻ NFC không có UID");
        }
        emit(state.copyWith(nfcData: tag));
      },
    );
  }

  Future<void> _processNFCData(List<int> uid) async {
    emit(state.copyWith(isLoadingDataNfc: true));
    final String cardId = _convertToDecimal(uid);
    await getCardIdInfo(cardId);
    NfcManager.instance.stopSession();
  }

  String _convertToDecimal(List<int> uid) {
    List<int> reversedUid = uid.reversed.toList();
    String hexString = reversedUid
        .map((value) => value.toRadixString(16).toUpperCase())
        .join('');
    int decimalValue = int.parse(hexString, radix: 16);
    String decimalString = decimalValue.toString().padLeft(10, '0');
    return decimalString;
  }

  Future<void> getCardIdInfo(String cardId) async {
    final value = await _domain.userRepository.getCardIdInfo(cardId);

    if (value.isSuccess) {
      _emitIfOpen(state.copyWith(
        cardInfo: value.data,
        isLoadingDataNfc: false,
      ));
      final phoneNumber = value.data?.data?.single.phoneNumber ?? "";
      reloadTime();
      _emitIfOpen(state.copyWith(isLoadingCallApi: true));

      await Future.delayed(
        const Duration(seconds: 4),
        () => callPhone(
          cardId: cardId,
          phoneNumber: phoneNumber,
        ),
      );
    } else {
      emit(state.copyWith(isLoadingDataNfc: false));
      XToast.error("Lấy dữ liệu thất bại");
      await Future.delayed(const Duration(seconds: 1));
      startNfcSession();
    }
  }

  Future<void> callPhone({
    required String phoneNumber,
    required String cardId,
  }) async {
    final value = await _domain.userRepository.callPhone(
      phoneNumber: phoneNumber,
      cardId: cardId,
    );

    if (value.isSuccess) {
      if (value.data!.contains("486")) {
        XToast.show("Điện thoại bận");
      } else if (value.data!.isEmpty) {}
    } else {
      XToast.error("Không kết nối được với điện thoại");
    }
    _emitIfOpen(state.copyWith(isLoadingCallApi: false));
  }

  void onResetData() {
    _emitIfOpen(const HomeState());
    startNfcSession();
    timer.cancel();
  }

  void _emitIfOpen(HomeState newState) {
    if (!isClosed) {
      emit(newState);
    }
  }

  @override
  Future<void> close() {
    timer.cancel();
    return super.close();
  }
}
