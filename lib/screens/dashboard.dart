import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:tdms_faculty/components/my_appbar.dart';
import 'package:tdms_faculty/components/widgets.dart';
import 'package:tdms_faculty/screens/my_submissions.dart';
import 'package:tdms_faculty/screens/upload_thesis.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  int _selectedIndex = 0;

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
                Navigator.pushNamed(context, '/thesis-status');
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
            SizedBox(height: 32),
            Text(
              'Notifications',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.w600,
                color: Color(0xFF5E875E),
              ),
            ),
            SizedBox(height: 16),
            buildNotificationCard(
              'Approved by Elizabeth',
              'Your document has been approved',
            ),
            SizedBox(height: 12),
            buildNotificationCard(
              'Approved by Nor-aine',
              'Your document has been approved',
            ),
            SizedBox(height: 12),
            buildNotificationCard(
              'Approved by Ralph',
              'Your document has been approved',
            ),
            SizedBox(height: 12),
            buildNotificationCard(
              'Approved by Ryan',
              'Your document has been approved',
            ),
            SizedBox(height: 12),
            buildNotificationCard(
              'Approved by Catherine',
              'Your document has been approved',
            ),
            SizedBox(height: 12),
            buildNotificationCard(
              'Approved by Sherly',
              'Your document has been approved',
            ),
            SizedBox(height: 12),
            buildNotificationCard(
              'Ready for RDO',
              'Ready your document for RDO',
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
