import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tdms_faculty/components/my_appbar.dart';
import 'package:tdms_faculty/components/utils.dart';
import 'package:tdms_faculty/components/widgets.dart';
import 'package:tdms_faculty/constants.dart';
import 'package:http/http.dart' as http;
import 'package:tdms_faculty/screens/faculty_dashboard.dart';

class FeedbackScreen extends StatefulWidget {
  const FeedbackScreen({
    super.key,
    required this.studyId,
    required this.studyTitle,
    required this.studyType,
  });

  final int studyId;
  final String studyTitle;
  final String studyType;

  @override
  State<FeedbackScreen> createState() => _FeedbackScreenState();
}

class _FeedbackScreenState extends State<FeedbackScreen> {
  @override
  void initState() {
    super.initState();
  }

  final _feedbackController = TextEditingController();
  String? _selectedStatus;
  bool isSubmitting = false;

  final List<String> _status = ['Revise', 'Approved'];

  Future<void> feedBack() async {
    setState(() {
      isSubmitting = true;
    });

    final token = await getToken();
    final feedback = _feedbackController.text.trim();
    final status = _selectedStatus;

    final body = jsonEncode({
      "study_id": widget.studyId,
      "comment": feedback,
      "status": status,
    });

    final headers = {
      'Accept': 'application/json',
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    };

    final url = Uri.parse('$apiUrl/thesis-progress');
    final response = await http.post(url, headers: headers, body: body);
    final responseBody = jsonDecode(response.body);

    if (response.statusCode == 201) {
      showMessageSnackbar(context, responseBody['message'], isError: false);

      setState(() {
        isSubmitting = true;
      });

      _feedbackController.clear();
      _selectedStatus = null;
    } else {
      showMessageSnackbar(context, responseBody['message'], isError: true);

      setState(() {
        isSubmitting = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(50.0),
        child: MyAppbar(
          title: 'Evaluation',
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
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Evaluate Thesis',
                style: GoogleFonts.inter(
                  fontSize: 22,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF5E875E),
                ),
              ),
              Text(
                'Use this section to assess the thesis.',
                style: GoogleFonts.inter(
                  color: Color(0xFF5E875E),
                  fontSize: 12,
                ),
              ),
              SizedBox(height: 16),
              buildTextField(
                'Enter evaluation comment here...',
                maxLines: 5,
                _feedbackController,
              ),
              SizedBox(height: 16),
              buildDropdown('Status', _selectedStatus, _status, (
                String? newValue,
              ) {
                setState(() {
                  _selectedStatus = newValue;
                });
              }),
              SizedBox(height: 32),
              buildGreenButton(
                isSubmitting ? 'Please wait...' : 'Submit Evaluation',
                () async {
                  await feedBack();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
