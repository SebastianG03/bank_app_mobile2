import 'package:bank_mobile/presentation/screens/screens.dart';
import 'package:go_router/go_router.dart';

final appRouter = GoRouter(initialLocation: '/', routes: [
  GoRoute(
    path: '/',
    name: LoginScreen.name,
    builder: (context, state) => const LoginScreen(),
  ),
  
]);
