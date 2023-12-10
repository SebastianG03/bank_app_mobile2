import 'package:bank_mobile/config/theme/theme.dart';
import 'package:bank_mobile/presentation/providers/registration_provider.dart';
import 'package:bank_mobile/presentation/screens/login/login_screen.dart';
import 'package:bank_mobile/presentation/widgets/shared/pop_up/pop_up_general.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

import '../../widgets/inputs/inputs.dart';

class RegisterView extends StatefulWidget {
  const RegisterView({super.key});

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  int idUser = 0;
  String name = '';
  String email = '';
  String password = '';
  String phone = '';
  String role = 'client';
  String dni = '';

  bool _obscureTextPassword = true;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Consumer<RegistrationProvider>(
        builder: (context, registrationProvider, _) {
      return SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              ..._getWidgets(context),
              const SizedBox(
                height: 20,
              ),
              MaterialButton(
                padding: const EdgeInsets.all(20),
                color: CustomTheme.buttonPrimary,
                splashColor: CustomTheme.buttonPrimaryGradient,
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    await registrationProvider.createUser(
                      name: name,
                      mail: email,
                      dni: dni,
                      phone: phone,
                      password: password,
                    );
                    Navigator.of(context).pushReplacement(
                      MaterialPageRoute(
                        builder: (context) => const LoginScreen(),
                      ),
                    );
                  } else {
                    PopUpGeneral.showMessage(context,
                        "Datos inválidos, no se pudo crear su cuenta.");
                  }
                },
                child: const Text(
                  'Registrarse',
                  style: TextStyle(color: Colors.black),
                ),
              ),
              const SizedBox(
                height: 30,
              ),
            ],
          ),
        ),
      );
    });
  }

  List<Widget> _getWidgets(BuildContext context) {
    return <Widget>[
      TextFormsModel(
        textInputType: TextInputType.text,
        decoration: const InputDecoration(
          labelText: 'Nombre',
          icon: Icon(FontAwesomeIcons.person),
        ),
        onChanged: (String value) {
          name = value;
        },
      ),
      _divider(context),
      TextFormsModel(
        textInputType: TextInputType.emailAddress,
        decoration: const InputDecoration(
          labelText: 'Email',
          icon: Icon(FontAwesomeIcons.envelope),
        ),
        onChanged: (String value) {
          email = value;
        },
      ),
      _divider(context),
      TextFormsModel(
        textInputType: TextInputType.phone,
        decoration: const InputDecoration(
          labelText: 'Teléfono',
          icon: Icon(FontAwesomeIcons.phone),
        ),
        onChanged: (String value) {
          phone = value;
        },
      ),
      _divider(context),
      TextFormsModel(
        textInputType: TextInputType.number,
        decoration: const InputDecoration(
          labelText: 'Cédula',
          icon: Icon(FontAwesomeIcons.idCard),
        ),
        onChanged: (String value) {
          dni = value;
        },
      ),
      _divider(context),
      PasswordFormsModel(
          textInputType: TextInputType.visiblePassword,
          label: 'Contraseña',
          onChanged: (String value) {
            password = value;
          },
          tap: _toggleSignup,
          obscureText: _obscureTextPassword),
    ];
  }

  Widget _divider(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return Divider(
      color: Colors.transparent,
      height: 10,
      indent: width * 0.01,
      endIndent: width * 0.01,
    );
  }

  void _toggleSignup() {
    setState(() {
      _obscureTextPassword = !_obscureTextPassword;
    });
  }
}
