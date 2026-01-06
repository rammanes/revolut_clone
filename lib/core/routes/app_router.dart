import 'package:go_router/go_router.dart';
import 'package:revolut_clone/features/auth/screens/create_account_screen.dart';
import 'package:revolut_clone/features/auth/screens/login_screen.dart';
import 'package:revolut_clone/features/auth/screens/splash_screen.dart';

class AppRouter {
  static final GoRouter router = GoRouter(
    initialLocation: '/',
    routes: [
      GoRoute(
        path: '/',
        name: 'splash',
        builder: (context, state) => const SplashScreen(),
      ),
      GoRoute(
        path: '/create-account',
        name: 'create-account',
        builder: (context, state) => const CreateAccountScreen(),
      ),
      GoRoute(
        path: '/login',
        name: 'login',
        builder: (context, state) => const LoginScreen(),
      ),
    ],
  );
}
