import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  static ThemeData buildTheme() {
    final base = ThemeData.light();
    final textTheme = base.textTheme;

    return ThemeData(
      primaryColor: Color(0xFF5E875E),
      scaffoldBackgroundColor: Color(0xFFF7FCF7),
      useMaterial3: true,
      appBarTheme: AppBarTheme(
        scrolledUnderElevation: 0,
        backgroundColor: Colors.white,
        foregroundColor: Color(0xFF0D1C0D),
        titleTextStyle: GoogleFonts.inter(
          fontSize: 18,
          fontWeight: FontWeight.w600,
          color: Color(0xFF0D1C0D),
        ),
        iconTheme: IconThemeData(color: Color(0xFF0D1C0D)),
      ),
      textTheme: GoogleFonts.openSansTextTheme(textTheme).copyWith(
        bodyMedium: GoogleFonts.inter(textStyle: textTheme.bodyMedium),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: Colors.white,
        contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      ),
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        type: BottomNavigationBarType.fixed,
        elevation: 0,
        backgroundColor: Colors.white,
        selectedItemColor: Color(0xFF0D1C0D),
        unselectedItemColor: Color(0xFF5E875E),
        selectedLabelStyle: TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w600,
          fontFamily: GoogleFonts.inter().fontFamily,
        ),
        unselectedLabelStyle: TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w600,
          fontFamily: GoogleFonts.inter().fontFamily,
        ),
      ),
    );
  }
}
