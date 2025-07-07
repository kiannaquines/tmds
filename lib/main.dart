import 'package:flutter/material.dart';
import 'package:tdms_faculty/theme/app_theme.dart';
import 'package:tdms_faculty/auth_gate.dart';

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
