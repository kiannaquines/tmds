import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tdms_faculty/components/my_appbar.dart';
import 'package:tdms_faculty/components/widgets.dart';
import 'package:tdms_faculty/screens/faculty_dashboard.dart';

class ManuscriptScreen extends StatefulWidget {
  const ManuscriptScreen({super.key});

  @override
  State<ManuscriptScreen> createState() => _ManuscriptScreenState();
}

class _ManuscriptScreenState extends State<ManuscriptScreen> {
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
            buildSubmissionCard(
              'Crowd Monitoring System...',
              'Submitted this day',
              () {},
            ),
            SizedBox(height: 12),
            buildSubmissionCard(
              'Thesis Management...',
              'Submitted this day',
              () {},
            ),
            SizedBox(height: 12),
            buildSubmissionCard(
              'Financial Management...',
              'Submitted this day',
              () {},
            ),
            SizedBox(height: 12),
            buildSubmissionCard(
              'Feed Formulation System',
              'Submitted this day',
              () {},
            ),
            SizedBox(height: 12),
            buildSubmissionCard(
              'Library Management System',
              'Submitted this week',
              () {},
            ),
            SizedBox(height: 12),
            buildSubmissionCard(
              'Equipment Management...',
              'Submitted this week',
              () {},
            ),
            SizedBox(height: 12),
            buildSubmissionCard(
              'Equipment Management...',
              'Submitted this week',
              () {},
            ),
            SizedBox(height: 12),
            buildSubmissionCard(
              'Equipment Management...',
              'Submitted this week',
              () {},
            ),
            SizedBox(height: 12),
            buildSubmissionCard(
              'Equipment Management...',
              'Submitted this week',
              () {},
            ),
            SizedBox(height: 12),
            buildSubmissionCard(
              'Equipment Management...',
              'Submitted this week',
              () {},
            ),
            SizedBox(height: 12),
            buildSubmissionCard(
              'Equipment Management...',
              'Submitted this week',
              () {},
            ),
            SizedBox(height: 12),
            buildSubmissionCard(
              'Equipment Management...',
              'Submitted this week',
              () {},
            ),
            SizedBox(height: 12),
            buildSubmissionCard(
              'Equipment Management...',
              'Submitted this week',
              () {},
            ),
            SizedBox(height: 12),
            buildSubmissionCard(
              'Equipment Management...',
              'Submitted this week',
              () {},
            ),
            SizedBox(height: 12),
            buildSubmissionCard(
              'Equipment Management...',
              'Submitted this week',
              () {},
            ),
          ],
        ),
      ),
    );
  }
}
