import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:tdms_faculty/components/my_appbar.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:tdms_faculty/components/widgets.dart';
import 'package:tdms_faculty/constants.dart';
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
    _fetchPendingStudies();
    _fetchInProgressStudies();
    _fetchApprovedtudies();
  }

  @override
  void dispose() {
    super.dispose();
  }

  Future<void> _loadUserName() async {
    final name = await fetchUserName();
    if (mounted) {
      setState(() => userName = name);
    }
  }

  Future<void> _loadUserRole() async {
    final role = await fetchUserRole();
    if (mounted) {
      setState(() => userRole = role);
    }
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

    if (response.statusCode == 200) {
      final Map<String, dynamic> responseBody = jsonDecode(response.body);
      final List<dynamic> data = responseBody['data'];

      if (mounted) {
        setState(() {
          pendingStudies = data.cast<Map<String, dynamic>>();
        });
      }
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

    if (response.statusCode == 200) {
      final Map<String, dynamic> responseBody = jsonDecode(response.body);
      final List<dynamic> data = responseBody['data'];

      if (mounted) {
        setState(() {
          inProgressStudies = data.cast<Map<String, dynamic>>();
        });
      }
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

    if (response.statusCode == 200) {
      final Map<String, dynamic> responseBody = jsonDecode(response.body);
      final List<dynamic> data = responseBody['data'];
      if (mounted) {
        setState(() {
          approvedStudies = data.cast<Map<String, dynamic>>();
        });
      }
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
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12.0),
                  border: Border.all(
                    color: const Color(0xFF5E875E).withOpacity(0.1),
                    width: 1.0,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: const Color(0xFF5E875E).withOpacity(0.1),
                      blurRadius: 8,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                height: 60,
                width: double.infinity,
                child: TabBar(
                  indicator: BoxDecoration(
                    color: const Color(0xFF5E875E),
                    borderRadius: BorderRadius.circular(8.0),
                    boxShadow: [
                      BoxShadow(
                        color: const Color(0xFF5E875E).withOpacity(0.2),
                        blurRadius: 4,
                        offset: const Offset(0, 1),
                      ),
                    ],
                  ),
                  dividerColor: Colors.transparent,
                  indicatorSize: TabBarIndicatorSize.tab,
                  labelStyle: GoogleFonts.inter(
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                  ),
                  unselectedLabelStyle: GoogleFonts.inter(
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                  ),
                  labelColor: Colors.white,
                  unselectedLabelColor: const Color(
                    0xFF5E875E,
                  ).withOpacity(0.7),
                  splashFactory: NoSplash.splashFactory,
                  overlayColor: MaterialStateProperty.all(Colors.transparent),
                  tabs: const [
                    Tab(
                      icon: Icon(LucideIcons.layoutList, size: 20),
                      text: 'Pending',
                    ),
                    Tab(
                      icon: Icon(LucideIcons.notebookPen, size: 20),
                      text: 'In Progress',
                    ),
                    Tab(
                      icon: Icon(LucideIcons.listCheck, size: 20),
                      text: 'Approved',
                    ),
                  ],
                ),
              ),

              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(top: 16.0),
                  child: TabBarView(
                    children: [
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
                                  onTap: () {
                                    showPendingDialogMessage(
                                      context,
                                      studyId,
                                      title,
                                      type,
                                      onSubmit: () async {
                                        Navigator.of(context).pop();

                                        final token = await getToken();
                                        final response = await http.post(
                                          Uri.parse(
                                            '$apiUrl/thesis-status/$studyId',
                                          ),
                                          headers: {
                                            'Accept': 'application/json',
                                            'Content-Type': 'application/json',
                                            if (token != null)
                                              'Authorization': 'Bearer $token',
                                          },
                                          body: jsonEncode({
                                            'status': 'In Progress',
                                          }),
                                        );

                                        final responseBody = jsonDecode(
                                          response.body,
                                        );

                                        switch (response.statusCode) {
                                          case 200:
                                          case 401:
                                          case 404:
                                            await Future.wait([
                                              _fetchPendingStudies(),
                                              _fetchInProgressStudies(),
                                              _fetchApprovedtudies(),
                                            ]);

                                            final message =
                                                responseBody['message'];
                                            if (mounted) {
                                              showMessageSnackbar(
                                                context,
                                                message,
                                                isError: false,
                                              );
                                            }
                                            break;

                                          case 422:
                                            final detailedErrors =
                                                responseBody['errors']
                                                    as Map<String, dynamic>? ??
                                                {};
                                            detailedErrors.forEach((
                                              field,
                                              errors,
                                            ) {
                                              if (errors is List) {
                                                for (var error in errors) {
                                                  if (mounted) {
                                                    showMessageSnackbar(
                                                      context,
                                                      error.toString(),
                                                    );
                                                  }
                                                }
                                              } else {
                                                if (mounted) {
                                                  showMessageSnackbar(
                                                    context,
                                                    errors.toString(),
                                                  );
                                                }
                                              }
                                            });
                                            break;

                                          default:
                                            if (mounted) {
                                              showMessageSnackbar(
                                                context,
                                                'An error occurred',
                                                isError: true,
                                              );
                                            }
                                        }
                                      },
                                    );
                                  },
                                ),
                              );
                            },
                          ),

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
                                  onTap: () {
                                    showConfirmationDialogMessage(
                                      context,
                                      studyId: studyId,
                                      title: title,
                                      type: type,
                                    );
                                  },
                                ),
                              );
                            },
                          ),

                      approvedStudies.isEmpty
                          ? buildEmptyState(
                            'No approved studies yet.\nComplete your reviews to see them here!',
                          )
                          : ListView.builder(
                            itemCount: approvedStudies.length,
                            itemBuilder: (context, index) {
                              final study = approvedStudies[index];
                              final title = study['study']['title'];
                              final department = study['study']['department'];
                              final type = study['study']['type'];
                              final subtitle = '$department - $type';

                              return Padding(
                                padding: EdgeInsets.only(
                                  top: index == 0 ? 0 : 16.0,
                                ),
                                child: buildSubmissionCard(title, subtitle),
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
