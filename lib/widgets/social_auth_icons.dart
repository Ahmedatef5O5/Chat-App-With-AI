import 'package:chat_app_with_ai/widgets/custom_container_widget.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import '../utilities/constants/app_colors.dart';
import '../utilities/constants/app_images.dart';

class SocialAuthIcons extends StatelessWidget {
  const SocialAuthIcons({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          'Or Sign in with',
          style: Theme.of(context).textTheme.titleSmall!.copyWith(
            color: AppColors.grey5,
            fontSize: 15,
          ),
        ),
        Gap(16),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CustomContainerWidget(img: AppImages.googleLogo, onTap: () {}),
            Gap(28),
            CustomContainerWidget(img: AppImages.facebookLogo, onTap: () {}),
            Gap(28),
            CustomContainerWidget(img: AppImages.appleLogo, onTap: () {}),
          ],
        ),
      ],
    );
  }
}
