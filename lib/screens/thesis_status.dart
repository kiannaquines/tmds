import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tdms_faculty/components/my_appbar.dart';
import 'package:tdms_faculty/components/widgets.dart';
import 'package:tdms_faculty/constants.dart';
import 'package:tdms_faculty/screens/dashboard.dart';
import 'package:timeago/timeago.dart' as timeago;

class ThesisStatusScreen extends StatefulWidget {
  const ThesisStatusScreen({super.key, required this.studyId});

  final String studyId;

  @override
  State<ThesisStatusScreen> createState() => _ThesisStatusScreenState();
}

class _ThesisStatusScreenState extends State<ThesisStatusScreen> {
  @override
  void initState() {
    super.initState();
    _fetchStudyTimeLine();
  }

  List<Map<String, dynamic>> studyTimeLine = [];
  Future<String?> _getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('auth_token');
  }

  Future<void> _fetchStudyTimeLine() async {
    final String studyId = widget.studyId;
    final url = Uri.parse('$apiUrl/timeline/$studyId');
    final token = await _getToken();
    final response = await http.get(
      url,
      headers: {
        'Accept': 'application/json',
        if (token != null) 'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> responseBody = jsonDecode(response.body);
      final List<dynamic> data = responseBody['data'];

      setState(() {
        studyTimeLine = data.cast<Map<String, dynamic>>();
      });
    } else {
      showMessageSnackbar(context, 'Failed to fetch timeline data.');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(50),
        child: MyAppbar(
          title: 'Thesis Status',
          showActions: false,
          withLeading: true,
          locationScreen:
              () => Navigator.of(context).pushReplacement(
                MaterialPageRoute(builder: (context) => DashboardScreen()),
              ),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Study Progress Timeline',
              style: GoogleFonts.inter(
                fontSize: 22,
                fontWeight: FontWeight.w600,
                color: Color(0xFF5E875E),
              ),
            ),
            Text(
              'Track the progress and status updates of your study here.',
              style: GoogleFonts.inter(fontSize: 12, color: Color(0xFF5E875E)),
            ),

            SizedBox(height: 24),
            Expanded(
              child: ListView(
                children: [
                  ...studyTimeLine.asMap().entries.map((entry) {
                    final int index = entry.key;
                    final timeline = entry.value;

                    final String comment = timeline['comment'] ?? '';
                    final String checkBy = timeline['check_by'] ?? '';
                    final String createdAt = timeline['created_at'] ?? '';

                    DateTime createdDate =
                        DateTime.tryParse(createdAt) ?? DateTime.now();
                    String timeAgo = timeago.format(createdDate);

                    return Padding(
                      padding: EdgeInsets.only(top: index == 0 ? 0.0 : 12.0),
                      child: buildTimelineItem(
                        title: checkBy,
                        subtitle: comment,
                        timeAgo: timeAgo,
                      ),
                    );
                  }),
                ],
              ),
            ),
            SizedBox(height: 20),
            buildGreenButton(
              'Back to Home',
              () => Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => DashboardScreen()),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
