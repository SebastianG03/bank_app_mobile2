import 'package:bank_mobile/config/helpers/user_answer.dart';
import 'package:flutter/material.dart';

class RegistrationProvider extends ChangeNotifier {
  int response = 0;

  Future<dynamic> createUser({
    required String name,
    required String mail,
    required String password,
    required String phone,
    required String dni,
  }) async {
    await UserAnswer().createUser(name, mail, password, phone, dni);
  }
}
