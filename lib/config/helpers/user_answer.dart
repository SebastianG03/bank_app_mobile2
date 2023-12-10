// ignore_for_file: use_build_context_synchronously

import 'package:bank_mobile/config/helpers/bank_account_answer.dart';
import 'package:bank_mobile/infrastructure/models/user_model.dart';
import 'package:bank_mobile/presentation/shared/pop_up/pop_up_general.dart';
import 'package:dio/dio.dart';
import 'package:flutter/widgets.dart';

class UserAnswer {
  static const String url =
      "https://apibankservice20231127083449.azurewebsites.net/";
  final _dio = Dio();

  Future<dynamic> getUserByIdAndPassword(
      BuildContext context, String mail, String password) async {
    final String apiUrl = '$url/api/User/$mail/$password';

    try {
      final Response response = await _dio.get(apiUrl);

      final userModel = UserModel.fromJson(response.data);

      return userModel.idUser;
    } catch (e) {
      PopUpGeneral.showMessage(context, 'Error al obtener el usuario');
      return null;
    }
  }

  Future<dynamic> createUser(String name, String mail, String password,
      String phone, String dni) async {
    const String apiUrl = '$url/api/User';

    final Response response = await _dio.post(
      apiUrl,
      data: {
        "name": name,
        "email": mail,
        "password": password,
        "phone": phone,
        "role": "client",
        "dni": dni,
      },
    );
    await BankAccountAnswer().createBankAccount(response.data);

    return response.data;
  }
}
