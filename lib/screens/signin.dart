import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tdms_faculty/components/my_appbar.dart';
import 'package:tdms_faculty/components/widgets.dart';
import 'package:tdms_faculty/screens/create_account.dart';
import 'package:tdms_faculty/screens/dashboard.dart';
import 'package:http/http.dart' as http;
import 'package:tdms_faculty/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tdms_faculty/screens/forgot.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  Future<void> login() async {
    final email = _emailController.text.trim();
    final password = _passwordController.text.trim();

    final url = Uri.parse('$apiUrl/login');

    final response = await http.post(
      url,
      headers: {
        'Accept': 'application/json',
        'Content-Type': 'application/json',
      },
      body: jsonEncode({'email': email, 'password': password}),
    );

    final responseData = jsonDecode(response.body);

    if (response.statusCode == 200) {
      final token = responseData['access_token'];
      final message = responseData['message'];

      final prefs = await SharedPreferences.getInstance();

      if (!prefs.containsKey('auth_token')) {
        await prefs.setString('auth_token', token);
      }

      showMessageSnackbar(context, message, isError: false);
      await Future.delayed(Duration(milliseconds: 500));

      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => DashboardScreen()),
      );
    } else {
      final message = responseData['message'] ?? 'Login failed';
      showMessageSnackbar(context, message);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(50),
        child: MyAppbar(title: "Sign In", showActions: false),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Login account",
              style: GoogleFonts.inter(
                color: Color(0xFF5E875E),
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              'Start by authenticating your account',
              style: GoogleFonts.inter(color: Color(0xFF5E875E), fontSize: 12),
            ),
            SizedBox(height: 20),
            buildTextField('Email Address', _emailController),
            SizedBox(height: 16),
            buildTextField('Password', _passwordController, isPassword: true),
            SizedBox(height: 16),
            Align(
              alignment: Alignment.centerLeft,
              child: TextButton(
                onPressed: () {
                  Navigator.of(context).pushReplacement(
                    MaterialPageRoute(builder: (context) => ForgotScreen()),
                  );
                },
                style: TextButton.styleFrom(
                  padding: EdgeInsets.zero,
                  shadowColor: Colors.white,
                  enableFeedback: false,
                  tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  surfaceTintColor: Colors.transparent,
                  foregroundColor: Colors.transparent,
                ),
                child: Text(
                  'Forgot password?',
                  style: GoogleFonts.inter(color: Color(0xFF5E875E)),
                ),
              ),
            ),
            SizedBox(height: 16),
            buildGreenButton('Sign In', () async {
              await login();
            }),
            SizedBox(height: 20),
            TextButton(
              onPressed: () {
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(
                    builder: (context) => CreateAccountScreen(),
                  ),
                );
              },
              style: TextButton.styleFrom(
                padding: EdgeInsets.zero,
                shadowColor: Colors.white,
                enableFeedback: false,
                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                surfaceTintColor: Colors.transparent,
                foregroundColor: Colors.transparent,
                alignment: Alignment.center,
              ),
              child: Text(
                "Don't have an account? Sign up",
                style: GoogleFonts.inter(color: Color(0xFF5E875E)),
                textAlign: TextAlign.center,
              ),
            ),
            SizedBox(height: 20),
            Text(
              'By using our application you agree to our Terms of Service and Privacy Policy.',
              style: GoogleFonts.inter(fontSize: 12, color: Color(0xFF5E875E)),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
