import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tdms_faculty/components/my_appbar.dart';
import 'package:tdms_faculty/constants.dart';
import 'package:tdms_faculty/components/widgets.dart';
import 'package:tdms_faculty/components/utils.dart';
import 'package:http/http.dart' as http;
import 'package:tdms_faculty/screens/dashboard.dart';

class MyAdvisers extends StatefulWidget {
  const MyAdvisers({super.key});

  @override
  State<MyAdvisers> createState() => _MyAdvisersState();
}

class _MyAdvisersState extends State<MyAdvisers> {
  @override
  void initState() {
    super.initState();
    _fetchMyAdvisers();
    _fetchMyPanels();
  }

  List<Map<String, dynamic>> myAdvisers = [];
  List<Map<String, dynamic>> myPanels = [];

  Future<void> _fetchMyAdvisers() async {
    final token = await getToken();
    final url = Uri.parse('$apiUrl/advisers');
    final headers = {
      'Accept': 'application/json',
      'Content-Type': 'application/json',
      if (token != null) 'Authorization': 'Bearer $token',
    };
    final response = await http.get(url, headers: headers);
    final responseBody = jsonDecode(response.body);

    if (response.statusCode == 200) {
      final List<dynamic> data = responseBody['data'];

      setState(() {
        myAdvisers = data.cast<Map<String, dynamic>>();
      });
    } else {
      showMessageSnackbar(context, responseBody['message']);
    }
  }

  Future<void> _fetchMyPanels() async {
    final token = await getToken();
    final url = Uri.parse('$apiUrl/panels');
    final headers = {
      'Accept': 'application/json',
      'Content-Type': 'application/json',
      if (token != null) 'Authorization': 'Bearer $token',
    };
    final response = await http.get(url, headers: headers);
    final responseBody = jsonDecode(response.body);

    if (response.statusCode == 200) {
      final List<dynamic> data = responseBody['data'];
      setState(() {
        myPanels = data.cast<Map<String, dynamic>>();
      });
    } else {
      showMessageSnackbar(context, responseBody['message']);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(50.0),
        child: MyAppbar(
          title: 'Committee',
          showActions: true,
          withLeading: true,
          locationScreen: () {
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: (context) => DashboardScreen()),
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
              'My Adviser',
              style: GoogleFonts.inter(
                fontSize: 22,
                fontWeight: FontWeight.w600,
                color: Color(0xFF5E875E),
              ),
            ),
            Text(
              'You\'r academic adviser will appear here.',
              style: GoogleFonts.inter(color: Color(0xFF5E875E), fontSize: 12),
            ),

            SizedBox(height: 16),
            ...myAdvisers.asMap().entries.map((entry) {
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

            if (myAdvisers.isEmpty)
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

            Text(
              'My Panels',
              style: GoogleFonts.inter(
                fontSize: 22,
                fontWeight: FontWeight.w600,
                color: Color(0xFF5E875E),
              ),
            ),
            Text(
              'You\'r academic panels will appear here.',
              style: GoogleFonts.inter(color: Color(0xFF5E875E), fontSize: 12),
            ),
            SizedBox(height: 16),
            ...myPanels.asMap().entries.map((entry) {
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

            if (myPanels.isEmpty)
              Container(
                color: Color(0xFFE8F2E8),
                padding: EdgeInsets.all(12.0),
                width: MediaQuery.of(context).size.width,
                child: Text(
                  'Oppss, No panels yet...',
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
