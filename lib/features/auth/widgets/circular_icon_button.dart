import 'package:flutter/material.dart';
import 'package:revolut_clone/styles/app_colors.dart';

class CircularIconButton extends StatelessWidget {
  const CircularIconButton({
    super.key,

    this.size = 40,
    this.borderColor,
    this.iconColor,
    required this.icon,
    this.onTap,
  });

  final double size;
  final Color? iconColor;
  final Color? borderColor;
  final IconData icon;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final defaultIconColor = iconColor ?? AppColors.white;
    final defaultBorderColor = borderColor ?? AppColors.white.withOpacity(0.3);
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: size,
        width: size,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(width: 1.5, color: defaultBorderColor),
          boxShadow: [
            BoxShadow(
              color: defaultBorderColor.withOpacity(.5),
              blurRadius: 8,
              spreadRadius: 0,
            ),
          ],
        ),
        child: Center(
          child: Icon(icon, color: defaultIconColor, size: size * 0.5),
        ),
      ),
    );
  }
}
