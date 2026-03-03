import 'package:chat_app_with_ai/utilities/constants/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import '../widgets/custom_elevated_button.dart';
import '../widgets/custom_text_form_field.dart';
import '../widgets/social_auth_icons.dart';
import '../widgets/terms_and_conditions_checkbox.dart';

class RegiserView extends StatefulWidget {
  const RegiserView({super.key});

  @override
  State<RegiserView> createState() => _RegiserViewState();
}

class _RegiserViewState extends State<RegiserView> {
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
                          'Create an Account?',
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
                          headerText: 'Name',
                          hintText: 'Enter your name',
                        ),
                        Gap(14),
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
                        Gap(6),
                        TermsAndConditionsCheckBox(
                          isAgreed: _isAgreed,
                          onChanged: (bool? value) {
                            setState(() {
                              _isAgreed = value!;
                            });
                          },
                        ),
                        Gap(16),
                        CustomElevatedButton(
                          txtBtn: 'Create account',
                          onpreesed: () {},
                        ),
                        Gap(16),
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
