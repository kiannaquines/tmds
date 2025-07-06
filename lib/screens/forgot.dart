import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tdms_faculty/components/my_appbar.dart';
import 'package:tdms_faculty/components/widgets.dart';
import 'package:tdms_faculty/constants.dart';
import 'package:http/http.dart' as http;
import 'package:tdms_faculty/screens/signin.dart';

class ForgotScreen extends StatefulWidget {
  const ForgotScreen({super.key});

  @override
  State<ForgotScreen> createState() => _ForgotScreenState();
}

class _ForgotScreenState extends State<ForgotScreen> {
  final _emailController = TextEditingController();
  bool _isLoading = false;

  Future<void> forgotPassword() async {
    setState(() {
      _isLoading = true;
    });

    final url = Uri.parse('$apiUrl/forgot');
    final headers = {
      'Accept': 'application/json',
      'Content-Type': 'application/json',
    };

    final body = jsonEncode({'email': _emailController.text.trim()});

    try {
      final response = await http.post(url, headers: headers, body: body);

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        // ignore: use_build_context_synchronously
        showMessageSnackbar(context, data['message'], isError: false);
      } else {
        final error = jsonDecode(response.body);
        // ignore: use_build_context_synchronously
        showMessageSnackbar(context, error['message'], isError: true);
      }
    } catch (e) {
      // ignore: use_build_context_synchronously
      showMessageSnackbar(context, "$e", isError: true);
    } finally {
      setState(() {
        _isLoading = false;
      });
      _emailController.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(50),
        child: MyAppbar(title: "Forgot Password", showActions: false),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            SizedBox(height: 16),
            buildTextField('Email Address', _emailController),
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
            SizedBox(height: 16),
            buildGreenButton(
              _isLoading ? 'Loading..' : 'Forgot Password',
              () async {
                await forgotPassword();
              },
            ),
          ],
        ),
      ),
    );
  }
}
