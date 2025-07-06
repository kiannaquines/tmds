import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:tdms_faculty/components/widgets.dart';
import 'package:tdms_faculty/components/my_appbar.dart';
import 'package:tdms_faculty/constants.dart';
import 'package:http/http.dart' as http;

class ResetScreen extends StatefulWidget {
  const ResetScreen({super.key});

  @override
  State<ResetScreen> createState() => _ResetScreenState();
}

class _ResetScreenState extends State<ResetScreen> {
  final _passwordController = TextEditingController();
  final _passwordConfirmController = TextEditingController();
  final _emailController = TextEditingController();
  final _tokenController = TextEditingController();

  bool _isLoading = false;

  Future<void> resetPassword() async {
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
        // ignore: use_build_context_synchronously
        showMessageSnackbar(context, data['message'], isError: false);
      } else {
        // ignore: use_build_context_synchronously
        showMessageSnackbar(context, data['message'], isError: true);
      }
    } catch (e) {
      // ignore: use_build_context_synchronously
      showMessageSnackbar(context, "$e", isError: true);
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(50),
        child: MyAppbar(title: "Reset Password", showActions: false),
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            buildTextField(
              'Email Address',
              _emailController,
              isPassword: false,
            ),
            SizedBox(height: 16),
            buildTextField('Password', _passwordController, isPassword: true),
            SizedBox(height: 16),
            buildTextField(
              'Confirm Password',
              _passwordConfirmController,
              isPassword: true,
            ),
            SizedBox(height: 16),
            buildGreenButton(
              _isLoading ? 'Loading' : 'Reset Password',
              () async {
                await resetPassword();
              },
            ),
          ],
        ),
      ),
    );
  }
}
