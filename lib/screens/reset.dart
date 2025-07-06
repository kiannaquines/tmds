import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:tdms_faculty/components/widgets.dart';
import 'package:tdms_faculty/components/my_appbar.dart';
import 'package:tdms_faculty/constants.dart';
import 'package:http/http.dart' as http;

class ResetScreen extends StatefulWidget {
  final String email;
  final String token;
  const ResetScreen({super.key, required this.email, required this.token});

  @override
  State<ResetScreen> createState() => _ResetScreenState();
}

class _ResetScreenState extends State<ResetScreen> {
  final _passwordController = TextEditingController();
  final _passwordConfirmController = TextEditingController();
  final _emailController = TextEditingController();
  final _tokenController = TextEditingController();

  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _emailController.text = widget.email;
    _tokenController.text = widget.token;
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
        _passwordConfirmController.text.trim().isEmpty) {
      showMessageSnackbar(context, 'Please fill in all fields', isError: true);
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
    final token = _tokenController.text.trim();

    final url = Uri.parse('$apiUrl/forgot');
    final headers = {
      'Accept': 'application/json',
      'Content-Type': 'application/json',
    };

    final body = jsonEncode({
      "email": email,
      "token": token,
      "password": password,
      "password_confirmation": passwordConfirmation,
    });

    try {
      final response = await http.post(url, headers: headers, body: body);
      final data = jsonDecode(response.body);

      if (response.statusCode == 200) {
        if (mounted) {
          showMessageSnackbar(context, data['message'], isError: false);
          Navigator.of(context).popUntil((route) => route.isFirst);
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
          children: [
            buildTextField(
              'Email Address',
              _emailController,
              isPassword: false,
              readOnly: true,
            ),
            const SizedBox(height: 16),
            buildTextField(
              'New Password',
              _passwordController,
              isPassword: true,
            ),
            const SizedBox(height: 16),
            buildTextField(
              'Confirm New Password',
              _passwordConfirmController,
              isPassword: true,
            ),
            const SizedBox(height: 16),
            buildGreenButton(
              _isLoading ? 'Resetting...' : 'Reset Password',
              () {},
            ),
          ],
        ),
      ),
    );
  }
}
