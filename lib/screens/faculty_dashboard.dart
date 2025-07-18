import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:tdms_faculty/components/my_appbar.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:tdms_faculty/components/widgets.dart';
import 'package:tdms_faculty/constants.dart';
import 'package:tdms_faculty/screens/advisee.dart';
import 'package:tdms_faculty/screens/feedback.dart';
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
    _fetchPendingStudies();
    _fetchInProgressStudies();
    _fetchApprovedtudies();
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

  List<Map<String, dynamic>> pendingStudies = [];
  List<Map<String, dynamic>> inProgressStudies = [];
  List<Map<String, dynamic>> approvedStudies = [];

  Future<void> _fetchPendingStudies() async {
    final url = Uri.parse('$apiUrl/pending');
    final token = await getToken();

    final response = await http.get(
      url,
      headers: {
        'Accept': 'application/json',
        'Content-Type': 'application/json',
        if (token != null) 'Authorization': 'Bearer $token',
      },
    );

    final Map<String, dynamic> responseBody = jsonDecode(response.body);
    if (response.statusCode == 200) {
      final List<dynamic> data = responseBody['data'];

      setState(() {
        pendingStudies = data.cast<Map<String, dynamic>>();
      });
    } else {
      showMessageSnackbar(context, responseBody['message']);
    }
  }

  Future<void> _fetchInProgressStudies() async {
    final url = Uri.parse('$apiUrl/in-progress');
    final token = await getToken();

    final response = await http.get(
      url,
      headers: {
        'Accept': 'application/json',
        'Content-Type': 'application/json',
        if (token != null) 'Authorization': 'Bearer $token',
      },
    );

    final Map<String, dynamic> responseBody = jsonDecode(response.body);
    if (response.statusCode == 200) {
      final List<dynamic> data = responseBody['data'];

      setState(() {
        inProgressStudies = data.cast<Map<String, dynamic>>();
      });
    } else {
      showMessageSnackbar(context, responseBody['message']);
    }
  }

  Future<void> _fetchApprovedtudies() async {
    final url = Uri.parse('$apiUrl/approved');
    final token = await getToken();

    final response = await http.get(
      url,
      headers: {
        'Accept': 'application/json',
        'Content-Type': 'application/json',
        if (token != null) 'Authorization': 'Bearer $token',
      },
    );

    final Map<String, dynamic> responseBody = jsonDecode(response.body);
    if (response.statusCode == 200) {
      final List<dynamic> data = responseBody['data'];

      setState(() {
        approvedStudies = data.cast<Map<String, dynamic>>();
      });
    } else {
      showMessageSnackbar(context, responseBody['message']);
    }
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(50),
          child: MyAppbar(title: 'Faculty Dashboard', showActions: true),
        ),
        body: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
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
                style: GoogleFonts.inter(
                  color: Color(0xFF5E875E),
                  fontSize: 12,
                ),
              ),
              SizedBox(height: 16),

              Container(
                decoration: BoxDecoration(
                  color: Color(0xFFFFFFFF),
                  borderRadius: BorderRadius.circular(12.0),
                ),
                height: 48,
                width: MediaQuery.of(context).size.width,
                child: TabBar(
                  indicator: BoxDecoration(
                    color: Color(0xFF5E875E),
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                  dividerColor: Colors.transparent,
                  indicatorSize: TabBarIndicatorSize.tab,
                  labelColor: Colors.white,
                  unselectedLabelColor: Color(0xFF5E875E),
                  tabs: const [
                    Tab(icon: Icon(LucideIcons.layoutList)),
                    Tab(icon: Icon(LucideIcons.notebookPen)),
                    Tab(icon: Icon(LucideIcons.listCheck)),
                  ],
                ),
              ),

              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(top: 16.0),
                  child: TabBarView(
                    children: [
                      // Tab 1: Pending
                      pendingStudies.isEmpty
                          ? buildEmptyState(
                            'No pending studies to review.\nAll caught up!',
                          )
                          : ListView.builder(
                            itemCount: pendingStudies.length,
                            itemBuilder: (context, index) {
                              final study = pendingStudies[index];
                              final studyId = study['study']['id'];
                              final title = study['study']['title'];
                              final department = study['study']['department'];
                              final type = study['study']['type'];
                              final subtitle = '$department - $type';

                              return Padding(
                                padding: EdgeInsets.only(
                                  top: index == 0 ? 0 : 16.0,
                                ),
                                child: buildSubmissionCard(
                                  title,
                                  subtitle,
                                  null,
                                  () {
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
                                            'Please ensure you already have the paper of this study submitted to you before evaluating.',
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
                                                Navigator.of(
                                                  context,
                                                ).pushReplacement(
                                                  MaterialPageRoute(
                                                    builder:
                                                        (context) =>
                                                            FeedbackScreen(
                                                              studyId: studyId,
                                                              studyTitle: title,
                                                              studyType: type,
                                                            ),
                                                  ),
                                                );
                                              },
                                              style: ButtonStyle(
                                                backgroundColor:
                                                    MaterialStateProperty.all(
                                                      Color(0xFF5E875E),
                                                    ),
                                              ),
                                              child: Text(
                                                'Yes, I Confirm',
                                                style: GoogleFonts.inter(
                                                  color: Colors.white,
                                                ),
                                              ),
                                            ),
                                          ],
                                        );
                                      },
                                    );
                                  },
                                ),
                              );
                            },
                          ),

                      // Tab 2: In Progress
                      inProgressStudies.isEmpty
                          ? buildEmptyState(
                            'No studies in progress.\nStart reviewing pending studies!',
                          )
                          : ListView.builder(
                            itemCount: inProgressStudies.length,
                            itemBuilder: (context, index) {
                              final study = inProgressStudies[index];
                              final studyId = study['study']['id'];
                              final title = study['study']['title'];
                              final department = study['study']['department'];
                              final type = study['study']['type'];
                              final subtitle = '$department - $type';

                              return Padding(
                                padding: EdgeInsets.only(
                                  top: index == 0 ? 0 : 16.0,
                                ),
                                child: buildSubmissionCard(
                                  title,
                                  subtitle,
                                  null,
                                  () {
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
                                            'Please ensure you already have the paper of this study submitted to you before evaluating.',
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
                                                Navigator.of(
                                                  context,
                                                ).pushReplacement(
                                                  MaterialPageRoute(
                                                    builder:
                                                        (context) =>
                                                            FeedbackScreen(
                                                              studyId: studyId,
                                                              studyTitle: title,
                                                              studyType: type,
                                                            ),
                                                  ),
                                                );
                                              },
                                              style: ButtonStyle(
                                                backgroundColor:
                                                    MaterialStateProperty.all(
                                                      Color(0xFF5E875E),
                                                    ),
                                              ),
                                              child: Text(
                                                'Yes, I Confirm',
                                                style: GoogleFonts.inter(
                                                  color: Colors.white,
                                                ),
                                              ),
                                            ),
                                          ],
                                        );
                                      },
                                    );
                                  },
                                ),
                              );
                            },
                          ),

                      // Tab 3: Approved
                      approvedStudies.isEmpty
                          ? buildEmptyState(
                            'No approved studies yet.\nComplete your reviews to see them here!',
                          )
                          : ListView.builder(
                            itemCount: approvedStudies.length,
                            itemBuilder: (context, index) {
                              final study = approvedStudies[index];
                              final studyId = study['study']['id'];
                              final title = study['study']['title'];
                              final department = study['study']['department'];
                              final type = study['study']['type'];
                              final subtitle = '$department - $type';

                              return Padding(
                                padding: EdgeInsets.only(
                                  top: index == 0 ? 0 : 16.0,
                                ),
                                child: buildSubmissionCard(
                                  title,
                                  subtitle,
                                  null,
                                  () {
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
                                            'Please ensure you already have the paper of this study submitted to you before evaluating.',
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
                                                Navigator.of(
                                                  context,
                                                ).pushReplacement(
                                                  MaterialPageRoute(
                                                    builder:
                                                        (context) =>
                                                            FeedbackScreen(
                                                              studyId: studyId,
                                                              studyTitle: title,
                                                              studyType: type,
                                                            ),
                                                  ),
                                                );
                                              },
                                              style: ButtonStyle(
                                                backgroundColor:
                                                    MaterialStateProperty.all(
                                                      Color(0xFF5E875E),
                                                    ),
                                              ),
                                              child: Text(
                                                'Yes, I Confirm',
                                                style: GoogleFonts.inter(
                                                  color: Colors.white,
                                                ),
                                              ),
                                            ),
                                          ],
                                        );
                                      },
                                    );
                                  },
                                ),
                              );
                            },
                          ),
                    ],
                  ),
                ),
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
              label: 'Advisee/Committe',
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
      ),
    );
  }
}
