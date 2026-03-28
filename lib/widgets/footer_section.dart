import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../app_theme.dart';

class FooterSection extends StatefulWidget {
  const FooterSection({super.key});

  @override
  State<FooterSection> createState() => _FooterSectionState();
}

class _FooterSectionState extends State<FooterSection> {
  final _emailController = TextEditingController();
  bool _subscribed = false;

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final bool mobile = AppTheme.isMobile(context);

    return Column(
      children: [
        // Wave divider
        _WaveDivider(),
        // Main footer body
        ColoredBox(
          color: AppTheme.navyDark,
          child: Padding(
            padding: EdgeInsets.only(
              top: 0,
              bottom: 48,
              left: 32,
              right: 32,
            ),
            child: AppTheme.constrained(
              padding: EdgeInsets.zero,
              child: mobile
                  ? _buildMobileLayout(context)
                  : _buildDesktopLayout(context),
            ),
          ),
        ),
        // Bottom bar
        ColoredBox(
          color: const Color(0xFF07111F),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 32),
            child: AppTheme.constrained(
              padding: EdgeInsets.zero,
              child: mobile
                  ? Column(
                      children: [
                        _copyrightText(),
                        const SizedBox(height: 8),
                        _socialIcons(),
                      ],
                    )
                  : Row(
                      children: [
                        _copyrightText(),
                        const Spacer(),
                        _socialIcons(),
                      ],
                    ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildDesktopLayout(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(flex: 3, child: _aboutColumn()),
        const SizedBox(width: 48),
        Expanded(flex: 2, child: _contactColumn()),
        const SizedBox(width: 48),
        Expanded(flex: 3, child: _newsletterColumn(context)),
      ],
    );
  }

  Widget _buildMobileLayout(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _aboutColumn(),
        const SizedBox(height: 48),
        _contactColumn(),
        const SizedBox(height: 48),
        _newsletterColumn(context),
      ],
    );
  }

  Widget _aboutColumn() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              width: 44,
              height: 44,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white,
              ),
              child: ClipOval(
                child: Image.asset('assets/GAIM logo.png', fit: BoxFit.cover),
              ),
            ),
            const SizedBox(width: 12),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'GOD ALONE',
                  style: GoogleFonts.playfairDisplay(
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                    color: Colors.white,
                    letterSpacing: 1.5,
                  ),
                ),
                Text(
                  'INTERNATIONAL MINISTRY',
                  style: GoogleFonts.nunito(
                    fontSize: 9,
                    color: AppTheme.teal,
                    letterSpacing: 2.0,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ],
        ),
        const SizedBox(height: 20),
        Text(
          'God Alone International Ministry is a spirit-filled, multi-cultural, '
          'kingdom prosperity centred church — impacting our city, our nation, '
          'and our world through leadership and by the Holy Ghost.',
          style: AppTheme.footerBody(),
        ),
        const SizedBox(height: 24),
        Wrap(
          spacing: 8,
          children: [
            _SocialButton(icon: Icons.facebook_rounded, label: 'Facebook'),
            _SocialButton(icon: Icons.play_circle_fill_rounded, label: 'YouTube'),
            _SocialButton(icon: Icons.camera_alt_rounded, label: 'Instagram'),
          ],
        ),
      ],
    );
  }

  Widget _contactColumn() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('CONTACT US', style: AppTheme.footerLabel()),
        const SizedBox(height: 4),
        Container(width: 32, height: 2, color: AppTheme.teal),
        const SizedBox(height: 24),
        _ContactItem(
          icon: Icons.location_on_rounded,
          text: 'Devtraco Junction, Comm 18\nTema, Ghana',
        ),
        const SizedBox(height: 16),
        _ContactItem(
          icon: Icons.phone_rounded,
          text: '+233 54 591 3298\n+233 24 077 7905',
        ),
        const SizedBox(height: 16),
        _ContactItem(
          icon: Icons.email_rounded,
          text: 'contact@godaloneint.org',
        ),
        const SizedBox(height: 24),
        _QuickLinks(),
      ],
    );
  }

  Widget _newsletterColumn(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('NEWSLETTER', style: AppTheme.footerLabel()),
        const SizedBox(height: 4),
        Container(width: 32, height: 2, color: AppTheme.teal),
        const SizedBox(height: 24),
        Text(
          'Read Pastor\'s Blog & stay updated on upcoming events, messages, and more.',
          style: AppTheme.footerBody(),
        ),
        const SizedBox(height: 24),
        if (!_subscribed) ...[
          Container(
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.08),
              borderRadius: BorderRadius.circular(50),
              border: Border.all(
                  color: Colors.white.withValues(alpha: 0.1), width: 1),
            ),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _emailController,
                    style: GoogleFonts.nunito(color: Colors.white, fontSize: 14),
                    decoration: InputDecoration(
                      hintText: 'Your email address…',
                      hintStyle: GoogleFonts.nunito(
                        color: AppTheme.lightText,
                        fontSize: 14,
                      ),
                      border: InputBorder.none,
                      contentPadding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 14),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(4),
                  child: TextButton(
                    onPressed: () {
                      if (_emailController.text.isNotEmpty) {
                        setState(() => _subscribed = true);
                      }
                    },
                    style: TextButton.styleFrom(
                      backgroundColor: AppTheme.teal,
                      shape: const CircleBorder(),
                      padding: const EdgeInsets.all(12),
                    ),
                    child: const Icon(Icons.arrow_forward_rounded,
                        color: Colors.white, size: 20),
                  ),
                ),
              ],
            ),
          ),
        ] else ...[
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
            decoration: BoxDecoration(
              color: AppTheme.teal.withValues(alpha: 0.15),
              borderRadius: BorderRadius.circular(50),
              border: Border.all(color: AppTheme.teal, width: 1),
            ),
            child: Row(
              children: [
                const Icon(Icons.check_circle_rounded,
                    color: AppTheme.teal, size: 20),
                const SizedBox(width: 10),
                Text(
                  'You\'re subscribed!',
                  style: GoogleFonts.nunito(
                    color: AppTheme.teal,
                    fontWeight: FontWeight.w700,
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ),
        ],
      ],
    );
  }

  Widget _copyrightText() {
    return Text(
      '© ${DateTime.now().year} God Alone International Ministry. All rights reserved.',
      style: GoogleFonts.nunito(
        fontSize: 12,
        color: AppTheme.lightText,
      ),
    );
  }

  Widget _socialIcons() {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        _SocialIconButton(icon: Icons.facebook_rounded),
        _SocialIconButton(icon: Icons.play_circle_fill_rounded),
        _SocialIconButton(icon: Icons.camera_alt_rounded),
        _SocialIconButton(icon: Icons.link_rounded),
      ],
    );
  }
}

class _ContactItem extends StatelessWidget {
  final IconData icon;
  final String text;
  const _ContactItem({required this.icon, required this.text});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, color: AppTheme.teal, size: 18),
        const SizedBox(width: 12),
        Expanded(
          child: Text(text, style: AppTheme.footerBody()),
        ),
      ],
    );
  }
}

class _QuickLinks extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final links = ['Home', 'About', 'Events', 'Contact'];
    return Wrap(
      spacing: 16,
      runSpacing: 8,
      children: links.map((l) => _FooterLink(label: l)).toList(),
    );
  }
}

class _FooterLink extends StatefulWidget {
  final String label;
  const _FooterLink({required this.label});

  @override
  State<_FooterLink> createState() => _FooterLinkState();
}

class _FooterLinkState extends State<_FooterLink> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      child: GestureDetector(
        onTap: () {},
        child: Text(
          widget.label,
          style: GoogleFonts.nunito(
            fontSize: 13,
            color: _hovered ? AppTheme.teal : AppTheme.lightText,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}

class _SocialButton extends StatefulWidget {
  final IconData icon;
  final String label;
  const _SocialButton({required this.icon, required this.label});

  @override
  State<_SocialButton> createState() => _SocialButtonState();
}

class _SocialButtonState extends State<_SocialButton> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 7),
        decoration: BoxDecoration(
          color: _hovered
              ? AppTheme.teal
              : Colors.white.withValues(alpha: 0.08),
          borderRadius: BorderRadius.circular(50),
          border: Border.all(
            color: _hovered ? AppTheme.teal : Colors.white.withValues(alpha: 0.1),
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(widget.icon,
                size: 15, color: _hovered ? Colors.white : AppTheme.lightText),
            const SizedBox(width: 6),
            Text(
              widget.label,
              style: GoogleFonts.nunito(
                fontSize: 12,
                color: _hovered ? Colors.white : AppTheme.lightText,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _SocialIconButton extends StatefulWidget {
  final IconData icon;
  const _SocialIconButton({required this.icon});

  @override
  State<_SocialIconButton> createState() => _SocialIconButtonState();
}

class _SocialIconButtonState extends State<_SocialIconButton> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        margin: const EdgeInsets.only(left: 8),
        width: 36,
        height: 36,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: _hovered
              ? AppTheme.teal
              : Colors.white.withValues(alpha: 0.08),
        ),
        child: Icon(widget.icon,
            size: 18,
            color: _hovered ? Colors.white : AppTheme.lightText),
      ),
    );
  }
}

class _WaveDivider extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 60,
      width: double.infinity,
      child: CustomPaint(
        painter: _WavePainter(),
      ),
    );
  }
}

class _WavePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final topPaint = Paint()..color = AppTheme.white;
    canvas.drawRect(Rect.fromLTWH(0, 0, size.width, size.height), topPaint);

    final wavePaint = Paint()..color = AppTheme.navyDark;
    final path = Path();
    path.moveTo(0, size.height);
    path.lineTo(0, size.height * 0.4);
    path.quadraticBezierTo(
      size.width * 0.25, size.height * 0.0,
      size.width * 0.5, size.height * 0.35,
    );
    path.quadraticBezierTo(
      size.width * 0.75, size.height * 0.7,
      size.width, size.height * 0.3,
    );
    path.lineTo(size.width, size.height);
    path.close();
    canvas.drawPath(path, wavePaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
