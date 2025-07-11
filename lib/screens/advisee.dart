import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tdms_faculty/components/my_appbar.dart';
import 'package:tdms_faculty/components/widgets.dart';
import 'package:tdms_faculty/screens/faculty_dashboard.dart';

class AdviseeScreen extends StatefulWidget {
  const AdviseeScreen({super.key});

  @override
  State<AdviseeScreen> createState() => _AdviseeScreenState();
}

class _AdviseeScreenState extends State<AdviseeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(50),
        child: MyAppbar(
          title: 'My Advisees',
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
              'My Advisees',
              style: GoogleFonts.inter(
                fontSize: 22,
                fontWeight: FontWeight.w600,
                color: Color(0xFF5E875E),
              ),
            ),
            Text(
              'A list of students under your academic guidance will appear here.',
              style: GoogleFonts.inter(color: Color(0xFF5E875E), fontSize: 12),
            ),
            SizedBox(height: 16),
            buildUserCard(
              'Kian Jearard G. Naquines',
              'Submitted this day',
              () {},
            ),
            SizedBox(height: 12),
            buildUserCard('Abegail T. Tenerife', 'Submitted this day', () {}),
            SizedBox(height: 12),
            buildUserCard('Jennifer Escote', 'Submitted this day', () {}),
            SizedBox(height: 12),
            buildUserCard('Irish Mae Bianson', 'Submitted this day', () {}),
            SizedBox(height: 12),
            buildUserCard('Arden Petras', 'Submitted this week', () {}),
          ],
        ),
      ),
    );
  }
}
