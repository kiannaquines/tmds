import 'package:flutter/material.dart';
import 'package:tdms_faculty/components/my_appbar.dart';
import 'package:tdms_faculty/components/widgets.dart';
import 'package:tdms_faculty/screens/dashboard.dart';

class MySubmissionScreen extends StatefulWidget {
  const MySubmissionScreen({super.key});

  @override
  State<MySubmissionScreen> createState() => _MySubmissionScreenState();
}

class _MySubmissionScreenState extends State<MySubmissionScreen> {
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
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.w600,
                color: Color(0xFF5E875E),
              ),
            ),
            SizedBox(height: 16),
            buildSubmissionCard(
              'Submit Thesis Outline',
              'Submitted last week',
              () {
                Navigator.pushNamed(context, '/upload-thesis');
              },
            ),
            SizedBox(height: 12),
            buildSubmissionCard(
              'Submitted Thesis Manuscript',
              'Submitted last month',
              () {
                Navigator.pushNamed(context, '/thesis-status');
              },
            ),
          ],
        ),
      ),
    );
  }
}
