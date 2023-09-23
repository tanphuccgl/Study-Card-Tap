import 'dart:convert';

import 'package:cardtap/src/config/constants/endpoints.dart';
import 'package:cardtap/src/network/data_sources/base_data_source.dart';
import 'package:cardtap/src/network/model/common/result.dart';
import 'package:cardtap/src/network/model/login/card_id_info.dart';
import 'package:cardtap/src/network/repositories/user/user_repository.dart';
import 'package:cardtap/src/utils/helper/logger.dart';
import 'package:dio/dio.dart';

class UserRepositoryImpl extends UserRepository {
  @override
  Future<XResult<CardIDInfo>> getCardIdInfo(String cardId) async {
    try {
      final response = await BaseDataSource().get(
        "${Endpoints.getCardId}?CardID=$cardId",
        options: Options(headers: {
          "Content-Type": "application/json",
        }),
      );

      final result = CardIDInfo.fromJson(json.decode(response.data));

      return result.success == true
          ? XResult.success(result)
          : XResult.error("");
    } catch (e, a) {
      LoggerHelper.error('> GET getCardIdInfo CATCH Error< $e $a');

      return XResult.exception(e);
    }
  }

  @override
  Future<XResult<String>> callPhone({
    required String phoneNumber,
    required String cardId,
  }) async {
    try {
      const apiUser = "ZGVtb2FwaQ==";
      const apiSecret = "aGlnaHNjaG9vbGRlbW8yMDIz";
      const extension = "19006789";

      final response = await BaseDataSource().get(
        "${Endpoints.getCallApi}?ApiUser=$apiUser&ApiSecret=$apiSecret&pincode=$cardId&extension=$extension&callee=$phoneNumber",
        options: Options(headers: {
          "Content-Type": "application/json",
        }),
      );
      final String result = response.data.toString();

      return response.statusCode == 200 && result.contains("486") ||
              result.isEmpty
          ? XResult.success(result)
          : XResult.error("");
    } catch (e, a) {
      LoggerHelper.error('> GET callPhone CATCH Error< $e $a');

      return XResult.exception(e);
    }
  }
}
