import 'package:flutter/material.dart';
import '../app_theme.dart';

class AboutSection extends StatelessWidget {
  const AboutSection({super.key});

  @override
  Widget build(BuildContext context) {
    final bool mobile = AppTheme.isMobile(context);

    return Container(
      color: AppTheme.white,
      padding: EdgeInsets.symmetric(
        vertical: mobile ? 64 : 100,
      ),
      child: AppTheme.constrained(
        child: mobile ? _buildMobile(context) : _buildDesktop(context),
      ),
    );
  }

  Widget _buildDesktop(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(flex: 5, child: _textContent(context)),
        const SizedBox(width: 72),
        Expanded(flex: 4, child: _imageBlock()),
      ],
    );
  }

  Widget _buildMobile(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _textContent(context),
        const SizedBox(height: 40),
        _imageBlock(),
      ],
    );
  }

  Widget _textContent(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AppTheme.labelWidget('WHO WE ARE'),
        const SizedBox(height: 20),
        Text(
          'A House of God Built on\nFaith, Love & Purpose',
          style: AppTheme.sectionHeading(context),
        ),
        const SizedBox(height: 24),
        Container(
          width: 56,
          height: 4,
          decoration: BoxDecoration(
            color: AppTheme.teal,
            borderRadius: BorderRadius.circular(2),
          ),
        ),
        const SizedBox(height: 28),
        Text(
          'God Alone International Ministry is a spirit-filled, multi-cultural, '
          'kingdom prosperity centred church numbering in thousands — impacting '
          'our city, our nation, and our world through leadership and by the Holy Ghost.',
          style: AppTheme.bodyLarge(context),
        ),
        const SizedBox(height: 20),
        Text(
          'We believe in the power of prayer, the authority of the Word, and the '
          'transforming grace of God. Every service, every event, and every ministry '
          'arm is dedicated to seeing lives changed for the glory of God.',
          style: AppTheme.bodyLarge(context),
        ),
        const SizedBox(height: 40),
        _StatRow(),
      ],
    );
  }

  Widget _imageBlock() {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        // Main image
        ClipRRect(
          borderRadius: BorderRadius.circular(16),
          child: AspectRatio(
            aspectRatio: 4 / 5,
            child: Image.asset(
              'assets/GAIM2.jpg',
              fit: BoxFit.cover,
            ),
          ),
        ),
        // Decorative accent box
        Positioned(
          bottom: -24,
          left: -24,
          child: Container(
            width: 120,
            height: 120,
            decoration: BoxDecoration(
              color: AppTheme.teal.withValues(alpha: 0.15),
              borderRadius: BorderRadius.circular(12),
            ),
          ),
        ),
        // Years badge
        Positioned(
          top: 24,
          right: -20,
          child: Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: AppTheme.navyDark,
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: AppTheme.navyDark.withValues(alpha: 0.3),
                  blurRadius: 24,
                  offset: const Offset(0, 8),
                ),
              ],
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  '10+',
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.w800,
                    color: AppTheme.teal,
                    height: 1,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  'Years of\nMinistry',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 11,
                    color: Colors.white70,
                    height: 1.5,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class _StatRow extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final stats = [
      ('1000+', 'Members'),
      ('50+', 'Ministries'),
      ('3', 'Services/Week'),
    ];
    return Row(
      children: stats.asMap().entries.map((e) {
        final i = e.key;
        final s = e.value;
        return Expanded(
          child: Row(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    s.$1,
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.w800,
                      color: AppTheme.navy,
                      height: 1,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    s.$2,
                    style: AppTheme.bodyMedium().copyWith(fontSize: 13),
                  ),
                ],
              ),
              if (i < stats.length - 1)
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 16),
                  width: 1,
                  height: 40,
                  color: AppTheme.divider,
                ),
            ],
          ),
        );
      }).toList(),
    );
  }
}
