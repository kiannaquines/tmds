import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

Widget buildTextField(
  String hint,
  TextEditingController controller, {
  bool isPassword = false,
  bool readOnly = false,
  bool isNumeric = false,
  int maxLines = 5,
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
      keyboardType: isNumeric ? TextInputType.phone : TextInputType.text,
      maxLines: maxLines,
      readOnly: readOnly,
      cursorColor: Color(0xFF5E875E),
      controller: controller,
      obscureText: isPassword,
      style: GoogleFonts.inter(
        color: Color(0xFF5E875E),
        fontSize: 15,
        fontWeight: FontWeight.w400,
      ),
      decoration: InputDecoration.collapsed(
        hintText: hint,
        hintStyle: GoogleFonts.inter(
          color: Color(0xFF5E875E),
          fontSize: 15,
          fontWeight: FontWeight.w400,
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
  return Container(
    padding: EdgeInsets.all(12.0),
    decoration: BoxDecoration(
      color: Color(0xFFFFFFFF),
      borderRadius: BorderRadius.circular(12.0),
      boxShadow: [
        BoxShadow(
          color: Color(0xFFFFFFFF).withOpacity(0.1),
          blurRadius: 6,
          offset: Offset(0, 1),
        ),
      ],
    ),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 48,
          height: 48,
          padding: EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: Color(0xFFE8F2E8),
            borderRadius: BorderRadius.circular(4),
          ),
          child: Icon(LucideIcons.library, color: Color(0xFF5E875E), size: 24),
        ),
        SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                title,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: GoogleFonts.inter(
                  fontWeight: FontWeight.w500,
                  color: Color(0xFF5E875E),
                  fontSize: 12,
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
          icon: Icon(LucideIcons.arrowRight, color: Color(0xFF5E875E)),
          onPressed: onTap,
        ),
      ],
    ),
  );
}

Widget buildNotificationCard(String title, String subtitle, String timeAgo) {
  return SizedBox(
    child: Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
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
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                title,
                style: GoogleFonts.inter(
                  fontWeight: FontWeight.w500,
                  color: Color(0xFF5E875E),
                  fontSize: 12,
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
              Text(
                timeAgo,
                style: GoogleFonts.inter(color: Color(0xFF5E875E), fontSize: 8),
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
    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 7),
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
        fontSize: 15,
        fontWeight: FontWeight.w400,
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
  required String status,
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
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: const Color(0xFF5E875E),
                      ),
                    ),
                    if (timeAgo != null)
                      Text(
                        timeAgo,
                        style: GoogleFonts.inter(
                          fontSize: 10,
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
                const SizedBox(height: 8),
                Text(
                  '($status)',
                  style: GoogleFonts.inter(
                    fontSize: 12,
                    height: 1.4,
                    color: const Color(0xFF5E875E).withOpacity(0.8),
                    fontStyle: FontStyle.italic,
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
    showCloseIcon: true,
    duration: const Duration(seconds: 3),
  );

  ScaffoldMessenger.of(context).showSnackBar(snackBar);
}

Widget buildUserCard(
  String title,
  String subtitle,
  String data,
  VoidCallback onTap,
) {
  return Container(
    padding: EdgeInsets.all(12.0),
    decoration: BoxDecoration(
      color: Color(0xFFFFFFFF),
      borderRadius: BorderRadius.circular(12.0),
      boxShadow: [
        BoxShadow(
          color: Color(0xFFFFFFFF).withOpacity(0.1),
          blurRadius: 6,
          offset: Offset(0, 1),
        ),
      ],
    ),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 48,
          height: 48,
          padding: EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: Color(0xFFE8F2E8),
            borderRadius: BorderRadius.circular(4),
          ),
          child: Icon(LucideIcons.users, color: Color(0xFF5E875E), size: 24),
        ),
        SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
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
              Text(
                data,
                style: GoogleFonts.inter(
                  color: Color(0xFF5E875E),
                  fontSize: 10,
                ),
              ),
            ],
          ),
        ),
        // IconButton(
        //   icon: Icon(LucideIcons.arrowRight, color: Color(0xFF5E875E)),
        //   onPressed: onTap,
        // ),
      ],
    ),
  );
}
