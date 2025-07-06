import 'dart:async';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:app_links/app_links.dart';
import 'package:tdms_faculty/theme/app_theme.dart';
import 'package:tdms_faculty/screens/dashboard.dart';
import 'package:tdms_faculty/screens/signin.dart';
import 'package:tdms_faculty/screens/reset.dart';

void main() {
  runApp(const ThesisManagementApp());
}

class ThesisManagementApp extends StatelessWidget {
  const ThesisManagementApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'TDMS - App',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.buildTheme(),
      home: const AuthGate(),
    );
  }
}

class AuthGate extends StatefulWidget {
  const AuthGate({super.key});

  @override
  State<AuthGate> createState() => _AuthGateState();
}

class _AuthGateState extends State<AuthGate> {
  bool _isReady = false;
  bool _isLoggedIn = false;
  bool _handlingLink = false;

  final AppLinks _appLinks = AppLinks();
  StreamSubscription<Uri>? _linkSubscription;

  @override
  void initState() {
    super.initState();
    _initializeApp();
  }

  Future<void> _initializeApp() async {
    await _checkAuthToken();
    _listenToLinks();
    await _handleInitialDeepLink();
    setState(() => _isReady = true);
  }

  Future<void> _checkAuthToken() async {
    final prefs = await SharedPreferences.getInstance();
    final hasToken =
        prefs.containsKey('auth_token') &&
        (prefs.getString('auth_token')?.isNotEmpty ?? false);

    // Clear any residual reset data
    await prefs.remove('reset_token');
    await prefs.remove('reset_email');

    setState(() => _isLoggedIn = hasToken);
  }

  Future<void> _handleInitialDeepLink() async {
    if (_handlingLink) return;
    _handlingLink = true;

    try {
      final Uri? initialUri = await _appLinks.getInitialLink();
      if (initialUri != null) {
        await _processDeepLink(initialUri);
      }
    } catch (e) {
      debugPrint('Error getting initial deep link: $e');
    } finally {
      _handlingLink = false;
    }
  }

  void _listenToLinks() {
    _linkSubscription = _appLinks.uriLinkStream.listen((Uri uri) async {
      if (!_handlingLink) {
        _handlingLink = true;
        await _processDeepLink(uri);
        _handlingLink = false;
      }
    }, onError: (err) => debugPrint('Deep link error: $err'));
  }

  Future<void> _processDeepLink(Uri uri) async {
    if (!mounted) return;

    debugPrint('Received deep link: $uri');

    // Strict validation for reset links
    if (uri.host == 'reset' &&
        uri.queryParameters.containsKey('token') &&
        uri.queryParameters.containsKey('email')) {
      final token = uri.queryParameters['token']!;
      final email = uri.queryParameters['email']!;

      if (token.isNotEmpty && email.isNotEmpty) {
        if (mounted) {
          Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(
              builder: (context) => ResetScreen(email: email, token: token),
            ),
            (route) => false,
          );
        }
      }
    }
  }

  @override
  void dispose() {
    _linkSubscription?.cancel();
    super.dispose();
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
