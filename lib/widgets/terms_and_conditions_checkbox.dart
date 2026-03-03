import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class TermsAndConditionsCheckBox extends StatelessWidget {
  final bool isAgreed;
  final ValueChanged<bool?> onChanged;
  const TermsAndConditionsCheckBox({
    super.key,
    required this.isAgreed,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Checkbox(
          value: isAgreed,
          activeColor: Theme.of(context).primaryColor,
          checkColor: Colors.white,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
          onChanged: onChanged,
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
                style: Theme.of(context).textTheme.bodySmall!.copyWith(
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
    );
  }
}
