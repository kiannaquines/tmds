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

    if (response.statusCode == 200) {
      final Map<String, dynamic> responseBody = jsonDecode(response.body);
      final data = responseBody['data'];

      if (mounted) {
        setState(() {
          myAdvisers = [data];
        });
      }
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
      if (mounted) {
        setState(() {
          myPanels = data.cast<Map<String, dynamic>>();
        });
      }
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

              final adviserName = advisee['adviser_name'] ?? '';
              final adviserEmail = advisee['adviser_email'] ?? '';
              final adviserRole = advisee['role'] ?? '';
              return Padding(
                padding: EdgeInsets.only(top: index == 0 ? 0 : 16.0),
                child: buildUserCard(
                  adviserName,
                  adviserEmail,
                  adviserRole,
                  () {},
                ),
              );
            }),

            if (myAdvisers.isEmpty)
              buildEmptyState('Oppss, No advisees yet comeback later...'),
            SizedBox(height: 16),
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
              final panel = entry.value;

              final panelName = panel['panel_name'] ?? '';
              final panelEmail = panel['panel_email'] ?? '';
              final panelStudyType = panel['study_type'] ?? '';
              final detailedStatus = 'Your $panelStudyType panel.';
              return Padding(
                padding: EdgeInsets.only(top: index == 0 ? 0 : 16.0),
                child: buildUserCard(
                  panelName,
                  panelEmail,
                  detailedStatus,
                  () {},
                ),
              );
            }),

            if (myPanels.isEmpty)
              buildEmptyState('Oppss, No panels yet comeback later...'),
          ],
        ),
      ),
    );
  }
}
