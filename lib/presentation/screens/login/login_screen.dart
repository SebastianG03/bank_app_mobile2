import 'package:bank_mobile/presentation/screens/bank_account/bank_account_screen.dart';
import 'package:bank_mobile/presentation/providers/login_provider.dart';
import 'package:bank_mobile/presentation/screens/login/register_screen.dart';
import 'package:bank_mobile/presentation/widgets/shared/pop_up/pop_up_general.dart';
import 'package:bank_mobile/presentation/views/login/login_view.dart';
import 'package:bank_mobile/presentation/widgets/inputs/inputs.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatelessWidget {
  static const String name = 'login_screen';

  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<LoginProvider>(
          create: (_) => LoginProvider(),
        ),
      ],
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Login'),
        ),
        body: const SafeArea(child: LoginBody()),
      ),
    );
  }
}
