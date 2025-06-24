import 'package:flutter/material.dart';
import 'theme/app_theme.dart';

import 'package:tdms_faculty/screens/dashboard.dart';
import 'package:tdms_faculty/screens/faculty_dashboard.dart';
import 'package:tdms_faculty/screens/feedback.dart';
import 'package:tdms_faculty/screens/signin.dart';
import 'package:tdms_faculty/screens/create_account.dart';
import 'package:tdms_faculty/screens/thesis_status.dart';
import 'package:tdms_faculty/screens/upload_thesis.dart';

void main() {
  runApp(ThesisManagementApp());
}

class ThesisManagementApp extends StatelessWidget {
  const ThesisManagementApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Thesis Management',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.buildTheme(),
      home: SignInScreen(),
      routes: {
        '/signin': (context) => SignInScreen(),
        '/create-account': (context) => CreateAccountScreen(),
        '/dashboard': (context) => DashboardScreen(),
        '/faculty-dashboard': (context) => FacultyDashboardScreen(),
        '/feedback': (context) => FeedbackScreen(),
        '/thesis-status': (context) => ThesisStatusScreen(),
        '/upload-thesis': (context) => UploadThesisScreen(),
      },
    );
  }
}
