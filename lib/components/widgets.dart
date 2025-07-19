import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:tdms_faculty/screens/feedback.dart';

Widget buildBulletPoint(String text) {
  return Padding(
    padding: EdgeInsets.only(bottom: 6),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(top: 4, right: 8),
          child: Icon(LucideIcons.circle, size: 8, color: Color(0xFF5E875E)),
        ),
        Expanded(
          child: Text(
            text,
            style: GoogleFonts.inter(color: Colors.black87, fontSize: 14),
          ),
        ),
      ],
    ),
  );
}

Future<void> showConfirmationDialogMessage(
  BuildContext context,
  int studyId,
  String title,
  String type,
) {
  return showDialog(
    context: context,
    builder: (BuildContext context) {
      return Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16.0),
        ),
        elevation: 0,
        backgroundColor: Colors.transparent,
        child: Container(
          padding: EdgeInsets.all(24),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header with icon
              Row(
                children: [
                  Container(
                    padding: EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: Color(0xFF5E875E).withOpacity(0.1),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      LucideIcons.badgeHelp,
                      color: Color(0xFF5E875E),
                      size: 24,
                    ),
                  ),
                  SizedBox(width: 12),
                  Text(
                    'Confirmation Required',
                    style: GoogleFonts.inter(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFF5E875E),
                    ),
                  ),
                ],
              ),

              SizedBox(height: 20),

              // Content
              Text(
                'Before proceeding to evaluate this study, please confirm:',
                style: GoogleFonts.inter(color: Colors.black87, fontSize: 14),
              ),

              SizedBox(height: 8),

              // Bullet points
              Padding(
                padding: EdgeInsets.only(left: 8),
                child: Column(
                  children: [
                    buildBulletPoint('You have received the complete paper'),
                    buildBulletPoint('You have reviewed the study details'),
                    buildBulletPoint('You are ready to provide feedback'),
                  ],
                ),
              ),

              SizedBox(height: 24),

              // Buttons
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    onPressed: () => Navigator.pop(context),
                    style: TextButton.styleFrom(
                      padding: EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 12,
                      ),
                    ),
                    child: Text(
                      'Cancel',
                      style: GoogleFonts.inter(
                        color: Colors.grey.shade700,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  SizedBox(width: 8),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder:
                              (context) => FeedbackScreen(
                                studyId: studyId,
                                studyTitle: title,
                                studyType: type,
                              ),
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xFF5E875E),
                      padding: EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 12,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(LucideIcons.check, size: 18, color: Colors.white),
                        SizedBox(width: 8),
                        Text(
                          'Confirm',
                          style: GoogleFonts.inter(
                            color: Colors.white,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
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
}

Widget buildEmptyState(String message) {
  return Center(
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(
          LucideIcons.inbox,
          size: 48,
          color: Color(0xFF5E875E).withOpacity(0.5),
        ),
        SizedBox(height: 16),
        Text(
          message,
          style: GoogleFonts.inter(
            color: Color(0xFF5E875E).withOpacity(0.7),
            fontSize: 16,
          ),
          textAlign: TextAlign.center,
        ),
      ],
    ),
  );
}

Widget buildTextField(
  String hint,
  TextEditingController controller, {
  GestureTapCallback? onTap,
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
      onTap: onTap,
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

Widget buildSubmissionCard(
  String title,
  String subtitle,
  String? details,
  VoidCallback? onTap,
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
              if (details != null && details.trim().isNotEmpty)
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 4),
                    Text(
                      details,
                      style: GoogleFonts.inter(
                        color: Color(0xFF5E875E),
                        fontSize: 10,
                      ),
                    ),
                  ],
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
      children: [
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
              Text(
                subtitle,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
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
      ],
    ),
  );
}
