import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tdms_faculty/components/my_appbar.dart';
import 'package:tdms_faculty/components/widgets.dart';
import 'package:tdms_faculty/screens/dashboard.dart';
import 'package:tdms_faculty/screens/thesis_status.dart';
import 'package:tdms_faculty/constants.dart';
import 'package:http/http.dart' as http;

class MySubmissionScreen extends StatefulWidget {
  const MySubmissionScreen({super.key});

  @override
  State<MySubmissionScreen> createState() => _MySubmissionScreenState();
}

class _MySubmissionScreenState extends State<MySubmissionScreen> {
  @override
  void initState() {
    super.initState();
    _fetchMySubmissions();
  }

  Future<String?> _getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('auth_token');
  }

  List<Map<String, dynamic>> mySubmissions = [];

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(50),
        child: MyAppbar(
          title: 'My Submissions',
          showActions: true,
          locationScreen:
              () => Navigator.of(context).pushReplacement(
                MaterialPageRoute(builder: (context) => DashboardScreen()),
              ),
          withLeading: true,
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'My Submission',
              style: GoogleFonts.inter(
                fontSize: 22,
                fontWeight: FontWeight.w600,
                color: Color(0xFF5E875E),
              ),
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
            }).toList(),

            if (mySubmissions.isEmpty)
              Text(
                'No submissions yet.',
                style: GoogleFonts.inter(fontSize: 16, color: Colors.grey),
              ),
          ],
        ),
      ),
    );
  }
}
