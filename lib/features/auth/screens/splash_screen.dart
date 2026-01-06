import 'dart:async';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:revolut_clone/core/widgets/app_button.dart';
import 'package:revolut_clone/styles/app_assets.dart';
import 'package:revolut_clone/styles/app_colors.dart';
import 'package:video_player/video_player.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _logoPositionAnimation;
  late Animation<double> _logoFadeAnimation;

  VideoPlayerController? _videoPlayerController;

  bool _showVideo = false;
  bool _showButton = false;

  @override
  void initState() {
    super.initState();
    _setUpAnimations();
    _loadVideo();
    _startAnimationSequence();
  }

  void _setUpAnimations() {
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );

    _logoPositionAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
    );

    _logoFadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
    );
  }

  Future<void> _loadVideo() async {
    _videoPlayerController = VideoPlayerController.asset(AppAssets.splashVideo);
    await _videoPlayerController!.initialize();
    _videoPlayerController!.setLooping(true);
    _videoPlayerController!.play();

    if (mounted) {
      setState(() {});
    }
  }

  void _startAnimationSequence() {
    Timer(const Duration(seconds: 3), () {
      setState(() {
        _showVideo = true;
      });
    });
    _animationController.forward().then((_) {
      setState(() {
        _showButton = true;
      });
    });
  }

  @override
  void dispose() {
    _animationController.dispose();
    _videoPlayerController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.black,
      body: Stack(
        children: [
          if (_showVideo)
            Positioned.fill(
              child:
                  _videoPlayerController != null &&
                      _videoPlayerController!.value.isInitialized
                  ? FittedBox(
                      fit: BoxFit.cover,
                      child: SizedBox(
                        height: _videoPlayerController!.value.size.height,
                        width: _videoPlayerController!.value.size.width,
                        child: VideoPlayer(_videoPlayerController!),
                      ),
                    )
                  : Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [AppColors.primaryDark, AppColors.black],
                        ),
                      ),
                    ),
            ),

          AnimatedBuilder(
            animation: _logoPositionAnimation,
            builder: (context, child) {
              final screenHeight = MediaQuery.sizeOf(context).height;
              final startTop = screenHeight / 2;
              final endTop = 100.00;
              final currentTop =
                  startTop + (endTop - startTop) * _logoFadeAnimation.value;

              return Positioned(
                top: currentTop,
                left: 0,
                right: 0,
                child: FadeTransition(
                  opacity: _logoFadeAnimation,
                  child: Center(
                    child: Text(
                      'Revolut',
                      style: Theme.of(context).textTheme.displayLarge?.copyWith(
                        fontWeight: FontWeight.w700,
                        color: AppColors.white,
                      ),
                    ),
                  ),
                ),
              );
            },
          ),

          if (_showButton)
            Positioned(
              left: 0,
              right: 0,
              bottom: 0,
              child: SafeArea(
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 32,
                    horizontal: 24,
                  ),

                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      AppButton(
                        onPressed: () {
                          context.push('/create-account');
                        },
                        text: 'Create Account',
                        variant: AppButtonVariant.primary,
                      ),

                      const SizedBox(height: 16),

                      AppButton(
                        onPressed: () {
                          context.push('/login');
                        },
                        text: 'Log in',
                        variant: AppButtonVariant.secondary,
                      ),
                    ],
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
