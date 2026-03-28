import 'package:flutter/material.dart';
import 'app_theme.dart';
import 'widgets/nav_bar.dart';
import 'widgets/hero_section.dart';
import 'widgets/about_section.dart';
import 'widgets/mission_section.dart';
import 'widgets/services_section.dart';
import 'widgets/gallery_section.dart';
import 'widgets/department_section.dart';
import 'widgets/footer_section.dart';
import 'widgets/join_form.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _scrollController = ScrollController();
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  bool _isScrolled = false;

  // Section keys for scroll-to navigation
  final _aboutKey = GlobalKey();
  final _servicesKey = GlobalKey();
  final _contactKey = GlobalKey();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  void _onScroll() {
    final scrolled = _scrollController.offset > 60;
    if (scrolled != _isScrolled) {
      setState(() => _isScrolled = scrolled);
    }
  }

  void _scrollToKey(GlobalKey key) {
    final ctx = key.currentContext;
    if (ctx != null) {
      Scrollable.ensureVisible(
        ctx,
        duration: const Duration(milliseconds: 700),
        curve: Curves.easeInOut,
      );
    }
  }

  void _scrollToTop() {
    _scrollController.animateTo(
      0,
      duration: const Duration(milliseconds: 700),
      curve: Curves.easeInOut,
    );
  }

  void _openJoinService() =>
      showJoinForm(context, initial: JoinFormType.service);

  void _openJoinDepartment() =>
      showJoinForm(context, initial: JoinFormType.department);

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: AppTheme.white,
      endDrawer: NavDrawer(
        onHomePressed: _scrollToTop,
        onAboutPressed: () => _scrollToKey(_aboutKey),
        onEventsPressed: () => _scrollToKey(_servicesKey),
        onContactPressed: () => _scrollToKey(_contactKey),
      ),
      body: Stack(
        children: [
          // Scrollable content
          SingleChildScrollView(
            controller: _scrollController,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                HeroSection(
                  onJoinPressed: _openJoinService,
                ),
                KeyedSubtree(
                  key: _aboutKey,
                  child: const AboutSection(),
                ),
                const MissionSection(),
                KeyedSubtree(
                  key: _servicesKey,
                  child: ServicesSection(onJoinPressed: _openJoinService),
                ),
                const GallerySection(),
                DepartmentSection(onJoinPressed: _openJoinDepartment),
                KeyedSubtree(
                  key: _contactKey,
                  child: const FooterSection(),
                ),
              ],
            ),
          ),

          // Sticky nav overlay
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: NavBar(
              isScrolled: _isScrolled,
              scaffoldKey: _scaffoldKey,
              onHomePressed: _scrollToTop,
              onAboutPressed: () => _scrollToKey(_aboutKey),
              onEventsPressed: () => _scrollToKey(_servicesKey),
              onContactPressed: () => _scrollToKey(_contactKey),
            ),
          ),
        ],
      ),

      // Scroll-to-top FAB
      floatingActionButton: AnimatedScale(
        scale: _isScrolled ? 1.0 : 0.0,
        duration: const Duration(milliseconds: 250),
        child: FloatingActionButton(
          onPressed: _scrollToTop,
          backgroundColor: AppTheme.teal,
          foregroundColor: Colors.white,
          elevation: 6,
          child: const Icon(Icons.keyboard_arrow_up_rounded, size: 28),
        ),
      ),
    );
  }
}
