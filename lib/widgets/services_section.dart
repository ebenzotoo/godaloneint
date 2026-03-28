import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../app_theme.dart';

class ServicesSection extends StatelessWidget {
  final VoidCallback? onJoinPressed;

  const ServicesSection({super.key, this.onJoinPressed});

  @override
  Widget build(BuildContext context) {
    final bool mobile = AppTheme.isMobile(context);

    return ColoredBox(
      color: AppTheme.white,
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: mobile ? 64 : 100),
        child: AppTheme.constrained(
          child: Column(
            children: [
              AppTheme.labelWidget('COME AS YOU ARE'),
              const SizedBox(height: 20),
              Text(
                'Our Weekly Services',
                style: AppTheme.sectionHeading(context),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 16),
              ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 520),
                child: Text(
                  'Join us at any of our services throughout the week. '
                  'There\'s always a place for you at God\'s house.',
                  style: AppTheme.bodyLarge(context),
                  textAlign: TextAlign.center,
                ),
              ),
              const SizedBox(height: 64),
              _buildServiceGrid(context, mobile),
              const SizedBox(height: 64),
              _buildCTABanner(context, mobile),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildServiceGrid(BuildContext context, bool mobile) {
    final services = [
      _ServiceItem(
        icon: Icons.menu_book_rounded,
        day: 'Tuesday',
        shortDay: 'TUE',
        time: '7:00 PM',
        endTime: '8:00 PM',
        name: 'Bible Studies',
        description: 'Deep dive into the Word of God every week.',
        accent: AppTheme.navy,
      ),
      _ServiceItem(
        icon: Icons.auto_awesome_rounded,
        day: 'Thursday',
        shortDay: 'THU',
        time: '7:00 PM',
        endTime: '9:00 PM',
        name: 'Prophetic Service',
        description: 'An atmosphere charged with prophetic ministry.',
        accent: AppTheme.teal,
        featured: true,
      ),
      _ServiceItem(
        icon: Icons.record_voice_over_rounded,
        day: 'Friday',
        shortDay: 'FRI',
        time: '7:00 PM',
        endTime: '9:00 PM',
        name: 'Testimony Hour',
        description: 'Share and hear testimonies of God\'s faithfulness.',
        accent: AppTheme.gold,
      ),
      _ServiceItem(
        icon: Icons.star_rounded,
        day: 'Saturday',
        shortDay: 'SAT',
        time: '7:00 AM',
        endTime: '8:00 AM',
        name: 'Jabez Hour',
        description: 'Early morning power prayer to start your weekend.',
        accent: const Color(0xFF8B5CF6),
      ),
      _ServiceItem(
        icon: Icons.church_rounded,
        day: 'Sunday',
        shortDay: 'SUN',
        time: '8:00 AM',
        endTime: '10:30 AM',
        name: 'Glory Service',
        description: 'Our flagship Sunday gathering — worship, Word & wonder.',
        accent: const Color(0xFFE8403A),
        featured: true,
      ),
    ];

    if (mobile) {
      return Column(
        children: services
            .map((s) => Padding(
                  padding: const EdgeInsets.only(bottom: 16),
                  child: _ServiceCard(item: s, onRegister: onJoinPressed),
                ))
            .toList(),
      );
    }

    // Desktop: 3-top + 2-bottom centered
    return Column(
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: services.take(3).toList().asMap().entries.map((e) {
            return Expanded(
              child: Padding(
                padding: EdgeInsets.only(
                  left: e.key == 0 ? 0 : 10,
                  right: e.key == 2 ? 0 : 10,
                ),
                child: _ServiceCard(item: e.value, onRegister: onJoinPressed),
              ),
            );
          }).toList(),
        ),
        const SizedBox(height: 20),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: services.skip(3).toList().asMap().entries.map((e) {
            return SizedBox(
              width: (MediaQuery.of(context).size.width - 64) / 3.2,
              child: Padding(
                padding: EdgeInsets.only(
                  left: e.key == 0 ? 0 : 10,
                  right: e.key == 1 ? 0 : 10,
                ),
                child: _ServiceCard(item: e.value, onRegister: onJoinPressed),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }

  Widget _buildCTABanner(BuildContext context, bool mobile) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(mobile ? 28 : 48),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [AppTheme.navyDark, AppTheme.navy],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(20),
      ),
      child: mobile
          ? Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _bannerText(context),
                const SizedBox(height: 24),
                Row(
                  children: [
                    AppTheme.primaryButton(
                      text: 'REGISTER NOW',
                      onPressed: onJoinPressed ?? () {},
                    ),
                    const SizedBox(width: 12),
                    _LocationChip(),
                  ],
                ),
              ],
            )
          : Row(
              children: [
                Expanded(child: _bannerText(context)),
                _LocationChip(),
                const SizedBox(width: 20),
                AppTheme.primaryButton(
                  text: 'REGISTER NOW',
                  onPressed: onJoinPressed ?? () {},
                ),
              ],
            ),
    );
  }

  Widget _bannerText(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'We\'d Love to See You!',
          style: GoogleFonts.playfairDisplay(
            fontSize: AppTheme.isMobile(context) ? 20 : 24,
            fontWeight: FontWeight.w700,
            color: Colors.white,
          ),
        ),
        const SizedBox(height: 6),
        Text(
          'Register and let us know you\'re coming.',
          style: AppTheme.footerBody(),
        ),
      ],
    );
  }
}

class _LocationChip extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      decoration: BoxDecoration(
        color: AppTheme.teal.withValues(alpha: 0.15),
        borderRadius: BorderRadius.circular(50),
        border: Border.all(color: AppTheme.teal.withValues(alpha: 0.4)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(Icons.location_on_rounded,
              color: AppTheme.teal, size: 16),
          const SizedBox(width: 8),
          Text(
            'Tema, Ghana',
            style: GoogleFonts.nunito(
              fontSize: 13,
              fontWeight: FontWeight.w600,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}

// ─── Data model ───────────────────────────────────────────────────────────────

class _ServiceItem {
  final IconData icon;
  final String day;
  final String shortDay;
  final String time;
  final String endTime;
  final String name;
  final String description;
  final Color accent;
  final bool featured;

  const _ServiceItem({
    required this.icon,
    required this.day,
    required this.shortDay,
    required this.time,
    required this.endTime,
    required this.name,
    required this.description,
    required this.accent,
    this.featured = false,
  });
}

// ─── Card widget ──────────────────────────────────────────────────────────────

class _ServiceCard extends StatefulWidget {
  final _ServiceItem item;
  final VoidCallback? onRegister;
  const _ServiceCard({required this.item, this.onRegister});

  @override
  State<_ServiceCard> createState() => _ServiceCardState();
}

class _ServiceCardState extends State<_ServiceCard> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    final item = widget.item;

    return MouseRegion(
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 250),
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          color: item.featured ? item.accent : Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: item.featured
              ? null
              : Border.all(
                  color: _hovered ? item.accent : AppTheme.divider,
                  width: 1.5,
                ),
          boxShadow: [
            BoxShadow(
              color: item.accent.withValues(
                  alpha: item.featured ? 0.3 : (_hovered ? 0.15 : 0.05)),
              blurRadius: _hovered ? 28 : 12,
              offset: const Offset(0, 6),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Top row: icon + day badge
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: (item.featured ? Colors.white : item.accent)
                        .withValues(alpha: item.featured ? 0.2 : 0.1),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Icon(
                    item.icon,
                    size: 20,
                    color: item.featured ? Colors.white : item.accent,
                  ),
                ),
                const Spacer(),
                Container(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 10, vertical: 5),
                  decoration: BoxDecoration(
                    color: (item.featured ? Colors.white : item.accent)
                        .withValues(alpha: item.featured ? 0.2 : 0.1),
                    borderRadius: BorderRadius.circular(50),
                  ),
                  child: Text(
                    item.shortDay,
                    style: GoogleFonts.nunito(
                      fontSize: 11,
                      fontWeight: FontWeight.w800,
                      letterSpacing: 1.5,
                      color: item.featured ? Colors.white : item.accent,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),

            // Service name
            Text(
              item.name,
              style: GoogleFonts.playfairDisplay(
                fontSize: 18,
                fontWeight: FontWeight.w700,
                color: item.featured ? Colors.white : AppTheme.navyDark,
                height: 1.2,
              ),
            ),
            const SizedBox(height: 6),

            // Day
            Text(
              item.day,
              style: GoogleFonts.nunito(
                fontSize: 13,
                fontWeight: FontWeight.w600,
                color: item.featured
                    ? Colors.white.withValues(alpha: 0.75)
                    : AppTheme.bodyText,
              ),
            ),
            const SizedBox(height: 12),

            // Time block
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              decoration: BoxDecoration(
                color: (item.featured ? Colors.white : item.accent)
                    .withValues(alpha: item.featured ? 0.15 : 0.08),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.access_time_rounded,
                    size: 14,
                    color: item.featured ? Colors.white : item.accent,
                  ),
                  const SizedBox(width: 6),
                  Text(
                    '${item.time} – ${item.endTime}',
                    style: GoogleFonts.nunito(
                      fontSize: 13,
                      fontWeight: FontWeight.w700,
                      color: item.featured ? Colors.white : item.accent,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 14),

            // Description
            Text(
              item.description,
              style: GoogleFonts.nunito(
                fontSize: 13,
                color: item.featured
                    ? Colors.white.withValues(alpha: 0.8)
                    : AppTheme.bodyText,
                height: 1.6,
              ),
            ),
            const SizedBox(height: 20),

            // Register link
            GestureDetector(
              onTap: widget.onRegister,
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'Register',
                    style: GoogleFonts.nunito(
                      fontSize: 13,
                      fontWeight: FontWeight.w700,
                      color: item.featured ? Colors.white : item.accent,
                      decoration: TextDecoration.underline,
                      decorationColor:
                          item.featured ? Colors.white : item.accent,
                    ),
                  ),
                  const SizedBox(width: 4),
                  Icon(
                    Icons.arrow_forward_rounded,
                    size: 14,
                    color: item.featured ? Colors.white : item.accent,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
