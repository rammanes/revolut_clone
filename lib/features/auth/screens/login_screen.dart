import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:iconsax/iconsax.dart';
import 'package:country_picker/country_picker.dart';
import '../../../core/utils/social_button.dart';
import '../../../styles/app_colors.dart';
import '../../../core/widgets/app_button.dart';
import '../widgets/circular_icon_button.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  Country _selectedCountry = Country.parse('GB');
  final TextEditingController _phoneController = TextEditingController();

  @override
  void dispose() {
    _phoneController.dispose();
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
                actions: [
                  Padding(
                    padding: const EdgeInsets.only(right: 16),
                    child: CircularIconButton(
                      icon: Icons.help_outline,
                      onTap: () {
                        // Handle help action
                      },
                    ),
                  ),
                ],
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 32),
                      Text(
                        'Welcome back',
                        style: Theme.of(context).textTheme.displayMedium
                            ?.copyWith(
                              fontWeight: FontWeight.w700,
                              color: AppColors.white,
                            ),
                      ),
                      const SizedBox(height: 16),
                      Text(
                        'Enter the phone number associated with your Revolut account',
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: AppColors.white.withOpacity(0.8),
                        ),
                      ),
                      const SizedBox(height: 32),
                      // Phone number input - separated fields
                      Row(
                        children: [
                          // Country code field
                          GestureDetector(
                            onTap: () {
                              showCountryPicker(
                                context: context,
                                onSelect: (Country country) {
                                  setState(() {
                                    _selectedCountry = country;
                                  });
                                },
                                countryListTheme: CountryListThemeData(
                                  flagSize: 25,
                                  backgroundColor: Colors.grey.shade900,
                                  textStyle: const TextStyle(
                                    color: AppColors.white,
                                    fontSize: 16,
                                  ),
                                  searchTextStyle: const TextStyle(
                                    color: AppColors.white,
                                    fontSize: 16,
                                  ),
                                  inputDecoration: InputDecoration(
                                    labelText: 'Search',
                                    hintText: 'Start typing to search',
                                    prefixIcon: const Icon(
                                      Icons.search,
                                      color: AppColors.white,
                                    ),
                                    labelStyle: const TextStyle(
                                      color: AppColors.white,
                                    ),
                                    hintStyle: TextStyle(
                                      color: AppColors.grey.withOpacity(0.5),
                                    ),
                                  ),
                                ),
                              );
                            },
                            child: Container(
                              width: 100,
                              height: 56,
                              decoration: BoxDecoration(
                                color: Colors.grey.shade800.withOpacity(0.6),
                                borderRadius: BorderRadius.circular(18),
                              ),
                              padding: const EdgeInsets.symmetric(
                                horizontal: 12,
                              ),
                              child: Row(
                                children: [
                                  Text(
                                    _selectedCountry.flagEmoji,
                                    style: const TextStyle(fontSize: 24),
                                  ),
                                  const SizedBox(width: 8),
                                  Text(
                                    '+${_selectedCountry.phoneCode}',
                                    style: const TextStyle(
                                      color: AppColors.white,
                                      fontSize: 16,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(width: 12),
                          // Phone number field
                          Expanded(
                            child: TextField(
                              controller: _phoneController,
                              style: const TextStyle(color: AppColors.white),
                              keyboardType: TextInputType.phone,
                              decoration: InputDecoration(
                                hintText: 'Enter your phone',
                                hintStyle: TextStyle(
                                  color: AppColors.grey.withOpacity(0.5),
                                ),
                                filled: true,
                                fillColor: Colors.grey.shade800.withOpacity(
                                  0.6,
                                ),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(18),
                                  borderSide: BorderSide.none,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      // Lost access link
                      TextButton(
                        onPressed: () {
                          // Handle lost access
                        },
                        child: Text(
                          'Lost access to my phone number',
                          style: Theme.of(context).textTheme.bodyMedium
                              ?.copyWith(color: AppColors.accentBlue),
                        ),
                      ),
                      const SizedBox(height: 24),
                      AppButton(
                        onPressed: () {
                          // Handle continue
                        },
                        text: 'Continue',
                        variant: AppButtonVariant.secondary,
                      ),
                      const SizedBox(height: 32),
                      // Or separator
                      Row(
                        children: [
                          Expanded(
                            child: Divider(
                              color: AppColors.white.withOpacity(0.2),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 16),
                            child: Text(
                              'or',
                              style: Theme.of(context).textTheme.bodyMedium
                                  ?.copyWith(color: AppColors.white),
                            ),
                          ),
                          Expanded(
                            child: Divider(
                              color: AppColors.white.withOpacity(0.2),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 24),
                      // Social login buttons
                      SocialButton(
                        type: SocialButtonType.email,
                        onPressed: () {
                          // Handle email login
                        },
                      ),
                      const SizedBox(height: 16),
                      SocialButton(
                        type: SocialButtonType.google,
                        onPressed: () {
                          // Handle Google login
                        },
                      ),
                      const SizedBox(height: 16),
                      SocialButton(
                        type: SocialButtonType.apple,
                        onPressed: () {
                          // Handle Apple login
                        },
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
