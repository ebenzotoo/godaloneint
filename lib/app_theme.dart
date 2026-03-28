import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  AppTheme._();

  // Brand Colors
  static const Color navyDark = Color(0xFF0D1B3E);
  static const Color navy = Color(0xFF1B3A6B);
  static const Color teal = Color(0xFF2BA8B8);
  static const Color tealDark = Color(0xFF1D8A99);
  static const Color gold = Color(0xFFE8A838);
  static const Color lightBg = Color(0xFFF8FAFB);
  static const Color altBg = Color(0xFFEEF4F7);
  static const Color darkText = Color(0xFF1A1A2E);
  static const Color bodyText = Color(0xFF4A5568);
  static const Color lightText = Color(0xFF9AA5B4);
  static const Color white = Color(0xFFFFFFFF);
  static const Color cardShadow = Color(0x1A1B3A6B);
  static const Color divider = Color(0xFFE2E8F0);

  static const double maxWidth = 1200.0;

  // Responsive helpers
  static bool isMobile(BuildContext context) =>
      MediaQuery.of(context).size.width < 768;

  static bool isTablet(BuildContext context) {
    final w = MediaQuery.of(context).size.width;
    return w >= 768 && w < 1100;
  }

  static bool isDesktop(BuildContext context) =>
      MediaQuery.of(context).size.width >= 1100;

  static double screenWidth(BuildContext context) =>
      MediaQuery.of(context).size.width;

  // Content wrapper with max width constraint
  static Widget constrained({required Widget child, EdgeInsets? padding}) {
    return Center(
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: maxWidth),
        child: Padding(
          padding: padding ?? const EdgeInsets.symmetric(horizontal: 32),
          child: child,
        ),
      ),
    );
  }

  // Text styles
  static TextStyle heroTitle(BuildContext context) => GoogleFonts.playfairDisplay(
        fontSize: isMobile(context) ? 36 : (isTablet(context) ? 52 : 64),
        fontWeight: FontWeight.w700,
        color: white,
        height: 1.2,
        letterSpacing: -0.5,
      );

  static TextStyle sectionHeading(BuildContext context) =>
      GoogleFonts.playfairDisplay(
        fontSize: isMobile(context) ? 28 : 42,
        fontWeight: FontWeight.w700,
        color: navyDark,
        height: 1.3,
        letterSpacing: -0.3,
      );

  static TextStyle sectionHeadingLight(BuildContext context) =>
      GoogleFonts.playfairDisplay(
        fontSize: isMobile(context) ? 28 : 42,
        fontWeight: FontWeight.w700,
        color: white,
        height: 1.3,
        letterSpacing: -0.3,
      );

  static TextStyle cardTitle(BuildContext context) =>
      GoogleFonts.playfairDisplay(
        fontSize: isMobile(context) ? 20 : 24,
        fontWeight: FontWeight.w600,
        color: navyDark,
        height: 1.3,
      );

  static TextStyle sectionLabel() => GoogleFonts.nunito(
        fontSize: 13,
        fontWeight: FontWeight.w800,
        color: teal,
        letterSpacing: 3.0,
      );

  static TextStyle sectionLabelLight() => GoogleFonts.nunito(
        fontSize: 13,
        fontWeight: FontWeight.w800,
        color: teal,
        letterSpacing: 3.0,
      );

  static TextStyle bodyLarge(BuildContext context) => GoogleFonts.nunito(
        fontSize: isMobile(context) ? 15 : 18,
        fontWeight: FontWeight.w400,
        color: bodyText,
        height: 1.8,
      );

  static TextStyle bodyLargeLight(BuildContext context) => GoogleFonts.nunito(
        fontSize: isMobile(context) ? 15 : 18,
        fontWeight: FontWeight.w400,
        color: white.withValues(alpha: 0.85),
        height: 1.8,
      );

  static TextStyle bodyMedium() => GoogleFonts.nunito(
        fontSize: 15,
        fontWeight: FontWeight.w400,
        color: bodyText,
        height: 1.7,
      );

  static TextStyle navLink({bool light = false}) => GoogleFonts.nunito(
        fontSize: 13,
        fontWeight: FontWeight.w700,
        letterSpacing: 1.8,
        color: light ? white : navyDark,
      );

  static TextStyle buttonText() => GoogleFonts.nunito(
        fontSize: 13,
        fontWeight: FontWeight.w800,
        letterSpacing: 2.5,
      );

  static TextStyle footerBody() => GoogleFonts.nunito(
        fontSize: 14,
        fontWeight: FontWeight.w400,
        color: lightText,
        height: 1.8,
      );

  static TextStyle footerLabel() => GoogleFonts.nunito(
        fontSize: 13,
        fontWeight: FontWeight.w800,
        letterSpacing: 2.5,
        color: white,
      );

  // Buttons
  static Widget primaryButton({
    required String text,
    required VoidCallback onPressed,
    Color? bg,
    Color? textColor,
    double? minWidth,
  }) {
    return TextButton(
      onPressed: onPressed,
      style: TextButton.styleFrom(
        backgroundColor: bg ?? teal,
        padding: const EdgeInsets.symmetric(horizontal: 36, vertical: 18),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(50),
        ),
        minimumSize: Size(minWidth ?? 160, 52),
      ),
      child: Text(
        text,
        style: buttonText().copyWith(color: textColor ?? white),
      ),
    );
  }

  static Widget outlinedButton({
    required String text,
    required VoidCallback onPressed,
    Color? borderColor,
    Color? textColor,
  }) {
    return OutlinedButton(
      onPressed: onPressed,
      style: OutlinedButton.styleFrom(
        padding: const EdgeInsets.symmetric(horizontal: 36, vertical: 18),
        side: BorderSide(color: borderColor ?? teal, width: 2),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(50),
        ),
        minimumSize: const Size(160, 52),
      ),
      child: Text(
        text,
        style: buttonText().copyWith(color: textColor ?? teal),
      ),
    );
  }

  // Section label widget with decorative line
  static Widget labelWidget(String text, {bool light = false}) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 32,
          height: 2,
          color: teal,
          margin: const EdgeInsets.only(right: 12),
        ),
        Text(text, style: light ? sectionLabelLight() : sectionLabel()),
      ],
    );
  }
}
