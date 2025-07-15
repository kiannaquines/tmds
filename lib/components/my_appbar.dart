import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:tdms_faculty/constants.dart';
import 'package:tdms_faculty/screens/signin.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tdms_faculty/components/widgets.dart';

class MyAppbar extends StatefulWidget {
  const MyAppbar({
    super.key,
    required this.title,
    this.showActions = true,
    this.withLeading = false,
    this.locationScreen,
  });
  final String title;
  final bool showActions;
  final bool withLeading;
  final VoidCallback? locationScreen;

  @override
  State<MyAppbar> createState() => _MyAppbarState();
}

class _MyAppbarState extends State<MyAppbar> {
  Future<String?> _getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('auth_token');
  }

  Future<void> logout() async {
    final url = Uri.parse('$apiUrl/logout');
    final token = await _getToken();

    final response = await http.post(
      url,
      headers: {
        'Accept': 'application/json',
        'Content-Type': 'application/json',
        if (token != null) 'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      final responseBody = jsonDecode(response.body);
      final String message = responseBody['message'] ?? 'Logout successful.';

      final prefs = await SharedPreferences.getInstance();
      await prefs.remove('auth_token');
      await prefs.remove('role');

      if (context.mounted) {
        showMessageSnackbar(context, message, isError: false);
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => const SignInScreen()),
        );
      }
    } else {
      showMessageSnackbar(context, 'Failed to log out. Please try again.');
    }
  }

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading:
          (widget.withLeading)
              ? IconButton(
                icon: Icon(LucideIcons.chevronLeft, color: Color(0xFF5E875E)),
                onPressed: widget.locationScreen,
              )
              : null,
      title: Text(
        widget.title,
        style: GoogleFonts.inter(
          fontSize: 18,
          color: Color(0xFF5E875E),
          fontWeight: FontWeight.w600,
        ),
      ),
      automaticallyImplyLeading: false,
      centerTitle: true,
      actions:
          (widget.showActions)
              ? [
                IconButton(
                  icon: Icon(LucideIcons.logOut, color: Color(0xFF5E875E)),
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: Text(
                            'Logout?',
                            style: GoogleFonts.inter(
                              fontSize: 21.0,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF5E875E),
                            ),
                          ),
                          content: Text(
                            'Are you sure you want to logout this account?',
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
                              onPressed: () async {
                                await logout();
                              },
                              style: ButtonStyle(
                                foregroundColor: MaterialStateProperty.all(
                                  const Color(0xFFFFFFFF),
                                ),
                                backgroundColor: MaterialStateProperty.all(
                                  const Color(0xFF5E875E),
                                ),
                              ),
                              child: Text(
                                'Yes, Logout',
                                style: GoogleFonts.inter(
                                  color: Color(0xFFFFFFFF),
                                ),
                              ),
                            ),
                          ],
                        );
                      },
                    );
                  },
                ),
              ]
              : [],
    );
  }
}
