import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import '../utilities/constants/app_colors.dart';

class CustomTextFormField extends StatefulWidget {
  const CustomTextFormField({
    super.key,
    this.hintText,
    this.headerText,
    this.controller,
    this.validator,
    this.isPassword = false,
    this.keyboardType,
    this.suffixIcon,
    this.prefixIcon,
  });
  final String? hintText, headerText;
  final TextEditingController? controller;
  final String? Function(String?)? validator;
  final bool isPassword;
  final TextInputType? keyboardType;

  final Widget? suffixIcon;
  final Widget? prefixIcon;

  @override
  State<CustomTextFormField> createState() => _CustomTextFormFieldState();
}

class _CustomTextFormFieldState extends State<CustomTextFormField> {
  late bool _obscureText;

  @override
  void initState() {
    super.initState();
    _obscureText = widget.isPassword;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        if (widget.headerText != null) ...[
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              widget.headerText!,
              style: Theme.of(
                context,
              ).textTheme.headlineSmall!.copyWith(fontSize: 16),
            ),
          ),
          Gap(12),
        ],
        TextFormField(
          controller: widget.controller,
          validator: widget.validator,
          obscureText: _obscureText,
          keyboardType: widget.keyboardType,
          decoration: InputDecoration(
            filled: true,
            fillColor: AppColors.grey3,
            hintText: widget.hintText,
            hintStyle: Theme.of(context).textTheme.titleSmall!.copyWith(
              color: AppColors.blackColor26,
              fontSize: 16,
              fontWeight: FontWeight.w300,
            ),
            prefixIcon: widget.prefixIcon,

            suffixIcon:
                widget.isPassword
                    ? IconButton(
                      icon: Icon(
                        _obscureText ? Icons.visibility_off : Icons.visibility,
                        color: AppColors.blackColor26,
                      ),
                      onPressed: () {
                        setState(() {
                          _obscureText = !_obscureText;
                        });
                      },
                    )
                    : null,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(26),
              borderSide: BorderSide.none,
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(26),
              borderSide: BorderSide.none,
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(26),
              borderSide: BorderSide.none,
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(26),
              borderSide: BorderSide.none,
            ),
          ),
        ),
      ],
    );
  }
}
