import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../app_theme.dart';

class NavBar extends StatefulWidget {
  final bool isScrolled;
  final VoidCallback? onHomePressed;
  final VoidCallback? onAboutPressed;
  final VoidCallback? onEventsPressed;
  final VoidCallback? onContactPressed;
  final GlobalKey<ScaffoldState>? scaffoldKey;

  const NavBar({
    super.key,
    required this.isScrolled,
    this.onHomePressed,
    this.onAboutPressed,
    this.onEventsPressed,
    this.onContactPressed,
    this.scaffoldKey,
  });

  @override
  State<NavBar> createState() => _NavBarState();
}

class _NavBarState extends State<NavBar> with SingleTickerProviderStateMixin {
  late AnimationController _animController;
  late Animation<Color?> _bgColor;

  @override
  void initState() {
    super.initState();
    _animController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
    _bgColor = ColorTween(
      begin: Colors.transparent,
      end: AppTheme.navyDark,
    ).animate(_animController);
  }

  @override
  void didUpdateWidget(NavBar oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.isScrolled) {
      _animController.forward();
    } else {
      _animController.reverse();
    }
  }

  @override
  void dispose() {
    _animController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final bool mobile = AppTheme.isMobile(context);

    return AnimatedBuilder(
      animation: _animController,
      builder: (context, child) {
        return Container(
          decoration: BoxDecoration(
            color: _bgColor.value,
            boxShadow: widget.isScrolled
                ? [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.2),
                      blurRadius: 20,
                      offset: const Offset(0, 4),
                    )
                  ]
                : [],
          ),
          child: child,
        );
      },
      child: SafeArea(
        child: AppTheme.constrained(
          padding: EdgeInsets.symmetric(
            horizontal: mobile ? 20 : 32,
            vertical: 0,
          ),
          child: SizedBox(
            height: 80,
            child: Row(
              children: [
                // Logo
                _Logo(isScrolled: widget.isScrolled),
                const Spacer(),

                if (mobile) ...[
                  IconButton(
                    onPressed: () =>
                        widget.scaffoldKey?.currentState?.openEndDrawer(),
                    icon: Icon(
                      Icons.menu_rounded,
                      color: Colors.white,
                      size: 28,
                    ),
                  ),
                ] else ...[
                  _NavLinks(
                    isScrolled: widget.isScrolled,
                    onHomePressed: widget.onHomePressed,
                    onAboutPressed: widget.onAboutPressed,
                    onEventsPressed: widget.onEventsPressed,
                    onContactPressed: widget.onContactPressed,
                  ),
                  const SizedBox(width: 32),
                  AppTheme.primaryButton(
                    text: 'JOIN US',
                    onPressed: widget.onContactPressed ?? () {},
                    minWidth: 120,
                  ),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _Logo extends StatelessWidget {
  final bool isScrolled;
  const _Logo({required this.isScrolled});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 48,
          height: 48,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.15),
                blurRadius: 10,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: ClipOval(
            child: Image.asset(
              'assets/GAIM logo.png',
              fit: BoxFit.cover,
            ),
          ),
        ),
        const SizedBox(width: 12),
        Column(
          mainAxisSize: MainAxisSize.min,
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
                fontWeight: FontWeight.w600,
                color: AppTheme.teal,
                letterSpacing: 2.0,
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class _NavLinks extends StatelessWidget {
  final bool isScrolled;
  final VoidCallback? onHomePressed;
  final VoidCallback? onAboutPressed;
  final VoidCallback? onEventsPressed;
  final VoidCallback? onContactPressed;

  const _NavLinks({
    required this.isScrolled,
    this.onHomePressed,
    this.onAboutPressed,
    this.onEventsPressed,
    this.onContactPressed,
  });

  @override
  Widget build(BuildContext context) {
    final links = [
      ('HOME', onHomePressed),
      ('ABOUT', onAboutPressed),
      ('EVENTS', onEventsPressed),
      ('CONTACT', onContactPressed),
    ];
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: links.map((item) {
        return _NavLinkItem(
          label: item.$1,
          onTap: item.$2,
        );
      }).toList(),
    );
  }
}

class _NavLinkItem extends StatefulWidget {
  final String label;
  final VoidCallback? onTap;
  const _NavLinkItem({required this.label, this.onTap});

  @override
  State<_NavLinkItem> createState() => _NavLinkItemState();
}

class _NavLinkItemState extends State<_NavLinkItem> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      child: GestureDetector(
        onTap: widget.onTap,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                widget.label,
                style: AppTheme.navLink(light: true).copyWith(
                  color: _hovered ? AppTheme.teal : Colors.white,
                ),
              ),
              const SizedBox(height: 3),
              AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                width: _hovered ? 20 : 0,
                height: 2,
                color: AppTheme.teal,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// Drawer for mobile navigation
class NavDrawer extends StatelessWidget {
  final VoidCallback? onHomePressed;
  final VoidCallback? onAboutPressed;
  final VoidCallback? onEventsPressed;
  final VoidCallback? onContactPressed;

  const NavDrawer({
    super.key,
    this.onHomePressed,
    this.onAboutPressed,
    this.onEventsPressed,
    this.onContactPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: AppTheme.navyDark,
      child: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(24),
              child: Row(
                children: [
                  Container(
                    width: 48,
                    height: 48,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.white,
                    ),
                    child: ClipOval(
                      child: Image.asset(
                        'assets/GAIM logo.png',
                        fit: BoxFit.cover,
                      ),
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
                        ),
                      ),
                      Text(
                        'INTERNATIONAL MINISTRY',
                        style: GoogleFonts.nunito(
                          fontSize: 9,
                          color: AppTheme.teal,
                          letterSpacing: 1.5,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const Divider(color: Colors.white12),
            const SizedBox(height: 16),
            _DrawerLink(
                label: 'HOME',
                icon: Icons.home_rounded,
                onTap: () {
                  Navigator.pop(context);
                  onHomePressed?.call();
                }),
            _DrawerLink(
                label: 'ABOUT',
                icon: Icons.info_rounded,
                onTap: () {
                  Navigator.pop(context);
                  onAboutPressed?.call();
                }),
            _DrawerLink(
                label: 'EVENTS',
                icon: Icons.event_rounded,
                onTap: () {
                  Navigator.pop(context);
                  onEventsPressed?.call();
                }),
            _DrawerLink(
                label: 'CONTACT',
                icon: Icons.contact_mail_rounded,
                onTap: () {
                  Navigator.pop(context);
                  onContactPressed?.call();
                }),
            const SizedBox(height: 32),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: AppTheme.primaryButton(
                text: 'JOIN US THIS WEEKEND',
                onPressed: () {
                  Navigator.pop(context);
                  onContactPressed?.call();
                },
                minWidth: double.infinity,
              ),
            ),
            const Spacer(),
            Padding(
              padding: const EdgeInsets.all(24),
              child: Text(
                '+233 54 591 3298\ncontact@godaloneint.org',
                style: AppTheme.footerBody(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _DrawerLink extends StatelessWidget {
  final String label;
  final IconData icon;
  final VoidCallback? onTap;

  const _DrawerLink(
      {required this.label, required this.icon, this.onTap});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(icon, color: AppTheme.teal, size: 22),
      title: Text(
        label,
        style: GoogleFonts.nunito(
          color: Colors.white,
          fontWeight: FontWeight.w700,
          letterSpacing: 1.5,
          fontSize: 14,
        ),
      ),
      onTap: onTap,
      horizontalTitleGap: 8,
      contentPadding: const EdgeInsets.symmetric(horizontal: 24, vertical: 4),
    );
  }
}
