import 'package:flutter/material.dart';

class HeaderBackgroundPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.white.withValues(alpha: 0.08)
      ..style = PaintingStyle.fill;

    final path1 = Path();
    path1.moveTo(0, size.height * 0.35);
    path1.quadraticBezierTo(
      size.width * 0.35,
      size.height * 0.15,
      size.width * 0.7,
      size.height * 0.5,
    );
    path1.quadraticBezierTo(
      size.width * 0.85,
      size.height * 0.65,
      size.width,
      size.height * 0.45,
    );
    path1.lineTo(size.width, 0);
    path1.lineTo(0, 0);
    path1.close();
    canvas.drawPath(path1, paint);

    final path2 = Path();
    path2.moveTo(0, size.height * 0.55);
    path2.quadraticBezierTo(
      size.width * 0.4,
      size.height * 0.8,
      size.width * 0.8,
      size.height * 0.4,
    );
    path2.quadraticBezierTo(
      size.width * 0.9,
      size.height * 0.3,
      size.width,
      size.height * 0.35,
    );
    path2.lineTo(size.width, 0);
    path2.lineTo(0, 0);
    path2.close();
    canvas.drawPath(path2, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class DashedDivider extends StatelessWidget {
  const DashedDivider({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: List.generate(
        35,
        (index) => Expanded(
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 2),
            height: 1,
            color: Colors.white.withValues(alpha: 0.3),
          ),
        ),
      ),
    );
  }
}
