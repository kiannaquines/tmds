import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tdms_faculty/components/my_appbar.dart';
import 'package:tdms_faculty/components/widgets.dart';

class FeedbackScreen extends StatefulWidget {
  const FeedbackScreen({super.key, required this.studyId});

  final int studyId;
  @override
  State<FeedbackScreen> createState() => _FeedbackScreenState();
}

class _FeedbackScreenState extends State<FeedbackScreen> {
  final _feedbackController = TextEditingController();
  String? _selectedStatus;

  final List<String> _status = ['Revise', 'Approved'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(50.0),
        child: MyAppbar(
          title: 'Evaluation',
          showActions: true,
          withLeading: true,
          locationScreen: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      body: Padding(
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
              'Evaluate thesis here.',
              style: GoogleFonts.inter(color: Color(0xFF5E875E), fontSize: 12),
            ),
            SizedBox(height: 16),
            Text(
              'Thesis',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: Color(0xFF5E875E),
              ),
            ),
            SizedBox(height: 16),
            Container(
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 4,
                    offset: Offset(0, 2),
                  ),
                ],
              ),
              child: Row(
                children: [
                  Container(
                    padding: EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: Color(0xFFE8F2E8),
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Icon(
                      Icons.description,
                      color: Color(0xFF5E875E),
                      size: 24.0,
                    ),
                  ),
                  SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Crowd Monitoring System',
                          style: GoogleFonts.inter(
                            fontWeight: FontWeight.w600,
                            color: Color(0xFF5E875E),
                            fontSize: 16,
                          ),
                        ),
                        SizedBox(height: 4),
                        Text(
                          'Submitted on 12/12/2023',
                          style: TextStyle(
                            color: Color(0xFF5E875E),
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 32),
            Text(
              'Evaluation Comment',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: Color(0xFF5E875E),
              ),
            ),
            SizedBox(height: 16),
            Expanded(
              child: buildTextField(
                'Enter evaluation comment here...',
                _feedbackController,
              ),
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
            buildGreenButton('Submit Evaluation', () {}),
          ],
        ),
      ),
    );
  }
}
