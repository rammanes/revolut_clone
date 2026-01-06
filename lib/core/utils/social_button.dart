import 'package:flutter/material.dart';
import '../../styles/app_colors.dart';

enum SocialButtonType { google, apple, email }

class SocialButton extends StatelessWidget {
  final SocialButtonType type;
  final VoidCallback? onPressed;

  const SocialButton({super.key, required this.type, this.onPressed});

  String get _text {
    switch (type) {
      case SocialButtonType.google:
        return 'Continue with Google';
      case SocialButtonType.apple:
        return 'Continue with Apple';
      case SocialButtonType.email:
        return 'Continue with email';
    }
  }

  Widget get _icon {
    switch (type) {
      case SocialButtonType.google:
        return Container(
          width: 24,
          height: 24,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(4),
            color: Colors.white,
          ),
          child: const Center(
            child: Text(
              'G',
              style: TextStyle(
                color: Colors.blue,
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
          ),
        );
      case SocialButtonType.apple:
        return const Icon(Icons.apple, color: AppColors.white, size: 24);
      case SocialButtonType.email:
        return const Icon(
          Icons.email_outlined,
          color: AppColors.white,
          size: 24,
        );
    }
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 56,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.grey.shade700,
          foregroundColor: AppColors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(28),
          ),
          elevation: 0,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _icon,
            const SizedBox(width: 12),
            Text(
              _text,
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                color: AppColors.white,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
