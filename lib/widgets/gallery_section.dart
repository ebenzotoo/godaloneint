import 'package:flutter/material.dart';
import '../app_theme.dart';

class GallerySection extends StatelessWidget {
  const GallerySection({super.key});

  static const _images = [
    'assets/GAIM2.jpg',
    'assets/GAIM3.jpg',
    'assets/GAIM4.jpg',
    'assets/GAIM5.png',
  ];

  @override
  Widget build(BuildContext context) {
    final bool mobile = AppTheme.isMobile(context);

    return ColoredBox(
      color: AppTheme.navyDark,
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: mobile ? 64 : 100),
        child: Column(
          children: [
            AppTheme.constrained(
              child: Column(
                children: [
                  AppTheme.labelWidget('GALLERY', light: true),
                  const SizedBox(height: 20),
                  Text(
                    'Our Moments Together',
                    style: AppTheme.sectionHeadingLight(context),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'Glimpses of God\'s goodness in our community.',
                    style: AppTheme.bodyLargeLight(context),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 56),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: mobile ? 20 : 32),
              child: mobile
                  ? _buildMobileGrid()
                  : _buildDesktopGrid(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDesktopGrid() {
    return Row(
      children: [
        // Large image on left
        Expanded(
          flex: 5,
          child: _GalleryImage(
            imageAsset: _images[0],
            height: 500,
          ),
        ),
        const SizedBox(width: 12),
        // Two stacked on the right
        Expanded(
          flex: 3,
          child: Column(
            children: [
              _GalleryImage(imageAsset: _images[1], height: 244),
              const SizedBox(height: 12),
              _GalleryImage(imageAsset: _images[2], height: 244),
            ],
          ),
        ),
        const SizedBox(width: 12),
        // One tall on far right
        Expanded(
          flex: 3,
          child: _GalleryImage(imageAsset: _images[3], height: 500),
        ),
      ],
    );
  }

  Widget _buildMobileGrid() {
    return Column(
      children: [
        _GalleryImage(imageAsset: _images[0], height: 240),
        const SizedBox(height: 8),
        Row(
          children: [
            Expanded(child: _GalleryImage(imageAsset: _images[1], height: 180)),
            const SizedBox(width: 8),
            Expanded(child: _GalleryImage(imageAsset: _images[2], height: 180)),
          ],
        ),
        const SizedBox(height: 8),
        _GalleryImage(imageAsset: _images[3], height: 200),
      ],
    );
  }
}

class _GalleryImage extends StatefulWidget {
  final String imageAsset;
  final double height;

  const _GalleryImage({required this.imageAsset, required this.height});

  @override
  State<_GalleryImage> createState() => _GalleryImageState();
}

class _GalleryImageState extends State<_GalleryImage> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: SizedBox(
          height: widget.height,
          width: double.infinity,
          child: Stack(
            fit: StackFit.expand,
            children: [
              AnimatedScale(
                scale: _hovered ? 1.06 : 1.0,
                duration: const Duration(milliseconds: 400),
                curve: Curves.easeOut,
                child: Image.asset(
                  widget.imageAsset,
                  fit: BoxFit.cover,
                ),
              ),
              AnimatedOpacity(
                opacity: _hovered ? 1.0 : 0.0,
                duration: const Duration(milliseconds: 300),
                child: Container(
                  color: AppTheme.teal.withValues(alpha: 0.3),
                  child: Center(
                    child: Icon(
                      Icons.zoom_in_rounded,
                      color: Colors.white,
                      size: 40,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
