import 'package:chat_app_with_ai/Router/app_routes.dart';
import 'package:chat_app_with_ai/cubits/auth_cubit/auth_cubit.dart';
import 'package:chat_app_with_ai/utilities/constants/app_colors.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import '../widgets/custom_elevated_button.dart';
import '../widgets/custom_text_form_field.dart';
import '../widgets/social_auth_icons.dart';
import '../widgets/terms_and_conditions_checkbox.dart';

class RegisterView extends StatefulWidget {
  const RegisterView({super.key});

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  bool _isAgreed = false;
  late final TextEditingController _nameController;
  late final TextEditingController _emailController;
  late final TextEditingController _passwordController;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController();
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
  }

  @override
  void dispose() {
    super.dispose();
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
  }

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
            child: Form(
              key: _formKey,
              child: SafeArea(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
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
                              validator:
                                  (p0) =>
                                      p0!.isEmpty
                                          ? 'Please enter your name'
                                          : null,
                              controller: _nameController,
                              headerText: 'Name',
                              hintText: 'Enter your name',
                            ),
                            Gap(14),
                            CustomTextFormField(
                              validator:
                                  (p0) =>
                                      p0!.isEmpty
                                          ? 'Please enter your email'
                                          : null,
                              controller: _emailController,
                              headerText: 'Email',
                              hintText: 'Enter your Email',
                            ),
                            Gap(14),
                            CustomTextFormField(
                              validator:
                                  (p0) =>
                                      p0!.isEmpty
                                          ? 'Please enter your password'
                                          : null,
                              controller: _passwordController,
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
                            BlocConsumer<AuthCubit, AuthState>(
                              listener: (context, state) {
                                if (state is AuthSuccess) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                      content: Text(
                                        'Account created successfully , please login ',
                                      ),
                                      duration: Duration(seconds: 2),
                                    ),
                                  );
                                  Navigator.of(
                                    context,
                                  ).pushReplacementNamed(AppRoutes.login);
                                } else if (state is AuthFailure) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text(state.errMsg),
                                      backgroundColor: Colors.red,
                                    ),
                                  );
                                }
                              },
                              builder: (context, state) {
                                if (state is AuthLoading) {
                                  return CustomElevatedButton(
                                    txtBtn: 'Create account',
                                    onPressed: null,
                                    isLoading: true,
                                  );
                                }

                                return CustomElevatedButton(
                                  txtBtn: 'Create account',
                                  onPressed: () {
                                    if (_formKey.currentState!.validate() &&
                                        _isAgreed) {
                                      context.read<AuthCubit>().register(
                                        _nameController.text,
                                        _emailController.text,
                                        _passwordController.text,
                                      );
                                    } else {
                                      ScaffoldMessenger.of(
                                        context,
                                      ).showSnackBar(
                                        const SnackBar(
                                          content: Text(
                                            'Please accept the terms and conditions',
                                          ),
                                        ),
                                      );
                                    }
                                  },
                                );
                              },
                            ),
                            Gap(8),
                            Text.rich(
                              TextSpan(
                                text: 'Already have an account?',
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
                                                AppRoutes.login,
                                              ),
                                    text: ' Login',
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
        ),
      ),
    );
  }
}
