import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
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
  final _yearController = TextEditingController();

  String? _selectedDepartment;
  String? _selectedPanel1;
  String? _selectedPanel2;
  String? _selectedPanel3;
  String? _selectedStudyType;
  String? _selectedAdviser;

  @override
  void initState() {
    super.initState();
    _fetchFaculty();
    _fetchDepartment();
    _fetchStudyType();
    _getToken();
  }

  List<String> departments = [];
  List<String> faculty = [];
  List<String> studyTypes = [];

  Future<String?> _getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('auth_token');
  }

  Future<void> _fetchDepartment() async {
    final url = Uri.parse('$apiUrl/department');
    final token = await _getToken();
    final response = await http.get(
      url,
      headers: {
        'Accept': 'application/json',
        'Content-Type': 'application/json',
        if (token != null) 'Authorization': 'Bearer $token',
      },
    );
    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body);
      setState(() {
        departments =
            data.map<String>((item) => item['name'].toString()).toList();
      });
    } else {
      showMessageSnackbar(context, 'Failed to fetch department list.');
    }
  }

  Future<void> _fetchStudyType() async {
    final url = Uri.parse('$apiUrl/study');
    final token = await _getToken();
    final response = await http.get(
      url,
      headers: {
        'Accept': 'application/json',
        'Content-Type': 'application/json',
        if (token != null) 'Authorization': 'Bearer $token',
      },
    );
    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body);
      setState(() {
        studyTypes =
            data.map<String>((item) => item['type'].toString()).toList();
      });
    } else {
      showMessageSnackbar(context, 'Failed to fetch study type list.');
    }
  }

  Future<void> _fetchFaculty() async {
    final url = Uri.parse('$apiUrl/faculty');
    final token = await _getToken();
    final response = await http.get(
      url,
      headers: {
        'Accept': 'application/json',
        'Content-Type': 'application/json',
        if (token != null) 'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body);
      setState(() {
        faculty = data.map<String>((item) => item['name'].toString()).toList();
      });
    } else {
      showMessageSnackbar(context, 'Failed to fetch faculty list.');
    }
  }

  Future<void> storeThesis() async {
    final title = _titleController.text.trim();
    final department = _selectedDepartment;
    final adviser = _selectedAdviser;
    final panel1 = _selectedPanel1;
    final panel2 = _selectedPanel2;
    final panel3 = _selectedPanel3;
    final year = _yearController.text.trim();
    final type = _selectedStudyType;

    final body = jsonEncode({
      "title": title,
      "department": department,
      "adviser": adviser,
      "panel1": panel1,
      "panel2": panel2,
      "panel3": panel3,
      "year": year,
      "type": type,
    });

    debugPrint(body);

    try {
      final url = Uri.parse('$apiUrl/thesis');
      final token = await _getToken();

      final response = await http.post(
        url,
        headers: {
          'Accept': 'application/json',
          'Content-Type': 'application/json',
          if (token != null) 'Authorization': 'Bearer $token',
        },
        body: body,
      );

      final bodyMessage = jsonDecode(response.body);

      if (response.statusCode == 201) {
        showMessageSnackbar(context, bodyMessage['message'], isError: false);
        _titleController.clear();
        _yearController.clear();

        setState(() {
          _selectedDepartment = null;
          _selectedAdviser = null;
          _selectedPanel1 = null;
          _selectedPanel2 = null;
          _selectedPanel3 = null;
          _selectedStudyType = null;
        });
      } else {
        showMessageSnackbar(context, bodyMessage['message'], isError: true);
      }
    } catch (e) {
      showMessageSnackbar(context, 'Something went wrong: $e', isError: true);
    }
  }

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
            buildTextField('Study Title', _titleController, maxLines: 2),
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
            buildDropdown('Select Adviser', _selectedAdviser, faculty, (value) {
              setState(() => _selectedAdviser = value);
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
            buildDropdown('Select Panel 1', _selectedPanel1, faculty, (value) {
              setState(() => _selectedPanel1 = value);
            }),
            SizedBox(height: 16),
            buildDropdown('Select Panel 2', _selectedPanel2, faculty, (value) {
              setState(() => _selectedPanel2 = value);
            }),
            SizedBox(height: 16),
            buildDropdown('Select Panel 3', _selectedPanel3, faculty, (value) {
              setState(() => _selectedPanel3 = value);
            }),
            SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  flex: 1,
                  child: buildTextField(
                    'Year',
                    _yearController,
                    isNumeric: true,
                    maxLines: 1,
                  ),
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
            buildGreenButton('Submit Thesis', () async {
              await storeThesis();
            }),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _titleController.dispose();
    super.dispose();
  }
}
