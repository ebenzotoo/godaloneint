import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../app_theme.dart';

class HeroSection extends StatelessWidget {
  final VoidCallback? onJoinPressed;

  const HeroSection({super.key, this.onJoinPressed});

  @override
  Widget build(BuildContext context) {
    final bool mobile = AppTheme.isMobile(context);
    final double screenHeight = MediaQuery.of(context).size.height;

    return SizedBox(
      height: screenHeight,
      width: double.infinity,
      child: Stack(
        fit: StackFit.expand,
        children: [
          // Background image
          Image.asset(
            'assets/GAIM1.jpg',
            fit: BoxFit.cover,
          ),

          // Gradient overlay
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
                colors: [
                  Color(0xE50D1B3E),
                  Color(0xAA1B3A6B),
                  Color(0x661B3A6B),
                ],
              ),
            ),
          ),

          // Secondary vertical gradient for text readability
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.bottomCenter,
                end: Alignment.topCenter,
                colors: [
                  AppTheme.navyDark.withValues(alpha: 0.7),
                  Colors.transparent,
                  Colors.transparent,
                ],
              ),
            ),
          ),

          // Content
          Positioned.fill(
            child: AppTheme.constrained(
              padding: EdgeInsets.symmetric(horizontal: mobile ? 24 : 32),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 80), // nav bar offset

                  // Label
                  _PulsingBadge(),

                  const SizedBox(height: 28),

                  // Main headline
                  Text(
                    mobile
                        ? 'To Grow in Faith\n& Share His Love\nWith the World'
                        : 'To Grow in Faith\n& Share His Love\nWith the World Around Us',
                    style: AppTheme.heroTitle(context),
                  ),

                  const SizedBox(height: 24),

                  // Subtext
                  ConstrainedBox(
                    constraints: BoxConstraints(
                        maxWidth: mobile ? double.infinity : 520),
                    child: Text(
                      'A spirit-filled, multi-cultural, kingdom prosperity centred church '
                      'impacting our city, our nation and the world.',
                      style: AppTheme.bodyLargeLight(context),
                    ),
                  ),

                  const SizedBox(height: 48),

                  // CTA buttons
                  Wrap(
                    spacing: 16,
                    runSpacing: 16,
                    children: [
                      AppTheme.primaryButton(
                        text: 'JOIN US THIS WEEKEND',
                        onPressed: onJoinPressed ?? () {},
                      ),
                      AppTheme.outlinedButton(
                        text: 'WATCH ONLINE',
                        onPressed: () {},
                        borderColor: Colors.white,
                        textColor: Colors.white,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),

          // Scroll indicator
          Positioned(
            bottom: 40,
            left: 0,
            right: 0,
            child: Center(child: _ScrollIndicator()),
          ),
        ],
      ),
    );
  }
}

class _PulsingBadge extends StatefulWidget {
  @override
  State<_PulsingBadge> createState() => _PulsingBadgeState();
}

class _PulsingBadgeState extends State<_PulsingBadge>
    with SingleTickerProviderStateMixin {
  late AnimationController _ctrl;
  late Animation<double> _opacity;

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat(reverse: true);
    _opacity = Tween(begin: 0.6, end: 1.0).animate(
      CurvedAnimation(parent: _ctrl, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: _opacity,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: AppTheme.teal.withValues(alpha: 0.2),
          borderRadius: BorderRadius.circular(50),
          border: Border.all(color: AppTheme.teal, width: 1),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 8,
              height: 8,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: AppTheme.teal,
              ),
            ),
            const SizedBox(width: 8),
            Text(
              'GOD ALONE INTERNATIONAL MINISTRY',
              style: GoogleFonts.nunito(
                fontSize: 11,
                fontWeight: FontWeight.w700,
                color: AppTheme.teal,
                letterSpacing: 2.5,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ScrollIndicator extends StatefulWidget {
  @override
  State<_ScrollIndicator> createState() => _ScrollIndicatorState();
}

class _ScrollIndicatorState extends State<_ScrollIndicator>
    with SingleTickerProviderStateMixin {
  late AnimationController _ctrl;
  late Animation<Offset> _offset;

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    )..repeat(reverse: true);
    _offset = Tween<Offset>(
      begin: Offset.zero,
      end: const Offset(0, 0.5),
    ).animate(CurvedAnimation(parent: _ctrl, curve: Curves.easeInOut));
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          'SCROLL DOWN',
          style: GoogleFonts.nunito(
            fontSize: 10,
            letterSpacing: 2,
            color: Colors.white.withValues(alpha: 0.6),
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 8),
        SlideTransition(
          position: _offset,
          child: Icon(
            Icons.keyboard_arrow_down_rounded,
            color: Colors.white.withValues(alpha: 0.7),
            size: 28,
          ),
        ),
      ],
    );
  }
}
