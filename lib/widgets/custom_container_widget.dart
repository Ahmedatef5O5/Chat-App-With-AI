import 'package:flutter/material.dart';
import '../utilities/constants/app_colors.dart';

class CustomContainerWidget extends StatelessWidget {
  final String img;
  final void Function()? onTap;
  const CustomContainerWidget({super.key, required this.img, this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: DecoratedBox(
        decoration: BoxDecoration(
          shape: BoxShape.rectangle,
          color: AppColors.grey3,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Image.asset(img, width: 20, height: 20),
        ),
      ),
    );
  }
}
