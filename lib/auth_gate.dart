import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tdms_faculty/screens/dashboard.dart';
import 'package:tdms_faculty/screens/faculty_dashboard.dart';
import 'package:tdms_faculty/screens/signin.dart';

class AuthGate extends StatefulWidget {
  const AuthGate({super.key});

  @override
  State<AuthGate> createState() => _AuthGateState();
}

class _AuthGateState extends State<AuthGate> {
  bool _isReady = false;
  bool _isLoggedIn = false;
  String _role = '';

  @override
  void initState() {
    super.initState();
    _initializeApp();
  }

  Future<void> _initializeApp() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('auth_token');
    final role = prefs.getString('role');

    setState(() {
      _isLoggedIn = token != null && token.isNotEmpty;
      _role = role ?? '';
      _isReady = true;
    });
  }

  Widget _getRedirectScreen() {
    if (!_isLoggedIn) return const SignInScreen();

    switch (_role) {
      case 'Student':
        return const DashboardScreen();

      case 'Adviser':
      case 'Faculty':
      case 'Department Research Coordinator':
      case 'Department Chairperson':
      case 'College Research Coordinator':
      case 'College Dean':
        return const FacultyDashboardScreen();

      default:
        return const Scaffold(
          body: Center(
            child: Text(
              'Unknown role. Please contact support.',
              style: TextStyle(color: Colors.red),
            ),
          ),
        );
    }
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

    return _getRedirectScreen();
  }
}
