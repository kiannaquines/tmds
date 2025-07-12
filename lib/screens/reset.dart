import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tdms_faculty/components/widgets.dart';
import 'package:tdms_faculty/components/my_appbar.dart';
import 'package:tdms_faculty/constants.dart';
import 'package:http/http.dart' as http;
import 'package:tdms_faculty/screens/signin.dart';

class ResetScreen extends StatefulWidget {
  final String email;
  const ResetScreen({super.key, required this.email});

  @override
  State<ResetScreen> createState() => _ResetScreenState();
}

class _ResetScreenState extends State<ResetScreen> {
  final _passwordController = TextEditingController();
  final _passwordConfirmController = TextEditingController();
  final _otpController = TextEditingController();
  final _emailController = TextEditingController();
  final _tokenController = TextEditingController();

  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _emailController.text = widget.email;
  }

  @override
  void dispose() {
    _passwordController.dispose();
    _passwordConfirmController.dispose();
    _emailController.dispose();
    _tokenController.dispose();
    super.dispose();
  }

  Future<void> resetPassword() async {
    if (_passwordController.text.trim().isEmpty ||
        _passwordConfirmController.text.trim().isEmpty ||
        _otpController.text.trim().isEmpty) {
      showMessageSnackbar(context, 'Please fill in all fields', isError: true);
      return;
    }

    if (_passwordController.text.trim() !=
        _passwordConfirmController.text.trim()) {
      showMessageSnackbar(context, 'Passwords do not match', isError: true);
      return;
    }

    if (_passwordController.text.trim() !=
        _passwordConfirmController.text.trim()) {
      showMessageSnackbar(context, 'Passwords do not match', isError: true);
      return;
    }

    setState(() {
      _isLoading = true;
    });

    final email = _emailController.text.trim();
    final password = _passwordController.text.trim();
    final passwordConfirmation = _passwordConfirmController.text.trim();
    final otp = _otpController.text.trim();

    final url = Uri.parse('$apiUrl/reset');
    final headers = {
      'Accept': 'application/json',
      'Content-Type': 'application/json',
    };

    final body = jsonEncode({
      "email": email,
      "otp": otp,
      "password": password,
      "password_confirmation": passwordConfirmation,
    });

    try {
      final response = await http.post(url, headers: headers, body: body);
      final data = jsonDecode(response.body);

      if (response.statusCode == 200) {
        if (mounted) {
          showMessageSnackbar(context, data['message'], isError: false);
          Navigator.of(
            context,
          ).push(MaterialPageRoute(builder: (context) => const SignInScreen()));
        }
      } else {
        if (mounted) {
          showMessageSnackbar(
            context,
            data['message'] ?? 'Reset failed',
            isError: true,
          );
        }
      }
    } catch (e) {
      if (mounted) {
        showMessageSnackbar(
          context,
          "Network error: ${e.toString()}",
          isError: true,
        );
      }
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const PreferredSize(
        preferredSize: Size.fromHeight(50),
        child: MyAppbar(title: "Reset Password", showActions: false),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Reset account",
              style: GoogleFonts.inter(
                color: Color(0xFF5E875E),
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              'Start by providing your OTP and new password',
              style: GoogleFonts.inter(color: Color(0xFF5E875E), fontSize: 12),
            ),
            SizedBox(height: 20),
            buildTextField(
              'Email Address',
              _emailController,
              isPassword: false,
              readOnly: true,
              maxLines: 1,
            ),
            const SizedBox(height: 16),
            buildTextField(
              'One Time Passcode',
              _otpController,
              isPassword: true,
              isNumeric: true,
              maxLines: 1,
            ),
            const SizedBox(height: 16),
            buildTextField(
              'New Password',
              _passwordController,
              isPassword: true,
              maxLines: 1,
            ),
            const SizedBox(height: 16),
            buildTextField(
              'Confirm New Password',
              _passwordConfirmController,
              isPassword: true,
              maxLines: 1,
            ),
            SizedBox(height: 16),
            Align(
              alignment: Alignment.centerLeft,
              child: TextButton(
                onPressed: () {
                  Navigator.of(context).pushReplacement(
                    MaterialPageRoute(builder: (context) => SignInScreen()),
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
                  'Already have an account?',
                  style: GoogleFonts.inter(color: Color(0xFF5E875E)),
                ),
              ),
            ),
            const SizedBox(height: 16),
            buildGreenButton(
              _isLoading ? 'Resetting...' : 'Reset Password',
              () async {
                await resetPassword();
              },
            ),
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.only(bottom: 12.0),
        child: Text(
          'By using our application you agree to our Terms of Service and Privacy Policy.',
          style: GoogleFonts.inter(fontSize: 12, color: Color(0xFF5E875E)),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
