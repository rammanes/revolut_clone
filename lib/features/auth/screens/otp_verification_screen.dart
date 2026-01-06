import 'dart:async';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:iconsax/iconsax.dart';
import '../../../styles/app_colors.dart';
import '../../../core/widgets/otp_input.dart';
import '../widgets/circular_icon_button.dart';

class OtpVerificationScreen extends StatefulWidget {
  final String phoneNumber;

  const OtpVerificationScreen({super.key, required this.phoneNumber});

  @override
  State<OtpVerificationScreen> createState() => _OtpVerificationScreenState();
}

class _OtpVerificationScreenState extends State<OtpVerificationScreen> {
  Timer? _timer;
  int _remainingSeconds = 60;
  String _maskedPhoneNumber = '';

  @override
  void initState() {
    super.initState();
    _maskPhoneNumber();
    _startTimer();
  }

  void _maskPhoneNumber() {
    final phone = widget.phoneNumber;
    if (phone.length > 4) {
      final last4 = phone.substring(phone.length - 4);
      final countryCode = phone.length > 8
          ? phone.substring(0, phone.length - 8)
          : '';
      _maskedPhoneNumber = '$countryCode .... $last4';
    } else {
      _maskedPhoneNumber = widget.phoneNumber;
    }
  }

  void _startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_remainingSeconds > 0) {
        setState(() {
          _remainingSeconds--;
        });
      } else {
        timer.cancel();
      }
    });
  }

  String _formatTimer() {
    final minutes = _remainingSeconds ~/ 60;
    final seconds = _remainingSeconds % 60;
    return '${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}';
  }

  void _resendCode() {
    setState(() {
      _remainingSeconds = 60;
    });
    _startTimer();
    // TODO: Resend OTP code
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            stops: const [0.0, 0.3],
            colors: [AppColors.primaryBlue, AppColors.black],
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              AppBar(
                backgroundColor: Colors.transparent,
                elevation: 0,
                leading: Padding(
                  padding: const EdgeInsets.only(left: 16),
                  child: CircularIconButton(
                    icon: Iconsax.arrow_left_2,
                    onTap: () => context.pop(),
                  ),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 32),
                      Text(
                        '6-digit code',
                        style: Theme.of(context).textTheme.displayMedium
                            ?.copyWith(
                              fontWeight: FontWeight.w700,
                              color: AppColors.white,
                            ),
                      ),
                      const SizedBox(height: 16),
                      Text(
                        'Enter the code sent to $_maskedPhoneNumber',
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: AppColors.white.withOpacity(0.8),
                        ),
                      ),
                      const SizedBox(height: 48),
                      // OTP input
                      SizedBox(
                        width: double.infinity,
                        child: OtpInput(
                          length: 6,
                          onCompleted: (code) {
                            // TODO: Verify OTP code
                            log('OTP entered: $code');
                          },
                        ),
                      ),
                      const Spacer(),
                      // Resend code timer
                      Center(
                        child: _remainingSeconds > 0
                            ? Text(
                                'Resend code in ${_formatTimer()}',
                                style: Theme.of(context).textTheme.bodyMedium
                                    ?.copyWith(color: AppColors.white),
                              )
                            : TextButton(
                                onPressed: _resendCode,
                                child: Text(
                                  'Resend code',
                                  style: Theme.of(context).textTheme.bodyMedium
                                      ?.copyWith(color: AppColors.accentBlue),
                                ),
                              ),
                      ),
                      const SizedBox(height: 32),
                    ],
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
