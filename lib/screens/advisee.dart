import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tdms_faculty/components/my_appbar.dart';
import 'package:tdms_faculty/components/widgets.dart';
import 'package:tdms_faculty/constants.dart';
import 'package:tdms_faculty/screens/faculty_dashboard.dart';

class AdviseeScreen extends StatefulWidget {
  const AdviseeScreen({super.key});

  @override
  State<AdviseeScreen> createState() => _AdviseeScreenState();
}

class _AdviseeScreenState extends State<AdviseeScreen> {
  @override
  void initState() {
    super.initState();
    _fetchMyAdvisees();
    _fetchStudentsIamPanel();
  }

  Future<String?> _getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('auth_token');
  }

  List<Map<String, dynamic>> myAdvisees = [];
  List<Map<String, dynamic>> myStudent = [];

  Future<void> _fetchMyAdvisees() async {
    final url = Uri.parse('$apiUrl/advisees');
    final token = await _getToken();
    final response = await http.get(
      url,
      headers: {
        'Accept': 'application/json',
        if (token != null) 'Authorization': 'Bearer $token',
      },
    );

    final Map<String, dynamic> responseBody = jsonDecode(response.body);

    if (response.statusCode == 200) {
      final List<dynamic> data = responseBody['data'];

      setState(() {
        myAdvisees = data.cast<Map<String, dynamic>>();
      });
    } else if (response.statusCode == 401 || response.statusCode == 404) {
      final errorMessage = responseBody['message'];
      showMessageSnackbar(context, errorMessage);
    } else {
      showMessageSnackbar(context, 'Something went wrong please try again.');
    }
  }

  Future<void> _fetchStudentsIamPanel() async {
    final url = Uri.parse('$apiUrl/my-student');
    final token = await _getToken();
    final response = await http.get(
      url,
      headers: {
        'Accept': 'application/json',
        if (token != null) 'Authorization': 'Bearer $token',
      },
    );

    final Map<String, dynamic> responseBody = jsonDecode(response.body);

    if (response.statusCode == 200) {
      final List<dynamic> data = responseBody['data'];

      setState(() {
        myStudent = data.cast<Map<String, dynamic>>();
      });
    } else if (response.statusCode == 401 || response.statusCode == 404) {
      final errorMessage = responseBody['message'];
      showMessageSnackbar(context, errorMessage);
    } else {
      showMessageSnackbar(context, 'Something went wrong please try again.');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(50),
        child: MyAppbar(
          title: 'My Advisees',
          showActions: true,
          withLeading: true,
          locationScreen: () {
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: (context) => FacultyDashboardScreen()),
            );
          },
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'My Advisees',
              style: GoogleFonts.inter(
                fontSize: 22,
                fontWeight: FontWeight.w600,
                color: Color(0xFF5E875E),
              ),
            ),
            Text(
              'A list of students under your academic guidance will appear here.',
              style: GoogleFonts.inter(color: Color(0xFF5E875E), fontSize: 12),
            ),
            SizedBox(height: 16),
            ...myAdvisees.asMap().entries.map((entry) {
              final index = entry.key;
              final advisee = entry.value;

              final adviseeName = advisee['student_name'] ?? '';
              final adviseeStudy = advisee['study_title'] ?? '';
              final adviseeStudyType = advisee['study_type'] ?? '';

              return Padding(
                padding: EdgeInsets.only(top: index == 0 ? 0 : 16.0),
                child: buildUserCard(
                  adviseeName,
                  adviseeStudy,
                  adviseeStudyType,
                  () {},
                ),
              );
            }),

            if (myAdvisees.isEmpty)
              Container(
                color: Color(0xFFE8F2E8),
                padding: EdgeInsets.all(12.0),
                width: MediaQuery.of(context).size.width,
                child: Text(
                  'Oppss, No advisees yet...',
                  style: GoogleFonts.inter(
                    fontSize: 16,
                    color: Color(0xFF5E875E),
                  ),
                ),
              ),
            SizedBox(height: 16),
            Text(
              'Students',
              style: GoogleFonts.inter(
                fontSize: 22,
                fontWeight: FontWeight.w700,
                color: Color(0xFF5E875E),
              ),
            ),
            Text(
              'Students assigned to you as a panel member will appear here.',
              style: GoogleFonts.inter(
                color: Color(0xFF5E875E).withOpacity(0.8),
                fontSize: 12,
                height: 1.4,
              ),
            ),
            SizedBox(height: 16),
            ...myStudent.asMap().entries.map((entry) {
              final index = entry.key;
              final advisee = entry.value;

              final adviseeName = advisee['name'] ?? '';
              final adviseeStudy = advisee['title'] ?? '';
              final adviseeStudyType = advisee['type'] ?? '';

              return Padding(
                padding: EdgeInsets.only(top: index == 0 ? 0 : 16.0),
                child: GestureDetector(
                  onTap: () {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: Text(
                            'Confirmation',
                            style: GoogleFonts.inter(
                              fontSize: 21.0,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF5E875E),
                            ),
                          ),
                          content: Text(
                            'Please ensure you already have the paper of this study submitted to you before evaluating.',
                            style: GoogleFonts.inter(
                              color: Color(0xFF5E875E),
                              fontSize: 13,
                            ),
                          ),
                          actions: <Widget>[
                            TextButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              child: Text(
                                'Cancel',
                                style: GoogleFonts.inter(
                                  color: Color(0xFF5E875E),
                                ),
                              ),
                            ),
                            ElevatedButton(
                              onPressed: () {},
                              style: ButtonStyle(
                                backgroundColor: MaterialStateProperty.all(
                                  Color(0xFF5E875E),
                                ),
                              ),
                              child: Text(
                                'Yes, I Confirm',
                                style: GoogleFonts.inter(color: Colors.white),
                              ),
                            ),
                          ],
                        );
                      },
                    );
                  },
                  child: buildUserCard(
                    adviseeName,
                    adviseeStudy,
                    adviseeStudyType,
                    () {},
                  ),
                ),
              );
            }),

            if (myStudent.isEmpty)
              Container(
                color: Color(0xFFE8F2E8),
                padding: EdgeInsets.all(12.0),
                width: MediaQuery.of(context).size.width,
                child: Text(
                  'No student included you as a panel...',
                  style: GoogleFonts.inter(
                    fontSize: 16,
                    color: Color(0xFF5E875E),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
