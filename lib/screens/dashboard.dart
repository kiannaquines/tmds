import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tdms_faculty/components/my_appbar.dart';
import 'package:tdms_faculty/components/widgets.dart';
import 'package:tdms_faculty/constants.dart';
import 'package:tdms_faculty/screens/my_submissions.dart';
import 'package:tdms_faculty/screens/thesis_status.dart';
import 'package:tdms_faculty/screens/upload_thesis.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  @override
  void initState() {
    super.initState();
    _fetchMySubmissions();
    _fetchNotification();
  }

  int _selectedIndex = 0;

  Future<String?> _getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('auth_token');
  }

  List<Map<String, dynamic>> mySubmissions = [];
  List<Map<String, dynamic>> myNotification = [];

  Future<void> _fetchMySubmissions() async {
    final url = Uri.parse('$apiUrl/submissions');
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
      final Map<String, dynamic> responseBody = jsonDecode(response.body);
      final List<dynamic> data = responseBody['data'];

      setState(() {
        mySubmissions = data.cast<Map<String, dynamic>>();
      });
    } else {
      showMessageSnackbar(context, 'Failed to fetch submissions.');
    }
  }

  Future<void> _fetchNotification() async {
    final url = Uri.parse('$apiUrl/notification');
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
      final Map<String, dynamic> responseBody = jsonDecode(response.body);
      final List<dynamic> data = responseBody['data'];

      setState(() {
        myNotification = data.cast<Map<String, dynamic>>();
      });
    } else {
      showMessageSnackbar(context, 'Failed to fetch notifications.');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(50),
        child: MyAppbar(title: 'Dashboard', showActions: true),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'My Submissions',
              style: GoogleFonts.inter(
                fontSize: 22,
                fontWeight: FontWeight.w600,
                color: Color(0xFF5E875E),
              ),
            ),
            Text(
              'All your submitted works will appear here.',
              style: GoogleFonts.inter(color: Color(0xFF5E875E), fontSize: 12),
            ),
            SizedBox(height: 16),
            ...mySubmissions.map((submission) {
              final String title = submission['title'] ?? 'Untitled Thesis';
              final String type = submission['type'] ?? '';
              final String createdAt = submission['created_at'] ?? '';

              final String subtitle =
                  'Submitted on ${createdAt.split("T").first}';

              return Padding(
                padding: const EdgeInsets.only(bottom: 12.0),
                child: buildSubmissionCard('$type: $title', subtitle, () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => ThesisStatusScreen(),
                    ),
                  );
                }),
              );
            }),

            if (mySubmissions.isEmpty)
              Container(
                color: Color(0xFFE8F2E8),
                padding: EdgeInsets.all(12.0),
                width: MediaQuery.of(context).size.width,
                child: Text(
                  'Oppss, No submissions yet...',
                  style: GoogleFonts.inter(
                    fontSize: 16,
                    color: Color(0xFF5E875E),
                  ),
                ),
              ),
            SizedBox(height: 32),
            Text(
              'Notifications',
              style: GoogleFonts.inter(
                fontSize: 22,
                fontWeight: FontWeight.w600,
                color: Color(0xFF5E875E),
              ),
            ),
            Text(
              'Stay updated with your latest notifications here.',
              style: GoogleFonts.inter(fontSize: 12, color: Color(0xFF5E875E)),
            ),
            SizedBox(height: 16),
            ...myNotification.asMap().entries.map((entry) {
              final int index = entry.key;
              final notification = entry.value;

              final String status = notification['status'] ?? '';
              final String comment = notification['comment'] ?? '';
              final String studyType = notification['study_type'] ?? '';
              final String title = notification['study_title'] ?? '';

              return Padding(
                padding: EdgeInsets.only(top: index == 0 ? 0.0 : 12.0),
                child: buildNotificationCard(
                  '$studyType - $title ($status)',
                  comment,
                ),
              );
            }),

            if (myNotification.isEmpty)
              Container(
                color: Color(0xFFE8F2E8),
                padding: EdgeInsets.all(12.0),
                width: MediaQuery.of(context).size.width,
                child: Text(
                  'Oppss, No notification yet...',
                  style: GoogleFonts.inter(
                    fontSize: 16,
                    color: Color(0xFF5E875E),
                  ),
                ),
              ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: (index) {
          if (_selectedIndex == index) return;

          setState(() {
            _selectedIndex = index;
          });

          switch (index) {
            case 0:
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (_) => DashboardScreen()),
              );
              break;
            case 1:
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (_) => MySubmissionScreen()),
              );
              break;
            case 2:
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (_) => UploadThesisScreen()),
              );
              break;
          }
        },
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Color(0xFF5E875E),
        unselectedItemColor: Color(0xFF5E875E),
        items: const [
          BottomNavigationBarItem(
            icon: Icon(LucideIcons.house),
            label: 'Dashboard',
          ),
          BottomNavigationBarItem(
            icon: Icon(LucideIcons.fileArchive),
            label: 'Submissions',
          ),
          BottomNavigationBarItem(
            icon: Icon(LucideIcons.file),
            label: 'Submit',
          ),
        ],
      ),
    );
  }
}
