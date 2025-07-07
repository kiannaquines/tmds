import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:tdms_faculty/components/my_appbar.dart';
import 'package:tdms_faculty/components/widgets.dart';
import 'package:tdms_faculty/constants.dart';
import 'package:tdms_faculty/screens/dashboard.dart';

class UploadThesisScreen extends StatefulWidget {
  const UploadThesisScreen({super.key});

  @override
  State<UploadThesisScreen> createState() => _UploadThesisScreenState();
}

class _UploadThesisScreenState extends State<UploadThesisScreen> {
  final _titleController = TextEditingController();
  final _authorController = TextEditingController();
  final _advisorController = TextEditingController();
  final _panelist1Controller = TextEditingController();
  final _panelist2Controller = TextEditingController();
  final _panelist3Controller = TextEditingController();
  final _yearController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _fetchDepartment();
    _fetchFaculty();
    _fetchStudyType();
  }

  final List<String> departments = [];
  List<String> _faculty = [];
  final List<String> studyTypes = [];

  Future<void> _fetchDepartment() async {}
  Future<void> _fetchStudyType() async {}

  Future<void> _fetchFaculty() async {
    final url = Uri.parse('$apiUrl/faculty');

    final response = await http.get(
      url,
      headers: {
        'Accept': 'application/json',
        'Content-Type': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body);

      setState(() {
        _faculty = data.map<String>((item) => item['name'].toString()).toList();
      });
    } else {
      showMessageSnackbar(context, 'Failed to fetch faculty list.');
    }
  }

  String? _selectedDepartment;
  String? _selectedStudyType;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(50),
        child: MyAppbar(
          title: "Upload Thesis",
          showActions: false,
          withLeading: true,
          locationScreen:
              () => Navigator.of(context).pushReplacement(
                MaterialPageRoute(builder: (context) => DashboardScreen()),
              ),
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Thesis Details",
              style: GoogleFonts.inter(
                color: Color(0xFF5E875E),
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              'Fill out all of the inputs needed.',
              style: GoogleFonts.inter(color: Color(0xFF5E875E), fontSize: 12),
            ),
            SizedBox(height: 20),
            buildTextField('Study Title', _titleController),
            SizedBox(height: 16),
            buildTextField('Author', _authorController),
            SizedBox(height: 16),
            buildDropdown(
              'Select Department',
              _selectedDepartment,
              departments,
              (value) {
                setState(() => _selectedDepartment = value);
              },
            ),
            SizedBox(height: 16),
            buildDropdown('Select Adviser', _selectedDepartment, departments, (
              value,
            ) {
              setState(() => _selectedDepartment = value);
            }),
            SizedBox(height: 16),
            Text(
              'Thesis Panel',
              style: GoogleFonts.inter(
                color: Color(0xFF5E875E),
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
            Text(
              'Select your thesis panel from your defense.',
              style: GoogleFonts.inter(
                fontWeight: FontWeight.w400,
                color: Color(0xFF5E875E),
                fontSize: 12,
              ),
            ),
            SizedBox(height: 16),
            buildDropdown('Select Panel 1', _selectedDepartment, departments, (
              value,
            ) {
              setState(() => _selectedDepartment = value);
            }),
            SizedBox(height: 16),
            buildDropdown('Select Panel 2', _selectedDepartment, departments, (
              value,
            ) {
              setState(() => _selectedDepartment = value);
            }),
            SizedBox(height: 16),
            buildDropdown('Select Panel 3', _selectedDepartment, departments, (
              value,
            ) {
              setState(() => _selectedDepartment = value);
            }),
            SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  flex: 1,
                  child: buildTextField('Year', _yearController),
                ),
                SizedBox(width: 16),
                Expanded(
                  flex: 1,
                  child: buildDropdown(
                    'Study',
                    _selectedStudyType,
                    studyTypes,
                    (value) {
                      setState(() => _selectedStudyType = value);
                    },
                  ),
                ),
              ],
            ),
            SizedBox(height: 40),
            buildGreenButton('Submit Thesis', () {
              if (_validateForm()) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('Thesis submitted successfully!'),
                    backgroundColor: Color(0xFF4CAF50),
                  ),
                );
                Navigator.pop(context);
              } else {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('Please fill in all required fields'),
                    backgroundColor: Colors.red,
                  ),
                );
              }
            }),
          ],
        ),
      ),
    );
  }

  bool _validateForm() {
    return _titleController.text.isNotEmpty &&
        _authorController.text.isNotEmpty &&
        _advisorController.text.isNotEmpty &&
        _panelist1Controller.text.isNotEmpty &&
        _panelist2Controller.text.isNotEmpty &&
        _panelist3Controller.text.isNotEmpty &&
        _yearController.text.isNotEmpty &&
        _selectedDepartment != null &&
        _selectedStudyType != null;
  }

  @override
  void dispose() {
    _titleController.dispose();
    _authorController.dispose();
    _advisorController.dispose();
    _panelist1Controller.dispose();
    _panelist2Controller.dispose();
    _panelist3Controller.dispose();
    _yearController.dispose();
    super.dispose();
  }
}
