import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../utilities/constants/app_colors.dart';

class CustomElevatedButton extends StatelessWidget {
  const CustomElevatedButton({
    super.key,
    required this.txtBtn,
    required this.onpreesed,
    this.bgColor,
    this.txtColor,
    this.isLoading = false,
  });
  final String txtBtn;
  final VoidCallback? onpreesed;
  final Color? bgColor;
  final Color? txtColor;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        minimumSize: Size(double.infinity, 55),
        backgroundColor: bgColor ?? Theme.of(context).primaryColor,
      ),

      onPressed: onpreesed,
      child:
          isLoading
              ? CupertinoActivityIndicator(color: AppColors.blackColor12)
              : Text(
                txtBtn,
                style: Theme.of(context).textTheme.titleMedium!.copyWith(
                  color: txtColor ?? AppColors.white,
                ),
              ),
    );
  }
}
