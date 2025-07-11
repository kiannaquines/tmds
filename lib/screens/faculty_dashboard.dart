import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tdms_faculty/components/my_appbar.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:tdms_faculty/components/widgets.dart';
import 'package:tdms_faculty/screens/advisee.dart';
import 'package:tdms_faculty/screens/manuscript.dart';
import 'package:tdms_faculty/screens/outline.dart';
import 'package:tdms_faculty/components/utils.dart';

class FacultyDashboardScreen extends StatefulWidget {
  const FacultyDashboardScreen({super.key});

  @override
  State<FacultyDashboardScreen> createState() => _FacultyDashboardScreenState();
}

class _FacultyDashboardScreenState extends State<FacultyDashboardScreen> {
  int _selectedIndex = 0;
  String? userName;
  String? userRole;

  @override
  void initState() {
    super.initState();
    _loadUserName();
    _loadUserRole();
  }

  Future<void> _loadUserName() async {
    final name = await fetchUserName();
    setState(() {
      userName = name;
    });
  }

  Future<void> _loadUserRole() async {
    final role = await fetchUserRole();
    setState(() {
      userRole = role;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(50),
        child: MyAppbar(title: 'Faculty Dashboard', showActions: true),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.all(16),
              margin: const EdgeInsets.only(bottom: 16),
              decoration: BoxDecoration(
                color: const Color(0xFFE8F5E9), // Light green background
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 8,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              width: MediaQuery.of(context).size.width,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Hi! ${userName ?? 'Guest'},',
                    style: GoogleFonts.inter(
                      fontSize: 22,
                      fontWeight: FontWeight.w600,
                      color: const Color(0xFF5E875E),
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    userRole ?? 'Professor',
                    style: GoogleFonts.inter(
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                      color: const Color(0xFF5E875E),
                    ),
                  ),
                ],
              ),
            ),
            Text(
              'New Arrived Paper',
              style: GoogleFonts.inter(
                fontSize: 22,
                fontWeight: FontWeight.w600,
                color: Color(0xFF5E875E),
              ),
            ),
            Text(
              'All newly submitted papers pending your review will appear here.',
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
                MaterialPageRoute(builder: (_) => OutlineScreen()),
              );
              break;
            case 1:
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (_) => AdviseeScreen()),
              );
              break;
            case 2:
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (_) => ManuscriptScreen()),
              );
              break;
            case 3:
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (_) => OutlineScreen()),
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
            icon: Icon(LucideIcons.users),
            label: 'Advisee',
          ),
          BottomNavigationBarItem(
            icon: Icon(LucideIcons.file),
            label: 'Manuscript',
          ),
          BottomNavigationBarItem(
            icon: Icon(LucideIcons.file),
            label: 'Outline',
          ),
        ],
      ),
    );
  }
}
