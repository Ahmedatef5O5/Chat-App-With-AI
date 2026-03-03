import 'package:chat_app_with_ai/utilities/constants/app_colors.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import '../widgets/custom_text_form_field.dart';

class RegiserView extends StatefulWidget {
  const RegiserView({super.key});

  @override
  State<RegiserView> createState() => _RegiserViewState();
}

class _RegiserViewState extends State<RegiserView> {
  bool _isAgreed = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 2),
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
              height: 500,
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
                      style: Theme.of(context).textTheme.titleMedium!.copyWith(
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
                    Gap(12),
                    Row(
                      children: [
                        Checkbox(
                          value: _isAgreed,
                          activeColor: Theme.of(context).primaryColor,
                          checkColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(4),
                          ),
                          onChanged: (value) {
                            setState(() {
                              _isAgreed = value!;
                            });
                          },
                        ),

                        Text.rich(
                          TextSpan(
                            text: 'I agree to the',

                            style: Theme.of(
                              context,
                            ).textTheme.bodySmall!.copyWith(fontSize: 13),
                            children: [
                              TextSpan(
                                text: ' \bTerms of Services',
                                style: Theme.of(
                                  context,
                                ).textTheme.bodySmall!.copyWith(
                                  color: Theme.of(context).primaryColor,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 13,
                                ),
                                recognizer:
                                    TapGestureRecognizer()
                                      ..onTap = () {
                                        debugPrint('Terms tapped');
                                      },
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),

                    Gap(26),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
