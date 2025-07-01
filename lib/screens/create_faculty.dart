import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:tdms_faculty/components/my_appbar.dart';
import 'package:tdms_faculty/screens/signin.dart';
import 'package:tdms_faculty/components/widgets.dart';
import 'package:tdms_faculty/constants.dart';
import 'package:http/http.dart' as http;

class CreateFacultyAccountScreen extends StatefulWidget {
  const CreateFacultyAccountScreen({super.key});

  @override
  State<CreateFacultyAccountScreen> createState() =>
      _CreateFacultyAccountScreenState();
}

class _CreateFacultyAccountScreenState
    extends State<CreateFacultyAccountScreen> {
  @override
  void initState() {
    super.initState();
    fetchRoles();
  }

  final _emailController = TextEditingController();
  final _fullnameController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  List<String> _roles = [];
  String? _selectedRole;

  Future<void> fetchRoles() async {
    final url = Uri.parse('$apiUrl/roles');

    final response = await http.get(
      url,
      headers: {
        'Accept': 'application/json',
        'Content-Type': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> jsonData = jsonDecode(response.body);
      final List<dynamic> data = jsonData['data'];

      setState(() {
        _roles = data.map<String>((item) => item['role'].toString()).toList();
      });
    } else {
      // ignore: use_build_context_synchronously
      showMessageSnackbar(context, 'You have an empty roles, please add.');
    }
  }

  Future<void> registerFaculty() async {
    final email = _emailController.text.trim();
    final name = _fullnameController.text.trim();
    final password = _passwordController.text.trim();
    final confirmPassword = _confirmPasswordController.text.trim();
    final role = _selectedRole;

    final url = Uri.parse('$apiUrl/register/faculty');
    final response = await http.post(
      url,
      headers: {
        'Accept': 'application/json',
        'Content-Type': 'application/json',
      },
      body: jsonEncode({
        'name': name,
        'email': email,
        'password': password,
        'password_confirmation': confirmPassword,
        'role': role,
      }),
    );

    final responseData = jsonDecode(response.body);

    if (response.statusCode == 201) {
      final message = responseData['message'];

      // ignore: use_build_context_synchronously
      showMessageSnackbar(context, message, isError: false);
      await Future.delayed(Duration(milliseconds: 500));

      // ignore: use_build_context_synchronously
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => SignInScreen()),
      );
    } else {
      final message = responseData['message'] ?? 'Registration failed';

      // ignore: use_build_context_synchronously
      showMessageSnackbar(context, message);
    }
  }

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
            buildDropdown('Select Role', _selectedRole, _roles, (
              String? newValue,
            ) {
              setState(() {
                _selectedRole = newValue;
              });
            }),
            SizedBox(height: 16),
            buildTextField('Password', _passwordController, isPassword: true),
            SizedBox(height: 16),
            buildTextField(
              'Confirm Password',
              _confirmPasswordController,
              isPassword: true,
            ),
            SizedBox(height: 40),
            buildGreenButton('Create Account', () async {
              await registerFaculty();
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
