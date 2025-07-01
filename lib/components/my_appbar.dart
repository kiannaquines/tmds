import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
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
                  icon: Icon(LucideIcons.refreshCcw, color: Color(0xFF5E875E)),
                  onPressed: () {},
                ),
                IconButton(
                  icon: Icon(LucideIcons.logOut, color: Color(0xFF5E875E)),
                  onPressed: () async {
                    final prefs = await SharedPreferences.getInstance();
                    await prefs.remove('auth_token');

                    showMessageSnackbar(
                      context,
                      'You have been logout.',
                      isError: false,
                    );

                    if (context.mounted) {
                      Navigator.of(context).pushReplacement(
                        MaterialPageRoute(builder: (context) => SignInScreen()),
                      );
                    }
                  },
                ),
              ]
              : [],
    );
  }
}
