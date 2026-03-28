import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../app_theme.dart';

class DepartmentSection extends StatelessWidget {
  final VoidCallback? onJoinPressed;
  const DepartmentSection({super.key, this.onJoinPressed});

  @override
  Widget build(BuildContext context) {
    final bool mobile = AppTheme.isMobile(context);

    return ColoredBox(
      color: AppTheme.white,
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: mobile ? 64 : 100),
        child: AppTheme.constrained(
          child: mobile ? _buildMobile(context) : _buildDesktop(context),
        ),
      ),
    );
  }

  Widget _buildDesktop(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(flex: 4, child: _imageBlock()),
        const SizedBox(width: 72),
        Expanded(flex: 5, child: _textContent(context)),
      ],
    );
  }

  Widget _buildMobile(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _imageBlock(),
        const SizedBox(height: 48),
        _textContent(context),
      ],
    );
  }

  Widget _imageBlock() {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(16),
          child: AspectRatio(
            aspectRatio: 4 / 5,
            child: Image.asset('assets/GAIM3.jpg', fit: BoxFit.cover),
          ),
        ),
        Positioned(
          bottom: -20,
          right: -20,
          child: Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: AppTheme.teal,
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: AppTheme.teal.withValues(alpha: 0.4),
                  blurRadius: 24,
                  offset: const Offset(0, 8),
                ),
              ],
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(Icons.groups_rounded,
                    color: Colors.white, size: 32),
                const SizedBox(height: 6),
                Text(
                  'Serve\nTogether',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.nunito(
                    fontSize: 12,
                    fontWeight: FontWeight.w700,
                    color: Colors.white,
                    height: 1.4,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _textContent(BuildContext context) {
    final departments = [
      (Icons.music_note_rounded, 'Choir & Worship Team'),
      (Icons.people_rounded, 'Ushering Department'),
      (Icons.videocam_rounded, 'Media & AV Production'),
      (Icons.child_care_rounded, 'Children\'s Ministry'),
      (Icons.favorite_rounded, 'Prayer Department'),
      (Icons.school_rounded, 'Youth & Young Adults'),
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AppTheme.labelWidget('GET INVOLVED'),
        const SizedBox(height: 20),
        Text(
          'Join a Department\nand Serve God\'s House',
          style: AppTheme.sectionHeading(context),
        ),
        const SizedBox(height: 24),
        Container(width: 56, height: 4,
            decoration: BoxDecoration(
              color: AppTheme.teal,
              borderRadius: BorderRadius.circular(2),
            )),
        const SizedBox(height: 24),
        Text(
          'There\'s a place for everyone in God\'s house. Join one of our service '
          'departments and become part of a team helping to change lives.',
          style: AppTheme.bodyLarge(context),
        ),
        const SizedBox(height: 32),
        Wrap(
          spacing: 12,
          runSpacing: 12,
          children: departments.map((dept) => _DeptChip(
            icon: dept.$1,
            label: dept.$2,
          )).toList(),
        ),
        const SizedBox(height: 40),
        AppTheme.primaryButton(
          text: 'JOIN A DEPARTMENT',
          onPressed: onJoinPressed ?? () {},
        ),
      ],
    );
  }
}

class _DeptChip extends StatefulWidget {
  final IconData icon;
  final String label;
  const _DeptChip({required this.icon, required this.label});

  @override
  State<_DeptChip> createState() => _DeptChipState();
}

class _DeptChipState extends State<_DeptChip> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
        decoration: BoxDecoration(
          color: _hovered ? AppTheme.teal : AppTheme.altBg,
          borderRadius: BorderRadius.circular(50),
          border: Border.all(
            color: _hovered ? AppTheme.teal : AppTheme.divider,
            width: 1.5,
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(widget.icon,
                size: 16,
                color: _hovered ? Colors.white : AppTheme.teal),
            const SizedBox(width: 8),
            Text(
              widget.label,
              style: GoogleFonts.nunito(
                fontSize: 13,
                fontWeight: FontWeight.w600,
                color: _hovered ? Colors.white : AppTheme.bodyText,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
