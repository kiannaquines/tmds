import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

Widget buildTextField(
  String hint,
  TextEditingController controller, {
  bool isPassword = false,
  bool readOnly = false,
}) {
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(12),
      boxShadow: [
        BoxShadow(
          color: const Color(0xFF5E875E).withOpacity(0.2),
          blurRadius: 8,
          spreadRadius: 2,
        ),
      ],
    ),
    child: TextField(
      readOnly: readOnly,
      cursorColor: Color(0xFF5E875E),
      controller: controller,
      obscureText: isPassword,
      style: GoogleFonts.inter(
        color: Color(0xFF5E875E),
        fontSize: 16,
        fontWeight: FontWeight.w500,
      ),
      decoration: InputDecoration.collapsed(
        hintText: hint,
        hintStyle: GoogleFonts.inter(
          color: Color(0xFF5E875E),
          fontSize: 16,
          fontWeight: FontWeight.w500,
        ),
      ),
    ),
  );
}

Widget buildGreenButton(String text, VoidCallback onPressed) {
  return SizedBox(
    width: double.infinity,
    child: ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: Color(0xFF5E875E),
        padding: EdgeInsets.symmetric(vertical: 16),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
      child: Text(
        text,
        style: GoogleFonts.inter(
          color: Colors.white,
          fontSize: 16,
          fontWeight: FontWeight.w600,
        ),
      ),
    ),
  );
}

Widget buildButton(String text, VoidCallback onPressed) {
  return SizedBox(
    width: double.infinity,
    child: ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: Color(0xFFEBF0EB),
        padding: EdgeInsets.symmetric(vertical: 16),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        elevation: 1,
        shadowColor: Color(0xFF5E875E).withOpacity(0.2),
        overlayColor: Color(0xFF5E875E).withOpacity(0.1),
        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
      ),
      child: Text(
        text,
        style: GoogleFonts.inter(
          color: Color(0xFF5E875E),
          fontSize: 16,
          fontWeight: FontWeight.w600,
        ),
      ),
    ),
  );
}

Widget buildSubmissionCard(String title, String subtitle, VoidCallback onTap) {
  return SizedBox(
    child: Row(
      children: [
        Container(
          width: 48,
          height: 48,
          padding: EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: Color(0xFFE8F2E8),
            borderRadius: BorderRadius.circular(4),
          ),
          child: Icon(LucideIcons.file, color: Color(0xFF5E875E), size: 24),
        ),
        SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: GoogleFonts.inter(
                  fontWeight: FontWeight.w500,
                  color: Color(0xFF5E875E),
                  fontSize: 15,
                ),
              ),
              SizedBox(height: 4),
              Text(
                subtitle,
                style: GoogleFonts.inter(
                  color: Color(0xFF5E875E),
                  fontSize: 10,
                ),
              ),
            ],
          ),
        ),
        IconButton(
          icon: Icon(LucideIcons.ellipsisVertical, color: Color(0xFF5E875E)),
          onPressed: onTap,
        ),
      ],
    ),
  );
}

Widget buildNotificationCard(String title, String subtitle) {
  return SizedBox(
    child: Row(
      children: [
        Container(
          width: 48,
          height: 48,
          padding: EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: Color(0xFFE8F2E8),
            borderRadius: BorderRadius.circular(4),
          ),
          child: Icon(LucideIcons.bell, color: Color(0xFF5E875E), size: 24),
        ),
        SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: GoogleFonts.inter(
                  fontWeight: FontWeight.w500,
                  color: Color(0xFF5E875E),
                  fontSize: 15,
                ),
              ),
              SizedBox(height: 4),
              Text(
                subtitle,
                style: GoogleFonts.inter(
                  color: Color(0xFF5E875E),
                  fontSize: 10,
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

Widget buildDropdown(
  String hint,
  String? value,
  List<String> items,
  Function(String?) onChanged,
) {
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(12),
      boxShadow: [
        BoxShadow(
          color: const Color(0xFF5E875E).withOpacity(0.2),
          blurRadius: 8,
          spreadRadius: 2,
        ),
      ],
    ),
    child: DropdownButton<String>(
      value: value,
      hint: Text(hint, style: TextStyle(color: Color(0xFF5E875E))),
      isExpanded: true,
      underline: SizedBox(),
      icon: Icon(Icons.keyboard_arrow_down, color: Colors.grey[600]),
      dropdownColor: Colors.white,
      iconEnabledColor: Color(0xFF5E875E),
      style: GoogleFonts.inter(
        color: Color(0xFF5E875E),
        fontSize: 16,
        fontWeight: FontWeight.w500,
      ),
      items:
          items.map((String item) {
            return DropdownMenuItem<String>(value: item, child: Text(item));
          }).toList(),
      onChanged: onChanged,
    ),
  );
}

Widget buildTimelineItem({
  required String title,
  required String subtitle,
  String? timeAgo,
  IconData? icon = Icons.check_circle,
  bool isLast = false,
}) {
  return Row(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Column(
        children: [
          Container(
            width: 20,
            height: 20,
            decoration: BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
              border: Border.all(color: const Color(0xFF5E875E), width: 2),
              boxShadow: [
                BoxShadow(
                  color: const Color(0xFF5E875E).withOpacity(0.2),
                  blurRadius: 8,
                  spreadRadius: 2,
                ),
              ],
            ),
            child: Center(
              child: Icon(
                icon ?? Icons.circle,
                size: 12,
                color: const Color(0xFF5E875E),
              ),
            ),
          ),
          if (!isLast)
            Container(
              width: 2,
              height: 64,
              color: const Color(0xFF5E875E).withOpacity(0.1),
            ),
        ],
      ),

      const SizedBox(width: 16),

      // Content card
      Expanded(
        child: Container(
          margin: EdgeInsets.only(bottom: isLast ? 0 : 24),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            color: Colors.white.withOpacity(0.8),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.05),
                blurRadius: 12,
                offset: const Offset(0, 6),
              ),
            ],
            border: Border.all(
              color: const Color(0xFF5E875E).withOpacity(0.08),
              width: 1,
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      title,
                      style: GoogleFonts.inter(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: const Color(0xFF5E875E),
                      ),
                    ),
                    if (timeAgo != null)
                      Text(
                        timeAgo,
                        style: GoogleFonts.inter(
                          fontSize: 12,
                          color: Colors.grey.shade500,
                        ),
                      ),
                  ],
                ),
                const SizedBox(height: 8),
                Text(
                  subtitle,
                  style: GoogleFonts.inter(
                    fontSize: 14,
                    height: 1.4,
                    color: const Color(0xFF5E875E).withOpacity(0.8),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    ],
  );
}

void showMessageSnackbar(
  BuildContext context,
  String message, {
  bool isError = true,
}) {
  final snackBar = SnackBar(
    content: Text(message),
    backgroundColor:
        isError ? const Color(0xFFD32F2F) : const Color(0xFF5E875E),
    behavior: SnackBarBehavior.floating,
    margin: const EdgeInsets.all(16),
    duration: const Duration(seconds: 3),
  );

  ScaffoldMessenger.of(context).showSnackBar(snackBar);
}
