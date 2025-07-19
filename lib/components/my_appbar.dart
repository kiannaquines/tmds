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
                      barrierDismissible:
                          true, // Allows tapping outside to dismiss
                      builder: (BuildContext context) {
                        return Dialog(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16.0),
                          ),
                          elevation: 0,
                          backgroundColor: Colors.transparent,
                          child: Container(
                            padding: const EdgeInsets.all(24),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(16),
                              boxShadow: [
                                BoxShadow(
                                  color: const Color(
                                    0xFF5E875E,
                                  ).withOpacity(0.1),
                                  blurRadius: 24,
                                  spreadRadius: 4,
                                ),
                              ],
                            ),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                // Header
                                Text(
                                  'Logout?',
                                  style: GoogleFonts.inter(
                                    fontSize: 20,
                                    fontWeight: FontWeight.w600,
                                    color: const Color(0xFF5E875E),
                                    height: 1.3,
                                  ),
                                ),
                                const SizedBox(height: 8),
                                // Body text
                                Text(
                                  'Are you sure you want to logout from your account?',
                                  style: GoogleFonts.inter(
                                    color: const Color(
                                      0xFF5E875E,
                                    ).withOpacity(0.8),
                                    fontSize: 14,
                                    height: 1.5,
                                  ),
                                ),
                                const SizedBox(height: 24),
                                // Buttons
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    // Cancel Button
                                    TextButton(
                                      onPressed: () => Navigator.pop(context),
                                      style: TextButton.styleFrom(
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: 16,
                                          vertical: 12,
                                        ),
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(
                                            8,
                                          ),
                                        ),
                                      ),
                                      child: Text(
                                        'Cancel',
                                        style: GoogleFonts.inter(
                                          color: const Color(
                                            0xFF5E875E,
                                          ).withOpacity(0.8),
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ),
                                    const SizedBox(width: 8),
                                    // Logout Button
                                    ElevatedButton(
                                      onPressed: () async {
                                        Navigator.pop(
                                          context,
                                        ); // Close dialog first
                                        await logout(); // Then perform logout
                                      },
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: const Color(
                                          0xFF5E875E,
                                        ),
                                        foregroundColor: Colors.white,
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: 20,
                                          vertical: 12,
                                        ),
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(
                                            8,
                                          ),
                                          side: BorderSide(
                                            color: const Color(
                                              0xFF5E875E,
                                            ).withOpacity(0.2),
                                            width: 1,
                                          ),
                                        ),
                                        elevation: 0,
                                        shadowColor: Colors.transparent,
                                      ),
                                      child: Text(
                                        'Yes, Logout',
                                        style: GoogleFonts.inter(
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
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
