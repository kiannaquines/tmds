import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tdms_faculty/components/my_appbar.dart';
import 'package:tdms_faculty/components/widgets.dart';
import 'package:tdms_faculty/screens/create_account.dart';
import 'package:tdms_faculty/screens/dashboard.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

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
          children: [
            SizedBox(height: 20),
            buildTextField('Email Address', _emailController),
            SizedBox(height: 16),
            buildTextField('Password', _passwordController, isPassword: true),
            SizedBox(height: 16),
            Align(
              alignment: Alignment.centerLeft,
              child: TextButton(
                onPressed: () {},
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
            buildGreenButton('Sign In', () {
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(builder: (context) => DashboardScreen()),
              );
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
              ),
              child: Text(
                "Don't have an account? Sign up",
                style: GoogleFonts.inter(color: Color(0xFF5E875E)),
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
