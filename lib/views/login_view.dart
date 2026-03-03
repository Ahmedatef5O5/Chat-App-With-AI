import 'package:chat_app_with_ai/Router/app_routes.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import '../utilities/constants/app_colors.dart';
import '../widgets/custom_elevated_button.dart';
import '../widgets/custom_text_form_field.dart';
import '../widgets/remeber_me_and_forget_pass_section.dart';
import '../widgets/social_auth_icons.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  bool _isAgreed = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 2),
          child: SingleChildScrollView(
            clipBehavior: Clip.none,
            scrollDirection: Axis.vertical,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Gap(28),
                Center(
                  child: Text(
                    'Chat with AI',
                    style: Theme.of(context).textTheme.labelLarge!.copyWith(
                      color: Theme.of(context).primaryColor,
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                Gap(28),
                Container(
                  // height: 500,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.white60,
                    borderRadius: BorderRadius.circular(22),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withValues(alpha: 0.3),
                        spreadRadius: 5,
                        blurRadius: 7,
                        offset: const Offset(3, 3),
                      ),
                    ],
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 8,
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Gap(10),
                        Text(
                          'Welcome to Chat with AI login now!',
                          maxLines: 2,
                          style: Theme.of(
                            context,
                          ).textTheme.titleMedium!.copyWith(
                            color: AppColors.blackColor,
                            fontSize: 20,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Gap(20),
                        CustomTextFormField(
                          headerText: 'Email',
                          hintText: 'Enter your Email',
                        ),
                        Gap(14),
                        CustomTextFormField(
                          headerText: 'Password',
                          hintText: 'Enter your Password',
                          isPassword: true,
                        ),
                        RememberMeAndForgetPassSection(
                          isAgreed: _isAgreed,
                          onChanged: (value) {
                            setState(() {
                              _isAgreed = value!;
                            });
                          },
                        ),
                        Gap(12),
                        CustomElevatedButton(txtBtn: 'Login', onpreesed: () {}),
                        Gap(8),
                        Text.rich(
                          TextSpan(
                            text: 'Does not have account?',
                            style: Theme.of(
                              context,
                            ).textTheme.titleSmall!.copyWith(
                              color: AppColors.blackColor38,
                              fontSize: 12,
                              fontWeight: FontWeight.w400,
                            ),
                            children: [
                              TextSpan(
                                recognizer:
                                    TapGestureRecognizer()
                                      ..onTap =
                                          () => Navigator.of(
                                            context,
                                          ).pushReplacementNamed(
                                            AppRoutes.register,
                                          ),
                                text: ' create account',
                                style: Theme.of(
                                  context,
                                ).textTheme.titleSmall!.copyWith(
                                  color: Theme.of(context).primaryColor,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Gap(18),
                        SocialAuthIcons(),
                        Gap(16),
                      ],
                    ),
                  ),
                ),
                Gap(40),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
