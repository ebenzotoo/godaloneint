import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'package:google_fonts/google_fonts.dart';
import 'home_page.dart';
import 'app_theme.dart';

void main() {
  runApp(const GodAloneApp());
}

class GodAloneApp extends StatelessWidget {
  const GodAloneApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'God Alone International Ministry',
      debugShowCheckedModeBanner: false,
      scrollBehavior: _WebScrollBehavior(),
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: AppTheme.navy,
          primary: AppTheme.navy,
          secondary: AppTheme.teal,
        ),
        textTheme: GoogleFonts.nunitoTextTheme(),
        splashColor: Colors.transparent,
        highlightColor: Colors.transparent,
      ),
      home: const HomePage(),
    );
  }
}

// Enables mouse drag scrolling on web
class _WebScrollBehavior extends MaterialScrollBehavior {
  @override
  Set<PointerDeviceKind> get dragDevices => {
        PointerDeviceKind.touch,
        PointerDeviceKind.mouse,
        PointerDeviceKind.trackpad,
      };
}
