import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../app_theme.dart';

class MissionSection extends StatelessWidget {
  const MissionSection({super.key});

  @override
  Widget build(BuildContext context) {
    final bool mobile = AppTheme.isMobile(context);

    return ColoredBox(
      color: AppTheme.altBg,
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: mobile ? 64 : 100),
        child: AppTheme.constrained(
          child: Column(
            children: [
              AppTheme.labelWidget('OUR FOUNDATION'),
              const SizedBox(height: 20),
              Text(
                'Mission, Vision & Values',
                style: AppTheme.sectionHeading(context),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 16),
              ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 560),
                child: Text(
                  'Everything we do flows from what we believe. '
                  'These are the core pillars that define who we are and where we\'re going.',
                  style: AppTheme.bodyLarge(context),
                  textAlign: TextAlign.center,
                ),
              ),
              const SizedBox(height: 64),
              _buildCards(context, mobile),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCards(BuildContext context, bool mobile) {
    final items = [
      _MissionItem(
        icon: Icons.favorite_rounded,
        color: AppTheme.teal,
        title: 'Our Mission',
        description:
            'To grow in faith and share our faith in God with the world around us — '
            'making disciples of all nations through the power of the Holy Spirit.',
      ),
      _MissionItem(
        icon: Icons.visibility_rounded,
        color: AppTheme.navy,
        title: 'Our Vision',
        description:
            'To be a global ministry that transforms lives, builds families, and '
            'raises kingdom leaders who impact every sphere of society for God\'s glory.',
      ),
      _MissionItem(
        icon: Icons.star_rounded,
        color: AppTheme.gold,
        title: 'Our Values',
        description:
            'Faith, Integrity, Excellence, Community and Service — we uphold these '
            'values in every ministry, every service, and every relationship.',
      ),
    ];

    if (mobile) {
      return Column(
        children: items
            .map((item) => Padding(
                  padding: const EdgeInsets.only(bottom: 24),
                  child: _MissionCard(item: item),
                ))
            .toList(),
      );
    }

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: items.asMap().entries.map((e) {
        return Expanded(
          child: Padding(
            padding: EdgeInsets.only(
              left: e.key == 0 ? 0 : 12,
              right: e.key == items.length - 1 ? 0 : 12,
            ),
            child: _MissionCard(item: e.value),
          ),
        );
      }).toList(),
    );
  }
}

class _MissionItem {
  final IconData icon;
  final Color color;
  final String title;
  final String description;

  const _MissionItem({
    required this.icon,
    required this.color,
    required this.title,
    required this.description,
  });
}

class _MissionCard extends StatefulWidget {
  final _MissionItem item;
  const _MissionCard({required this.item});

  @override
  State<_MissionCard> createState() => _MissionCardState();
}

class _MissionCardState extends State<_MissionCard> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 250),
        padding: const EdgeInsets.all(36),
        decoration: BoxDecoration(
          color: _hovered ? AppTheme.navyDark : Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: AppTheme.navyDark.withValues(alpha: _hovered ? 0.2 : 0.06),
              blurRadius: _hovered ? 40 : 20,
              offset: const Offset(0, 8),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 64,
              height: 64,
              decoration: BoxDecoration(
                color: widget.item.color.withValues(alpha: _hovered ? 0.2 : 0.12),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Icon(
                widget.item.icon,
                color: _hovered ? Colors.white : widget.item.color,
                size: 28,
              ),
            ),
            const SizedBox(height: 24),
            Text(
              widget.item.title,
              style: AppTheme.cardTitle(context).copyWith(
                color: _hovered ? Colors.white : AppTheme.navyDark,
              ),
            ),
            const SizedBox(height: 12),
            Container(width: 32, height: 3, color: widget.item.color),
            const SizedBox(height: 16),
            Text(
              widget.item.description,
              style: GoogleFonts.nunito(
                fontSize: 15,
                color: _hovered
                    ? Colors.white.withValues(alpha: 0.75)
                    : AppTheme.bodyText,
                height: 1.7,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
