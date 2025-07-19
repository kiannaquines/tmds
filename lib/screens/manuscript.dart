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

class ManuscriptScreen extends StatefulWidget {
  const ManuscriptScreen({super.key});

  @override
  State<ManuscriptScreen> createState() => _ManuscriptScreenState();
}

class _ManuscriptScreenState extends State<ManuscriptScreen> {
  @override
  void initState() {
    super.initState();
    _fetchManuscript();
  }

  List<Map<String, dynamic>> manuscript = [];

  Future<void> _fetchManuscript() async {
    final url = Uri.parse('$apiUrl/academic/guidance/thesis/manuscript');
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
        manuscript = data.cast<Map<String, dynamic>>();
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
          title: 'Manuscript',
          showActions: true,
          withLeading: true,
          locationScreen: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Manuscript Papers',
              style: GoogleFonts.inter(
                fontSize: 22,
                fontWeight: FontWeight.w600,
                color: Color(0xFF5E875E),
              ),
            ),
            Text(
              'All newly submitted manuscripts awaiting your review will appear here.',
              style: GoogleFonts.inter(color: Color(0xFF5E875E), fontSize: 12),
            ),
            SizedBox(height: 16),
            ...manuscript.asMap().entries.map((entry) {
              final index = entry.key;
              final study = entry.value;
              final studyId = study['id'];
              final studyTitle = study['title'];
              final department = study['department'];
              final studyType = study['type'];

              final subtitle = '$department - $studyType';
              return Padding(
                padding: EdgeInsets.only(top: index == 0 ? 0 : 16.0),
                child: buildSubmissionCard(
                  studyTitle,
                  subtitle,
                  onTap: () {
                    showDialog(
                      context: context,
                      barrierDismissible:
                          true, // Allows tapping outside to dismiss
                      builder: (BuildContext context) {
                        return Dialog(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16.0),
                          ),
                          elevation: 0,
                          backgroundColor: Colors.transparent,
                          child: Container(
                            padding: const EdgeInsets.all(24),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(16),
                              boxShadow: [
                                BoxShadow(
                                  color: const Color(
                                    0xFF5E875E,
                                  ).withOpacity(0.1),
                                  blurRadius: 24,
                                  spreadRadius: 4,
                                ),
                              ],
                            ),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                // Header
                                Text(
                                  'Confirmation',
                                  style: GoogleFonts.inter(
                                    fontSize: 20,
                                    fontWeight: FontWeight.w600,
                                    color: const Color(0xFF5E875E),
                                    height: 1.3,
                                  ),
                                ),
                                const SizedBox(height: 12),
                                // Body text
                                Text(
                                  'Are you sure you want to evaluate this study?',
                                  style: GoogleFonts.inter(
                                    color: const Color(
                                      0xFF5E875E,
                                    ).withOpacity(0.8),
                                    fontSize: 14,
                                    height: 1.5,
                                  ),
                                ),
                                const SizedBox(height: 24),
                                // Buttons
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    // Cancel Button
                                    TextButton(
                                      onPressed: () => Navigator.pop(context),
                                      style: TextButton.styleFrom(
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: 16,
                                          vertical: 12,
                                        ),
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(
                                            8,
                                          ),
                                        ),
                                      ),
                                      child: Text(
                                        'Cancel',
                                        style: GoogleFonts.inter(
                                          color: const Color(
                                            0xFF5E875E,
                                          ).withOpacity(0.8),
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ),
                                    const SizedBox(width: 8),
                                    // Confirm Button
                                    ElevatedButton(
                                      onPressed: () {
                                        Navigator.pop(
                                          context,
                                        ); // Close dialog first
                                        Navigator.pushReplacement(
                                          context,
                                          PageRouteBuilder(
                                            pageBuilder:
                                                (
                                                  context,
                                                  animation,
                                                  secondaryAnimation,
                                                ) => FeedbackScreen(
                                                  studyId: studyId,
                                                  studyTitle: studyTitle,
                                                  studyType: studyType,
                                                ),
                                            transitionsBuilder: (
                                              context,
                                              animation,
                                              secondaryAnimation,
                                              child,
                                            ) {
                                              return FadeTransition(
                                                opacity: animation,
                                                child: child,
                                              );
                                            },
                                            transitionDuration: const Duration(
                                              milliseconds: 200,
                                            ),
                                          ),
                                        );
                                      },
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: const Color(
                                          0xFF5E875E,
                                        ),
                                        foregroundColor: Colors.white,
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: 20,
                                          vertical: 12,
                                        ),
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(
                                            8,
                                          ),
                                          side: BorderSide(
                                            color: const Color(
                                              0xFF5E875E,
                                            ).withOpacity(0.2),
                                            width: 1,
                                          ),
                                        ),
                                        elevation: 0,
                                        shadowColor: Colors.transparent,
                                      ),
                                      child: Text(
                                        'Evaluate',
                                        style: GoogleFonts.inter(
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    );
                  },
                ),
              );
            }),
            if (manuscript.isEmpty)
              buildEmptyState(
                'Oppss, No manuscript papers yet comeback later...',
              ),
          ],
        ),
      ),
    );
  }
}
