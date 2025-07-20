import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tdms_faculty/components/my_appbar.dart';
import 'package:tdms_faculty/components/widgets.dart';
import 'package:tdms_faculty/screens/create_faculty.dart';
import 'package:tdms_faculty/screens/signin.dart';
import 'package:tdms_faculty/constants.dart';
import 'package:http/http.dart' as http;

class CreateAccountScreen extends StatefulWidget {
  const CreateAccountScreen({super.key});

  @override
  State<CreateAccountScreen> createState() => _CreateAccountScreenState();
}

class _CreateAccountScreenState extends State<CreateAccountScreen> {
  bool isSubmitting = false;

  final _emailController = TextEditingController();
  final _fullnameController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _fullnameController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
  }

  Future<void> register() async {
    setState(() {
      isSubmitting = true;
    });
    final email = _emailController.text.trim();
    final name = _fullnameController.text.trim();
    final password = _passwordController.text.trim();
    final confirmPassword = _confirmPasswordController.text.trim();

    final url = Uri.parse('$apiUrl/register');

    final response = await http.post(
      url,
      headers: {
        'Accept': 'application/json',
        'Content-Type': 'application/json',
      },
      body: jsonEncode({
        'email': email,
        'name': name,
        'password': password,
        'password_confirmation': confirmPassword,
      }),
    );

    final responseData = jsonDecode(response.body);

    if (response.statusCode == 201) {
      final message = responseData['message'];

      setState(() {
        isSubmitting = false;
      });

      showMessageSnackbar(context, message, isError: false);
      await Future.delayed(Duration(milliseconds: 500));

      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => SignInScreen()),
      );
    } else {
      final message = responseData['message'] ?? 'Registration failed';
      showMessageSnackbar(context, message);
      setState(() {
        isSubmitting = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(50),
        child: MyAppbar(title: "Create Account", showActions: false),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Create account",
              style: GoogleFonts.inter(
                color: Color(0xFF5E875E),
                fontSize: 20,
                fontWeight: FontWeight.w600,
              ),
            ),
            Text(
              'Start by creating your account',
              style: GoogleFonts.inter(color: Color(0xFF5E875E), fontSize: 12),
            ),
            SizedBox(height: 20),
            buildTextField('Email Address', _emailController, maxLines: 1),
            SizedBox(height: 16),
            buildTextField('Fullname', _fullnameController, maxLines: 1),
            SizedBox(height: 16),
            buildTextField(
              'Password',
              _passwordController,
              maxLines: 1,
              isPassword: true,
            ),
            SizedBox(height: 16),
            buildTextField(
              'Confirm Password',
              maxLines: 1,
              _confirmPasswordController,
              isPassword: true,
            ),
            SizedBox(height: 16),
            TextButton(
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
                'Already have an account? Sign in',
                style: GoogleFonts.inter(color: Color(0xFF5E875E)),
              ),
            ),
            SizedBox(height: 16),
            buildGreenButton(
              isSubmitting ? 'Please wait...' : 'Create Account',
              () async {
                await register();
              },
            ),

            SizedBox(height: 20),
            Center(
              child: Text(
                'OR',
                style: GoogleFonts.inter(
                  fontSize: 14,
                  color: Color(0xFF5E875E),
                  fontWeight: FontWeight.w600,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            SizedBox(height: 20),
            buildButton('Create Faculty Account', () {
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(
                  builder: (context) => CreateFacultyAccountScreen(),
                ),
              );
            }),
            SizedBox(height: 20),
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
