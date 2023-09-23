import 'package:cardtap/src/network/model/common/result.dart';
import 'package:cardtap/src/network/model/login/card_id_info.dart';

abstract class UserRepository {
  Future<XResult<CardIDInfo>> getCardIdInfo(String cardId);
  Future<XResult<String>> callPhone({
    required String phoneNumber,
    required String cardId,
  });
}
