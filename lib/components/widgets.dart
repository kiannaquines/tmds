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

Future<void> showPendingDialogMessage(
  BuildContext context,
  int studyId,
  String title,
  String type, {
  VoidCallback? onSubmit,
}) {
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
              Text(
                'Are you sure you want to update the status of the study into In Progress?',
                style: GoogleFonts.inter(color: Colors.black87, fontSize: 14),
              ),
              SizedBox(height: 24),
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
                    onPressed: onSubmit,
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

// Widget buildTextField(
//   String hint,
//   TextEditingController controller, {
//   GestureTapCallback? onTap,
//   bool isPassword = false,
//   bool readOnly = false,
//   bool isNumeric = false,
//   int maxLines = 5,
// }) {
//   return Container(
//     padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
//     decoration: BoxDecoration(
//       color: Colors.white,
//       borderRadius: BorderRadius.circular(12),
//       boxShadow: [
//         BoxShadow(
//           color: const Color(0xFF5E875E).withOpacity(0.2),
//           blurRadius: 8,
//           spreadRadius: 2,
//         ),
//       ],
//     ),
//     child: TextField(
//       onTap: onTap,
//       keyboardType: isNumeric ? TextInputType.phone : TextInputType.text,
//       maxLines: maxLines,
//       readOnly: readOnly,
//       cursorColor: Color(0xFF5E875E),
//       controller: controller,
//       obscureText: isPassword,
//       style: GoogleFonts.inter(
//         color: Color(0xFF5E875E),
//         fontSize: 15,
//         fontWeight: FontWeight.w400,
//       ),
//       decoration: InputDecoration.collapsed(
//         hintText: hint,
//         hintStyle: GoogleFonts.inter(
//           color: Color(0xFF5E875E),
//           fontSize: 15,
//           fontWeight: FontWeight.w400,
//         ),
//       ),
//     ),
//   );
// }

Widget buildTextField(
  String hint,
  TextEditingController controller, {
  GestureTapCallback? onTap,
  bool isPassword = false,
  bool readOnly = false,
  bool isNumeric = false,
  int maxLines = 1,
}) {
  return Container(
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(12),
      boxShadow: [
        BoxShadow(
          color: const Color(0xFF5E875E).withOpacity(0.1),
          blurRadius: 10,
          spreadRadius: 2,
          offset: const Offset(0, 3), // Subtle shadow for depth
        ),
      ],
      border: Border.all(
        color: const Color(0xFF5E875E).withOpacity(0.2),
        width: 1,
      ),
    ),
    child: TextField(
      onTap: onTap,
      keyboardType: isNumeric ? TextInputType.number : TextInputType.text,
      maxLines: maxLines,
      readOnly: readOnly,
      cursorColor: const Color(0xFF5E875E),
      controller: controller,
      obscureText: isPassword,
      style: GoogleFonts.inter(
        color: const Color(0xFF5E875E),
        fontSize: 16, // Slightly larger for better readability
        fontWeight: FontWeight.w500, // Medium weight for better contrast
      ),
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: GoogleFonts.inter(
          color: const Color(0xFF5E875E).withOpacity(0.5), // Lighter hint text
          fontSize: 16,
          fontWeight: FontWeight.w400,
        ),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 14, // Better vertical padding for balance
        ),
        border: InputBorder.none, // Remove default underline
        filled: false,
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(
            color: const Color(0xFF5E875E).withOpacity(0.5),
            width: 1.5,
          ),
        ),
      ),
    ),
  );
}

Widget buildGreenButton(
  String text,
  VoidCallback onPressed, {
  bool isFullWidth = true,
  bool isDisabled = false,
  IconData? icon,
  double borderRadius = 12.0,
  EdgeInsetsGeometry? padding,
  Color? buttonColor,
  Color? textColor,
  double? elevation,
}) {
  return SizedBox(
    width: isFullWidth ? double.infinity : null,
    child: ElevatedButton(
      onPressed: isDisabled ? null : onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor:
            isDisabled
                ? const Color(0xFF5E875E).withOpacity(0.4)
                : buttonColor ?? const Color(0xFF5E875E),
        foregroundColor: textColor ?? Colors.white,
        padding:
            padding ?? const EdgeInsets.symmetric(vertical: 18, horizontal: 24),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(borderRadius),
          side: BorderSide(
            color: const Color(0xFF5E875E).withOpacity(0.2),
            width: 1,
          ),
        ),
        elevation: elevation ?? 2,
        shadowColor: const Color(0xFF5E875E).withOpacity(0.3),
        animationDuration: const Duration(milliseconds: 200),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (icon != null) ...[
            Icon(icon, size: 20, color: textColor ?? Colors.white),
            const SizedBox(width: 12),
          ],
          Text(
            text,
            style: GoogleFonts.inter(
              color: textColor ?? Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.w600,
              letterSpacing: 0.5,
            ),
          ),
        ],
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
  String subtitle, {
  String? details,
  VoidCallback? onTap,
  Color? iconColor,
  Color? cardColor,
  bool showShadow = true,
  bool isInteractive = true,
}) {
  return GestureDetector(
    onTap: onTap,
    child: Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: cardColor ?? Colors.white,
        borderRadius: BorderRadius.circular(12.0),
        border: Border.all(
          color: const Color(0xFF5E875E).withOpacity(0.1),
          width: 1.0,
        ),
        boxShadow:
            showShadow
                ? [
                  BoxShadow(
                    color: const Color(0xFF5E875E).withOpacity(0.1),
                    blurRadius: 8,
                    spreadRadius: 1,
                    offset: const Offset(0, 2),
                  ),
                ]
                : null,
      ),
      child: Row(
        children: [
          AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            width: 48,
            height: 48,
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: const Color(0xFFE8F2E8),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(
              LucideIcons.library,
              color: iconColor ?? const Color(0xFF5E875E),
              size: 24,
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: GoogleFonts.inter(
                    fontWeight: FontWeight.w600,
                    color: const Color(0xFF5E875E),
                    fontSize: 14,
                    letterSpacing: -0.2,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  subtitle,
                  style: GoogleFonts.inter(
                    color: const Color(0xFF5E875E).withOpacity(0.8),
                    fontSize: 12,
                  ),
                ),
                if (details != null && details.trim().isNotEmpty)
                  Padding(
                    padding: const EdgeInsets.only(top: 4),
                    child: Text(
                      details,
                      style: GoogleFonts.inter(
                        color: const Color(0xFF5E875E).withOpacity(0.6),
                        fontSize: 11,
                      ),
                    ),
                  ),
              ],
            ),
          ),
          if (isInteractive && onTap != null)
            IconButton(
              icon: Icon(
                LucideIcons.arrowRight,
                color: const Color(0xFF5E875E).withOpacity(0.8),
                size: 20,
              ),
              onPressed: onTap,
              splashRadius: 20,
            ),
        ],
      ),
    ),
  );
}

Widget buildNotificationCard(
  String title,
  String subtitle,
  String timeAgo, {
  bool isUnread = false,
  VoidCallback? onTap,
  IconData? icon,
}) {
  return GestureDetector(
    onTap: onTap,
    child: Container(
      padding: const EdgeInsets.all(16.0),
      margin: const EdgeInsets.only(bottom: 8.0), // Space between cards
      decoration: BoxDecoration(
        color:
            isUnread
                ? const Color(0xFFF0F7F0) // Light green for unread
                : Colors.white,
        borderRadius: BorderRadius.circular(12.0),
        border: Border.all(
          color: const Color(0xFF5E875E).withOpacity(0.1),
          width: 1.0,
        ),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF5E875E).withOpacity(0.05),
            blurRadius: 8,
            spreadRadius: 1,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Status indicator/icon
          if (icon != null) ...[
            Container(
              padding: const EdgeInsets.all(6.0),
              decoration: BoxDecoration(
                color: const Color(0xFFE8F2E8),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(icon, size: 16, color: const Color(0xFF5E875E)),
            ),
            const SizedBox(width: 12),
          ] else if (isUnread) ...[
            Container(
              width: 8,
              height: 8,
              margin: const EdgeInsets.only(top: 4, right: 8),
              decoration: BoxDecoration(
                color: const Color(0xFF5E875E),
                shape: BoxShape.circle,
              ),
            ),
          ],
          // Content
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Title with unread emphasis
                Text(
                  title,
                  style: GoogleFonts.inter(
                    fontWeight: isUnread ? FontWeight.w600 : FontWeight.w500,
                    color: const Color(0xFF5E875E),
                    fontSize: 14,
                    height: 1.3,
                  ),
                ),
                const SizedBox(height: 6),
                // Subtitle
                Text(
                  subtitle,
                  style: GoogleFonts.inter(
                    color: const Color(0xFF5E875E).withOpacity(0.8),
                    fontSize: 12,
                    height: 1.4,
                  ),
                ),
                const SizedBox(height: 6),
                // Time with subtle styling
                Text(
                  timeAgo,
                  style: GoogleFonts.inter(
                    color: const Color(0xFF5E875E).withOpacity(0.6),
                    fontSize: 10,
                  ),
                ),
              ],
            ),
          ),
          // Optional tap target
          if (onTap != null) ...[
            const SizedBox(width: 8),
            Icon(
              LucideIcons.chevronRight,
              size: 16,
              color: const Color(0xFF5E875E).withOpacity(0.5),
            ),
          ],
        ],
      ),
    ),
  );
}

Widget buildDropdown(
  String hint,
  String? value,
  List<String> items,
  Function(String?) onChanged, {
  Widget? prefixIcon,
  Color? fillColor,
  Color? borderColor,
  double borderRadius = 12.0,
  bool showShadow = true,
  EdgeInsetsGeometry? padding,
}) {
  return Container(
    padding: padding ?? const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
    decoration: BoxDecoration(
      color: fillColor ?? Colors.white,
      borderRadius: BorderRadius.circular(borderRadius),
      border: Border.all(
        color: borderColor ?? const Color(0xFF5E875E).withOpacity(0.2),
        width: 1.0,
      ),
      boxShadow:
          showShadow
              ? [
                BoxShadow(
                  color: const Color(0xFF5E875E).withOpacity(0.1),
                  blurRadius: 10,
                  spreadRadius: 2,
                  offset: const Offset(0, 3), // Subtle depth
                ),
              ]
              : null,
    ),
    child: DropdownButton<String>(
      value: value,
      hint: Text(
        hint,
        style: GoogleFonts.inter(
          color: const Color(0xFF5E875E).withOpacity(0.6),
          fontSize: 16,
          fontWeight: FontWeight.w400,
        ),
      ),
      isExpanded: true,
      underline: const SizedBox(), // Remove default underline
      icon: Icon(
        Icons.keyboard_arrow_down_rounded, // Rounded arrow for modern look
        color: const Color(0xFF5E875E).withOpacity(0.8),
        size: 24,
      ),
      dropdownColor: Colors.white,
      iconEnabledColor: const Color(0xFF5E875E),
      style: GoogleFonts.inter(
        color: const Color(0xFF5E875E),
        fontSize: 16,
        fontWeight: FontWeight.w500, // Slightly bolder selected text
      ),
      borderRadius: BorderRadius.circular(
        borderRadius - 2,
      ), // Slightly rounded dropdown
      items:
          items.map((String item) {
            return DropdownMenuItem<String>(
              value: item,
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: Text(
                  item,
                  style: GoogleFonts.inter(
                    color: const Color(0xFF5E875E),
                    fontSize: 15,
                  ),
                ),
              ),
            );
          }).toList(),
      onChanged: onChanged,
    ),
  );
}

Widget buildTimelineItem({
  required String title,
  required String role,
  required String subtitle,
  required String status,
  String? timeAgo,
  IconData? icon = LucideIcons.check,
  bool isLast = false,
  bool isActive = false,
  VoidCallback? onTap,
}) {
  return GestureDetector(
    onTap: onTap,
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Timeline indicator
        Column(
          children: [
            // Indicator dot
            Container(
              width: 24,
              height: 24,
              decoration: BoxDecoration(
                color: isActive ? const Color(0xFF5E875E) : Colors.white,
                shape: BoxShape.circle,
                border: Border.all(
                  color: const Color(0xFF5E875E),
                  width: isActive ? 0 : 2,
                ),
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
                  icon ?? LucideIcons.circle,
                  size: 14,
                  color: isActive ? Colors.white : const Color(0xFF5E875E),
                ),
              ),
            ),
            // Vertical line
            if (!isLast)
              Container(
                width: 2,
                height: 72,
                margin: const EdgeInsets.only(top: 4),
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
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: const Color(0xFF5E875E).withOpacity(0.05),
                  blurRadius: 12,
                  offset: const Offset(0, 4),
                ),
              ],
              border: Border.all(
                color:
                    isActive
                        ? const Color(0xFF5E875E).withOpacity(0.3)
                        : const Color(0xFF5E875E).withOpacity(0.08),
                width: 1,
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Header row
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        title,
                        style: GoogleFonts.inter(
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                          color: const Color(0xFF5E875E),
                          height: 1.3,
                        ),
                      ),
                      if (timeAgo != null)
                        Text(
                          timeAgo,
                          style: GoogleFonts.inter(
                            fontSize: 10,
                            color: const Color(0xFF5E875E).withOpacity(0.5),
                          ),
                        ),
                    ],
                  ),
                  Text(
                    role,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: GoogleFonts.inter(
                      fontSize: 9,
                      fontWeight: FontWeight.w500,
                      color: const Color(0xFF5E875E).withOpacity(0.7),
                    ),
                  ),
                  const SizedBox(height: 12),
                  // Description
                  Text(
                    subtitle,
                    style: GoogleFonts.inter(
                      fontSize: 13,
                      height: 1.5,
                      color: const Color(0xFF5E875E).withOpacity(0.8),
                    ),
                  ),
                  const SizedBox(height: 8),
                  // Status
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: const Color(0xFFE8F2E8),
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Text(
                      status.toUpperCase(),
                      style: GoogleFonts.inter(
                        fontSize: 10,
                        fontWeight: FontWeight.w600,
                        color: const Color(0xFF5E875E),
                        letterSpacing: 0.5,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    ),
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
  VoidCallback onTap, {
  IconData? icon,
  Color? iconColor,
  Color? iconBackgroundColor,
  bool showShadow = true,
  bool showBorder = true,
}) {
  return GestureDetector(
    onTap: onTap,
    child: Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border:
            showBorder
                ? Border.all(
                  color: const Color(0xFF5E875E).withOpacity(0.1),
                  width: 1,
                )
                : null,
        boxShadow:
            showShadow
                ? [
                  BoxShadow(
                    color: const Color(0xFF5E875E).withOpacity(0.1),
                    blurRadius: 10,
                    spreadRadius: 1,
                    offset: const Offset(0, 3),
                  ),
                ]
                : null,
      ),
      child: Row(
        children: [
          // User Avatar/Icon
          Container(
            width: 48,
            height: 48,
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: iconBackgroundColor ?? const Color(0xFFE8F2E8),
              borderRadius: BorderRadius.circular(8), // Smoother corners
            ),
            child: Icon(
              icon ?? LucideIcons.users,
              color: iconColor ?? const Color(0xFF5E875E),
              size: 24,
            ),
          ),
          const SizedBox(width: 16),

          // User Information
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Title
                Text(
                  title,
                  style: GoogleFonts.inter(
                    fontWeight: FontWeight.w600,
                    color: const Color(0xFF5E875E),
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: 4),

                // Subtitle
                Text(
                  subtitle,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: GoogleFonts.inter(
                    color: const Color(0xFF5E875E).withOpacity(0.8),
                    fontSize: 12,
                  ),
                ),
                const SizedBox(height: 4),

                // Data (with accent style)
                Text(
                  data,
                  style: GoogleFonts.inter(
                    color: const Color(0xFF5E875E).withOpacity(0.6),
                    fontSize: 12,
                    fontStyle: FontStyle.italic,
                  ),
                ),
              ],
            ),
          ),

          // Interactive Arrow
          const SizedBox(width: 8),
          Icon(
            LucideIcons.chevronRight,
            color: const Color(0xFF5E875E).withOpacity(0.5),
            size: 20,
          ),
        ],
      ),
    ),
  );
}
