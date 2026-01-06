import 'package:flutter/material.dart';
import '../../styles/app_colors.dart';

enum AppButtonVariant {
  primary, // White background, black text
  secondary, // Dark background, white text
}

class AppButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final String text;
  final AppButtonVariant variant;
  final double? width;
  final double height;
  final bool isFullWidth;

  const AppButton({
    super.key,
    required this.onPressed,
    required this.text,
    this.variant = AppButtonVariant.primary,
    this.width,
    this.height = 56,
    this.isFullWidth = true,
  });

  @override
  Widget build(BuildContext context) {
    final backgroundColor = variant == AppButtonVariant.primary
        ? AppColors.white
        : Colors.grey.shade700;
    final textColor = variant == AppButtonVariant.primary
        ? AppColors.black
        : AppColors.white;

    return SizedBox(
      width: isFullWidth ? double.infinity : width,
      height: height,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: backgroundColor,
          foregroundColor: textColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(28),
          ),
          elevation: 0,
        ),
        child: Text(
          text,
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
            color: textColor,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}
