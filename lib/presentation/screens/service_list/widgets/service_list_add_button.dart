import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../core/constants/app_sizes.dart';
import '../../../../core/routes/app_routes.dart';
import '../../../bloc/service/service_cubit.dart';

class ServiceListAddButton extends StatelessWidget {
  const ServiceListAddButton({super.key});

  @override
  Widget build(BuildContext context) {
    const double radius = 10.0;
    const Color strokeColor = Color(0xFFBFDBFE); // Soft blue dashed border
    const Color contentColor = Color(0xFF334155); // Premium dark slate text/icon

    return Padding(
      padding: const EdgeInsets.fromLTRB(AppSizes.paddingM, AppSizes.paddingM, AppSizes.paddingM, 0),
      child: GestureDetector(
        onTap: () async {
          await Navigator.pushNamed(context, AppRoutes.createService);
          if (context.mounted) {
            context.read<ServiceCubit>().loadServices();
          }
        },
        child: CustomPaint(
          foregroundPainter: DashedBorderPainter(color: strokeColor, borderRadius: radius, strokeWidth: 1.2),
          child: Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(vertical: 14),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radius),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 22,
                  height: 22,
                  decoration: BoxDecoration(
                    border: Border.all(color: contentColor, width: 1.2),
                    borderRadius: BorderRadius.circular(4.0),
                  ),
                  child: const Icon(Icons.add, color: contentColor, size: 14),
                ),
                const SizedBox(width: AppSizes.paddingS),
                Text(
                  'Add New Service',
                  style: GoogleFonts.inter(
                    fontSize: AppSizes.fontM,
                    fontWeight: FontWeight.w500,
                    color: contentColor,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class DashedBorderPainter extends CustomPainter {
  final Color color;
  final double strokeWidth;
  final double gap;
  final double dashLength;
  final double borderRadius;

  DashedBorderPainter({
    required this.color,
    this.strokeWidth = 1.0,
    this.gap = 4.0,
    this.dashLength = 6.0,
    this.borderRadius = 8.0,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint()
      ..color = color
      ..strokeWidth = strokeWidth
      ..style = PaintingStyle.stroke;

    final RRect rrect = RRect.fromRectAndRadius(
      Rect.fromLTWH(0, 0, size.width, size.height),
      Radius.circular(borderRadius),
    );

    final Path path = Path()..addRRect(rrect);
    final Path dashedPath = Path();
    double distance = 0.0;
    bool draw = true;

    for (final PathMetric measurePath in path.computeMetrics()) {
      while (distance < measurePath.length) {
        final double length = draw ? dashLength : gap;
        if (draw) {
          dashedPath.addPath(
            measurePath.extractPath(distance, distance + length),
            Offset.zero,
          );
        }
        distance += length;
        draw = !draw;
      }
    }
    canvas.drawPath(dashedPath, paint);
  }

  @override
  bool shouldRepaint(DashedBorderPainter oldDelegate) =>
      color != oldDelegate.color ||
      strokeWidth != oldDelegate.strokeWidth ||
      gap != oldDelegate.gap ||
      dashLength != oldDelegate.dashLength ||
      borderRadius != oldDelegate.borderRadius;
}
