import 'package:chat_app_with_ai/Router/app_routes.dart';
import 'package:chat_app_with_ai/cubits/auth_cubit/auth_cubit.dart';
import 'package:chat_app_with_ai/cubits/chat_cubit/chat_cubit.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
  late final TextEditingController _emailController;
  late final TextEditingController _passwordController;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  @override
  void initState() {
    super.initState();

    _emailController = TextEditingController();

    _passwordController = TextEditingController();
    context.read<ChatCubit>().startNewChat();
  }

  @override
  void dispose() {
    super.dispose();
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
                            RememberMeAndForgetPassSection(
                              isAgreed: _isAgreed,
                              onChanged: (value) {
                                setState(() {
                                  _isAgreed = value!;
                                });
                              },
                            ),
                            Gap(12),
                            BlocConsumer<AuthCubit, AuthState>(
                              listener: (context, state) {
                                if (state is AuthSuccess) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                      content: Text('login successfully'),
                                      backgroundColor: Colors.green,
                                      duration: Duration(seconds: 3),
                                      behavior: SnackBarBehavior.floating,
                                    ),
                                  );
                                  Navigator.of(
                                    context,
                                  ).pushReplacementNamed(AppRoutes.chat);
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
                                    txtBtn: 'Login',
                                    onpreesed: null,
                                    isLoading: true,
                                  );
                                }
                                return CustomElevatedButton(
                                  txtBtn: 'Login',
                                  onpreesed: () {
                                    if (_formKey.currentState!.validate()) {
                                      context.read<AuthCubit>().login(
                                        _emailController.text,
                                        _passwordController.text,
                                      );
                                    } else {
                                      ScaffoldMessenger.of(
                                        context,
                                      ).showSnackBar(
                                        const SnackBar(
                                          content: Text(
                                            'Oops there an error to Login',
                                          ),
                                          backgroundColor: Colors.red,
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
        ),
      ),
    );
  }
}
