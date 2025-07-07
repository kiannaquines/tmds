import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tdms_faculty/screens/dashboard.dart';
import 'package:tdms_faculty/screens/signin.dart';

class AuthGate extends StatefulWidget {
  const AuthGate({super.key});

  @override
  State<AuthGate> createState() => _AuthGateState();
}

class _AuthGateState extends State<AuthGate> {
  bool _isReady = false;
  bool _isLoggedIn = false;

  @override
  void initState() {
    super.initState();
    _initializeApp();
  }

  Future<void> _initializeApp() async {
    final prefs = await SharedPreferences.getInstance();
    final hasToken =
        prefs.containsKey('auth_token') &&
        (prefs.getString('auth_token')?.isNotEmpty ?? false);

    setState(() {
      _isLoggedIn = hasToken;
      _isReady = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (!_isReady) {
      return const Scaffold(
        body: Center(
          child: CircularProgressIndicator(color: Color(0xFF5E875E)),
        ),
      );
    }

    return _isLoggedIn ? const DashboardScreen() : const SignInScreen();
  }
}
