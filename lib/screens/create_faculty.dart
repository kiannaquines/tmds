import 'package:flutter/material.dart';
import 'package:tdms_faculty/components/my_appbar.dart';
import 'package:tdms_faculty/screens/signin.dart';
import 'package:tdms_faculty/components/widgets.dart';

class CreateFacultyAccountScreen extends StatefulWidget {
  const CreateFacultyAccountScreen({super.key});

  @override
  State<CreateFacultyAccountScreen> createState() =>
      _CreateFacultyAccountScreenState();
}

class _CreateFacultyAccountScreenState
    extends State<CreateFacultyAccountScreen> {
  final _emailController = TextEditingController();
  final _fullnameController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  String? _selectedRole;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(50),
        child: MyAppbar(title: "Create Faculty Account", showActions: false),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            SizedBox(height: 20),
            buildTextField('Email Address', _emailController),
            SizedBox(height: 16),
            buildTextField('Fullname', _fullnameController),
            SizedBox(height: 16),
            buildDropdown(
              'Select Role',
              _selectedRole,
              [
                'Panel',
                'Department Coordinator',
                'Department Research Coordinator',
                'Thesis Adviser',
                'College Research Coordinator',
                'College Dean',
              ],
              (String? newValue) {
                setState(() {
                  _selectedRole = newValue;
                });
              },
            ),
            SizedBox(height: 16),
            buildTextField('Password', _passwordController, isPassword: true),
            SizedBox(height: 16),
            buildTextField(
              'Confirm Password',
              _confirmPasswordController,
              isPassword: true,
            ),
            SizedBox(height: 40),
            buildGreenButton('Create Account', () {
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(builder: (context) => SignInScreen()),
              );
            }),
            SizedBox(height: 20),
            TextButton(
              onPressed: () {
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (context) => SignInScreen()),
                );
              },
              child: Text(
                'Already have an account? Sign in',
                style: TextStyle(color: Color(0xFF5E875E)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
