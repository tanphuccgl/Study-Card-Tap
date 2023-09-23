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

  void init() {
    startNfcSession();
  }

  void startNfcSession() async {
    bool isAvailable = await NfcManager.instance.isAvailable();
    if (isAvailable == false) {
      XToast.show("Không hỗ trợ NFC");
    }

    NfcManager.instance.startSession(
      onDiscovered: (NfcTag tag) async {
        if (tag.data.containsKey('nfca') &&
            tag.data['nfca'].containsKey('identifier')) {
          processNFCData(tag.data['nfca']['identifier']);
        } else if (tag.data.containsKey('mifareclassic') &&
            tag.data['mifareclassic'].containsKey('identifier')) {
          processNFCData(tag.data['mifareclassic']['identifier']);
        } else if (tag.data.containsKey('ndefformatable') &&
            tag.data['ndefformatable'].containsKey('identifier')) {
          processNFCData(tag.data['ndefformatable']['identifier']);
        } else {
          XToast.show("Thẻ NFC không có UID");
        }
        emit(state.copyWith(nfcData: tag));
      },
    );

    // NfcManager.instance.stopSession();
  }

  void processNFCData(List<int> uid) {
    final String cardId = convertToDecimal(uid);
    getCardIdInfo(cardId);
  }

  String convertToDecimal(List<int> uid) {
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
      _emitIfOpen(state.copyWith(cardInfo: value.data));
      final phoneNumber = value.data?.data?.single.phoneNumber ?? "";
      XToast.show(phoneNumber);

      await Future.delayed(
        const Duration(seconds: 4),
        () => callPhone(
          cardId: cardId,
          phoneNumber: phoneNumber,
        ),
      );
    } else {
      XToast.error("Lấy dữ liệu thất bại");
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
      XToast.error("Error");
    }
  }

  // Future<void> _makePhoneCall(String phoneNumber) async {
  //   final Uri launchUri = Uri(
  //     scheme: 'tel',
  //     path: phoneNumber,
  //   );
  //   await launchUrl(launchUri);
  // }

  void _emitIfOpen(HomeState newState) {
    if (!isClosed) {
      emit(newState);
    }
  }
}
