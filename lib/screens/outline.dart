import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:tdms_faculty/components/my_appbar.dart';
import 'package:tdms_faculty/components/utils.dart';
import 'package:tdms_faculty/components/widgets.dart';
import 'package:tdms_faculty/constants.dart';
import 'package:tdms_faculty/screens/faculty_dashboard.dart';
import 'package:tdms_faculty/screens/feedback.dart';

class OutlineScreen extends StatefulWidget {
  const OutlineScreen({super.key});

  @override
  State<OutlineScreen> createState() => _OutlineScreenState();
}

class _OutlineScreenState extends State<OutlineScreen> {
  @override
  void initState() {
    super.initState();
    _fetchOutline();
  }

  List<Map<String, dynamic>> outline = [];

  Future<void> _fetchOutline() async {
    final url = Uri.parse('$apiUrl/academic/guidance/thesis/outline');
    final token = await getToken();

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
        outline = data.cast<Map<String, dynamic>>();
      });
    } else {
      showMessageSnackbar(context, 'Failed to fetch studies submissions.');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(50),
        child: MyAppbar(
          title: 'Outline',
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
              'Outline Papers',
              style: GoogleFonts.inter(
                fontSize: 22,
                fontWeight: FontWeight.w600,
                color: Color(0xFF5E875E),
              ),
            ),
            Text(
              'All newly submitted outlines awaiting your review will appear here.',
              style: GoogleFonts.inter(color: Color(0xFF5E875E), fontSize: 12),
            ),
            SizedBox(height: 16),
            ...outline.asMap().entries.map((entry) {
              final index = entry.key;
              final study = entry.value;
              final title = study['title'];
              final department = study['department'];
              final type = study['type'];

              final subtitle = '$department - $type';
              return Padding(
                padding: EdgeInsets.only(top: index == 0 ? 0 : 16.0),
                child: buildSubmissionCard(title, subtitle, () {
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
                          'Are you sure you want to evaluate this study?',
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
                            onPressed: () {
                              Navigator.of(context).pushReplacement(
                                MaterialPageRoute(
                                  builder:
                                      (context) =>
                                          const FeedbackScreen(studyId: 1),
                                ),
                              );
                            },
                            style: ButtonStyle(
                              foregroundColor: MaterialStateProperty.all(
                                const Color(0xFFFFFFFF),
                              ),
                              backgroundColor: MaterialStateProperty.all(
                                const Color(0xFF5E875E),
                              ),
                            ),
                            child: Text(
                              'Confirm',
                              style: GoogleFonts.inter(
                                color: Color(0xFFFFFFFF),
                              ),
                            ),
                          ),
                        ],
                      );
                    },
                  );
                }),
              );
            }),
          ],
        ),
      ),
    );
  }
}
