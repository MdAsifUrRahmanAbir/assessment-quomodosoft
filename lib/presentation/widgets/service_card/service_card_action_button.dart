import 'package:flutter/material.dart';

class ServiceCardActionButton extends StatelessWidget {
  const ServiceCardActionButton({
    super.key,
    required this.iconPath,
    this.onTap,
  });

  final String iconPath;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Image.asset(
        iconPath,
        width: 32,
        height: 32,
      ),
    );
  }
}
