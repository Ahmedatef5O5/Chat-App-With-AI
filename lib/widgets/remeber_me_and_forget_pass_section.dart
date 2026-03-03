import 'package:flutter/material.dart';
import '../utilities/constants/app_colors.dart';

class RememberMeAndForgetPassSection extends StatelessWidget {
  const RememberMeAndForgetPassSection({
    super.key,
    required this.isAgreed,
    required this.onChanged,
  });
  final bool isAgreed;
  final ValueChanged<bool?> onChanged;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Checkbox(
          value: isAgreed,
          activeColor: Theme.of(context).primaryColor,
          checkColor: Colors.white,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
          side: BorderSide(color: AppColors.grey4),
          onChanged: onChanged,
        ),
        Text(
          'Remember me',
          style: Theme.of(context).textTheme.bodySmall!.copyWith(
            fontWeight: FontWeight.w400,
            fontSize: 14,
            color: AppColors.grey4,
          ),
        ),
        Spacer(),
        Text(
          'Forget passwod?',
          style: Theme.of(context).textTheme.bodySmall!.copyWith(
            fontWeight: FontWeight.w500,
            fontSize: 13,
            color: Theme.of(context).primaryColor,
          ),
        ),
      ],
    );
  }
}
