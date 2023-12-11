import 'package:bank_mobile/config/helpers/user_answer.dart';
import 'package:flutter/material.dart';

import '../../infrastructure/form_validations/forms_validations.dart';

class RegistrationProvider extends ChangeNotifier {
  int response = 0;

  final EmailValidator emailValidator = EmailValidator();
  final PasswordValidator passwordValidator = PasswordValidator();
  final PhoneValidator phoneValidator = PhoneValidator();
  final DniValidator dniValidator = DniValidator();
  final NameValidator nameValidator = NameValidator();

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
