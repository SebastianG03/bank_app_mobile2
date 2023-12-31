import 'package:bank_mobile/config/theme/theme.dart';
import 'package:bank_mobile/presentation/providers/login_provider.dart';
import 'package:bank_mobile/presentation/screens/screens.dart';
import 'package:bank_mobile/presentation/widgets/shared/pop_up/pop_up_general.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../widgets/inputs/inputs.dart';

class LoginBody extends StatefulWidget {
  const LoginBody({Key? key}) : super(key: key);

  @override
  State<LoginBody> createState() => _LoginBodyState();
}

class _LoginBodyState extends State<LoginBody> {
  bool _obscureTextPassword = true;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  int storedUserId = 0;

  @override
  void initState() {
    super.initState();
    loadUserId(); 
  }

  @override
  Widget build(BuildContext context) {
    String email = '';
    String password = '';

    return Consumer<LoginProvider>(
      builder: (context, loginProvider, _) {
        return Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              const SizedBox(height: 20),
              TextFormsModel(
                textInputType: TextInputType.emailAddress,
                decoration: const InputDecoration(
                  labelText: 'Correo electrónico',
                  icon: Icon(FontAwesomeIcons.envelope),
                ),
                onChanged: (String value) => email = value,
                validator: (String? value) {
                  loginProvider.emailValidator.validate(value: value!);
                  return loginProvider.emailValidator.erroMessage;
                },
              ),
              const SizedBox(height: 10),
              PasswordFormsModel(
                textInputType: TextInputType.visiblePassword,
                onChanged: (String value) => password = value,
                validator: (String? value) {
                  loginProvider.passwordValidator.validate(value: value!);
                  return loginProvider.passwordValidator.erroMessage;
                },
                label: 'Contraseña',
                tap: _toggleLogin,
                obscureText: _obscureTextPassword,
              ),
              const SizedBox(
                height: 10,
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
                child: Row(
                  children: <Widget>[
                    MaterialButton(
                      padding: const EdgeInsets.all(20),
                      color: CustomTheme.buttonSecondary,
                      splashColor: CustomTheme.buttonSecondaryGradient,
                      onPressed: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => const RegisterScreen()));
                      },
                      child: const Text('Registrarse'),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    MaterialButton(
                      padding: const EdgeInsets.all(20),
                      color: CustomTheme.buttonPrimary,
                      splashColor: CustomTheme.buttonPrimaryGradient,
                      onPressed: () async {
                        if (_formKey.currentState!.validate()) {
                          final username = await loginProvider.getUser(
                              context, email.trim(), password.trim());
                          storedUserId = username;
                          saveUserId(storedUserId
                              .toString()); // Guarda la ID como String
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) =>
                                  BankAccountScreen(user: username),
                            ),
                          );
                        } else {
                          PopUpGeneral.showMessage(context,
                              'Credenciales incorrectas, no se pudo iniciar sesión');
                        }
                      },
                      child: const Text('Iniciar sesión'),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  void _toggleLogin() {
    setState(() {
      _obscureTextPassword = !_obscureTextPassword;
    });
  }

  Future<void> saveUserId(String userId) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('userId', userId);
  }

  Future<void> loadUserId() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      storedUserId = prefs.getInt('userId') ?? 0;
    });
    if(storedUserId != 0) {
      
    }
  }
}
