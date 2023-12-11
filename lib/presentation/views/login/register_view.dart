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
  final TextEditingController nameController = TextEditingController();
  final TextEditingController mailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController dniController = TextEditingController();

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
              ..._getWidgets(context, registrationProvider),
              const SizedBox(
                height: 20,
              ),
              MaterialButton(
                padding: const EdgeInsets.all(20),
                color: CustomTheme.buttonPrimary,
                splashColor: CustomTheme.buttonPrimaryGradient,
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    try {
                      await registrationProvider.createUser(
                        name: nameController.text.trim(),
                        mail: mailController.text.trim(),
                        password: passwordController.text.trim(),
                        phone: phoneController.text.trim(),
                        dni: dniController.text.trim(),
                      );
                      Navigator.of(context).pushReplacement(
                        MaterialPageRoute(
                          builder: (context) => const LoginScreen(),
                        ),
                      );
                    } catch (e) {
                      print(e.toString());
                    }
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

  List<Widget> _getWidgets(
      BuildContext context, RegistrationProvider registrationProvider) {
    return <Widget>[
      TextFormsModel(
        controller: nameController,
        textInputType: TextInputType.text,
        decoration: const InputDecoration(
          labelText: 'Nombre',
          icon: Icon(FontAwesomeIcons.person),
        ),
        onChanged: (String value) {
          name = value;
        },
        validator: (String? value) {
          registrationProvider.nameValidator.validate(value: value!);
          return registrationProvider.nameValidator.erroMessage;
        },
      ),
      _divider(context),
      TextFormsModel(
        controller: mailController,
        textInputType: TextInputType.emailAddress,
        decoration: const InputDecoration(
          labelText: 'Email',
          icon: Icon(FontAwesomeIcons.envelope),
        ),
        onChanged: (String value) {
          email = value;
        },
        validator: (String? value) {
          registrationProvider.emailValidator.validate(value: value!);
          return registrationProvider.emailValidator.erroMessage;
        },
      ),
      _divider(context),
      TextFormsModel(
        controller: phoneController,
        textInputType: TextInputType.phone,
        decoration: const InputDecoration(
          labelText: 'Teléfono',
          icon: Icon(FontAwesomeIcons.phone),
        ),
        onChanged: (String value) {
          phone = value;
        },
        validator: (String? value) {
          registrationProvider.phoneValidator.validate(value: value!);
          return registrationProvider.phoneValidator.erroMessage;
        },
      ),
      _divider(context),
      TextFormsModel(
        controller: dniController,
        textInputType: TextInputType.number,
        decoration: const InputDecoration(
          labelText: 'Cédula',
          icon: Icon(FontAwesomeIcons.idCard),
        ),
        onChanged: (String value) {
          dni = value;
        },
        validator: (String? value) {
          registrationProvider.dniValidator.validate(value: value!);
          return registrationProvider.dniValidator.erroMessage;
        },
      ),
      _divider(context),
      PasswordFormsModel(
          controller: passwordController,
          textInputType: TextInputType.visiblePassword,
          label: 'Contraseña',
          onChanged: (String value) {
            password = value;
          },
          validator: (String? value) {
            registrationProvider.passwordValidator.validate(value: value!);
            return registrationProvider.passwordValidator.erroMessage;
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
