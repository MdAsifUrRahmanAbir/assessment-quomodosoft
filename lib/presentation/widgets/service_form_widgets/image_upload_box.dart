import 'dart:io';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../core/constants/app_assets.dart';
import '../../../core/services/api_endpoint.dart';

class ImageUploadBox extends StatelessWidget {
  const ImageUploadBox({super.key, this.onTap, this.imagePath});
  final VoidCallback? onTap;
  final String? imagePath;

  @override
  Widget build(BuildContext context) {
    const double radius = 12.0;
    const Color strokeColor = Color(0xFF93C5FD);
    const Color brandBlue = Color(0xFF2563EB);

    final bool hasImage = imagePath != null && imagePath!.isNotEmpty;
    final bool isNetwork = hasImage && (imagePath!.startsWith('http') || !File(imagePath!).existsSync());
    final String cleanUrl = hasImage && imagePath!.startsWith('/') ? imagePath!.substring(1) : (imagePath ?? '');
    final String formattedUrl = isNetwork ? (imagePath!.startsWith('http') ? imagePath! : "${ApiEndpoint.mainDomain}/$cleanUrl") : "";

    return GestureDetector(
      onTap: onTap,
      child: CustomPaint(
        foregroundPainter: _DashedBorderPainter(
          color: strokeColor,
          borderRadius: radius,
          strokeWidth: 1.5,
          gap: 4.0,
          dashLength: 6.0,
        ),
        child: Container(
          width: double.infinity,
          height: 95,
          decoration: BoxDecoration(
            color: const Color(0xFFEFF6FF),
            borderRadius: BorderRadius.circular(radius),
          ),
          child: hasImage
              ? ClipRRect(
                  borderRadius: BorderRadius.circular(radius - 1.5),
                  child: isNetwork
                      ? Image.network(formattedUrl, fit: BoxFit.cover)
                      : Image.file(File(imagePath!), fit: BoxFit.cover),
                )
              : Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SvgPicture.asset(
                      AppAssets.imageRectangle,
                      width: 24,
                      height: 24,
                      colorFilter: const ColorFilter.mode(brandBlue, BlendMode.srcIn),
                    ),
                    const SizedBox(width: 8),
                    Text(
                      'Browser Image',
                      style: GoogleFonts.inter(
                        color: brandBlue,
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
        ),
      ),
    );
  }
}

class _DashedBorderPainter extends CustomPainter {
  final Color color;
  final double strokeWidth;
  final double gap;
  final double dashLength;
  final double borderRadius;

  _DashedBorderPainter({
    required this.color,
    this.strokeWidth = 1.0,
    this.gap = 4.0,
    this.dashLength = 6.0,
    this.borderRadius = 8.0,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint()..color = color..strokeWidth = strokeWidth..style = PaintingStyle.stroke;
    final RRect rrect = RRect.fromRectAndRadius(Rect.fromLTWH(0, 0, size.width, size.height), Radius.circular(borderRadius));
    final Path path = Path()..addRRect(rrect);
    final Path dashedPath = Path();
    double distance = 0.0;
    bool draw = true;

    for (final PathMetric measurePath in path.computeMetrics()) {
      while (distance < measurePath.length) {
        final double length = draw ? dashLength : gap;
        if (draw) {
          dashedPath.addPath(measurePath.extractPath(distance, distance + length), Offset.zero);
        }
        distance += length;
        draw = !draw;
      }
    }
    canvas.drawPath(dashedPath, paint);
  }

  @override
  bool shouldRepaint(_DashedBorderPainter oldDelegate) =>
      color != oldDelegate.color ||
      strokeWidth != oldDelegate.strokeWidth ||
      gap != oldDelegate.gap ||
      dashLength != oldDelegate.dashLength ||
      borderRadius != oldDelegate.borderRadius;
}
