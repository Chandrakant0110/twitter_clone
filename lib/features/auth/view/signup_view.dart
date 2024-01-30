import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:twitter_clone/common/common.dart';
import 'package:twitter_clone/common/loadin_page.dart';
import 'package:twitter_clone/constants/constants.dart';
import 'package:twitter_clone/features/auth/controller/auth_controller.dart';
import 'package:twitter_clone/features/auth/view/login_view.dart';
import 'package:twitter_clone/features/auth/widgets/auth_field.dart';
import 'package:twitter_clone/theme/pallete.dart';

class SignUpView extends ConsumerStatefulWidget {
  static route() {
    return MaterialPageRoute(
      builder: (context) {
        return const SignUpView();
      },
    );
  }

  const SignUpView({super.key});

  @override
  ConsumerState<SignUpView> createState() => _SignUpViewState();
}

class _SignUpViewState extends ConsumerState<SignUpView> {
  final appBar = UIConstants.appBar();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    _usernameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
  }

  void onSignUp() {
    ref.read(authControllerProvider.notifier).signUp(
          email: _emailController.text,
          password: _passwordController.text,
          context: context,
        );
  }

  @override
  Widget build(BuildContext context) {
    final isLoading = ref.watch(authControllerProvider);

    return isLoading
        ? const LoadingPage()
        : Scaffold(
            appBar: appBar,
            body: Center(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Column(
                    children: [
                      AuthField(
                        controller: _usernameController,
                        hintText: 'Username',
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      // Textfield 1
                      AuthField(
                        controller: _emailController,
                        hintText: 'Email Address',
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      // Password textfield
                      AuthField(
                        controller: _passwordController,
                        hintText: 'Password',
                        obSecureText: true,
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      // Button
                      Align(
                        alignment: Alignment.topRight,
                        child: RoundedButton(
                          onTap: onSignUp,
                          label: 'Done',
                          backgroundColor: Pallete.whiteColor,
                          textColor: Pallete.backgroundColor,
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      RichText(
                        text: TextSpan(
                          text: "Already have an account?",
                          children: [
                            TextSpan(
                                text: ' Login',
                                style: const TextStyle(
                                  color: Pallete.blueColor,
                                ),
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () {
                                    print('Login clicked.');
                                    Navigator.pushReplacement(
                                      context,
                                      LoginView.route(),
                                    );
                                  }),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
  }
}
