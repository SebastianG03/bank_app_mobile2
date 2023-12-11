import 'package:bank_mobile/config/theme/theme.dart';
import 'package:bank_mobile/presentation/screens/screens.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Obtén el userId almacenado en SharedPreferences
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String userId = prefs.getString('userId') ?? "";

  runApp(MyApp(userId: userId));
}

class MyApp extends StatelessWidget {
  final String userId;

  const MyApp({Key? key, required this.userId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Tu Banco Online',
      theme: CustomTheme.lightTheme,
      home: userId.isNotEmpty
          ? BankAccountScreen(user: int.parse(userId))
          : const LoginScreen(),
    );
  }
}
