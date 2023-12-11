import 'package:bank_mobile/infrastructure/models/bank_account_model.dart';
import 'package:bank_mobile/presentation/widgets/shared/pop_up/pop_up_general.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class BankAccountAnswer {
  static const String url =
      "https://apibankservice20231127083449.azurewebsites.net/";
  final _dio = Dio();

  Future<BankAccountModel> getAccountByUserId(int id) async {
    final String apiUrl = '$url/api/BankAccount/user/$id';
    final Response response = await _dio.get(apiUrl);
    final BankAccountModel accountModel =
        BankAccountModel.fromJson(response.data);

    return accountModel;
  }

  Future<dynamic> putTransferAccount(
      BuildContext context, int idSender, int idReceive, double amount) async {
    final String apiUrl = '$url/api/BankAccount/$idSender/$idReceive/$amount/';

    try {
      final Response response = await _dio.put(apiUrl);

      final BankAccountModel accountModel =
          BankAccountModel.fromJson(response.data);
      PopUpGeneral.showMessage(context, 'Transferencia realizada');
      return response.data;
    } catch (e) {
      PopUpGeneral.showMessage(context, 'Error al obtener la cuenta');
      return null;
    }
  }

  Future<int> createBankAccount(int idUser) async {
    const String apiUrl = '$url/api/BankAccount';

    final Response response = await _dio.post(
      apiUrl,
      data: {
        "idAccount": 0,
        "idUser": idUser,
        "accountNumber": 0, //10000 + idUser,
        "accountAmount": 0
      },
    );

    return response.data;
  }
}
