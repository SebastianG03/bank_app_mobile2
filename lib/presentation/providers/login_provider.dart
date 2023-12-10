import 'package:bank_mobile/config/helpers/user_answer.dart';
import 'package:bank_mobile/infrastructure/form_validations/forms_validations.dart';
import 'package:flutter/material.dart';

class LoginProvider extends ChangeNotifier {
  int user = 0;

  final EmailValidator emailValidator = EmailValidator();
  final PasswordValidator passwordValidator = PasswordValidator();

  Future<int> getUser(
      BuildContext context, String mail, String password) async {
    final response =
        await UserAnswer().getUserByIdAndPassword(context, mail, password);
    if (response == null) return 0;
    user = response;
    notifyListeners();
    return user;
  }
}
