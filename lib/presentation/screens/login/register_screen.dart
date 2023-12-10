import 'package:bank_mobile/presentation/providers/registration_provider.dart';
import 'package:bank_mobile/presentation/views/login/register_view.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<RegistrationProvider>(
          create: (_) => RegistrationProvider(),
        ),
        
      ],
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Registro'),
        ),
        body: const SafeArea(child: RegisterView()),
        
      ),
    );
  }
}