import 'package:flutter/material.dart';
import 'package:revolut_clone/features/auth/screens/splash_screen.dart';
import 'package:revolut_clone/styles/app_theme.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Revolut Clone',
      theme: AppTheme.darkTheme,
      home: const SplashScreen(),
    );
  }
}
