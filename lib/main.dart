import 'package:flutter/material.dart';
import 'theme/app_theme.dart';
import 'package:tdms_faculty/screens/dashboard.dart';
import 'package:tdms_faculty/screens/signin.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(ThesisManagementApp());
}

class ThesisManagementApp extends StatelessWidget {
  const ThesisManagementApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'TDMS - App',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.buildTheme(),
      home: AuthGate(),
    );
  }
}

class AuthGate extends StatelessWidget {
  const AuthGate({super.key});

  Future<bool> _checkToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.containsKey('auth_token') &&
        (prefs.getString('auth_token')?.isNotEmpty ?? false);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<bool>(
      future: _checkToken(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Scaffold(
            body: Center(
              child: CircularProgressIndicator(color: Color(0xFF5E875E)),
            ),
          );
        }

        if (snapshot.hasData && snapshot.data == true) {
          return DashboardScreen();
        } else {
          return SignInScreen();
        }
      },
    );
  }
}
