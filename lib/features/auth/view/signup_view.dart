import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
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
  final appBar = AppBar(
    title: SvgPicture.asset(
      AssetsConstants.twitterXLogo,
      color: Pallete.whiteColor,
    ),
    centerTitle: true,
  );
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
          username: _usernameController.text,
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
            body: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: 10,
                    ),
                    const Text(
                      '   Create your account',
                      textAlign: TextAlign.start,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 28,
                        color: Pallete.whiteColor,
                      ),
                    ),
                    const SizedBox(
                      height: 150,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: Column(
                        children: [
                          AuthField(
                            obSecureText: false,
                            controller: _usernameController,
                            hintText: 'Username',
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          // Textfield 1
                          AuthField(
                            obSecureText: false,
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
                            height: 25,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            bottomNavigationBar: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Padding(
                  padding: const EdgeInsets.only(
                    right: 16.0,
                    bottom: 4.0,
                  ),
                  child: RoundedButton(
                    onTap: onSignUp,
                    label: 'Done',
                    backgroundColor: Pallete.whiteColor,
                    textColor: Pallete.backgroundColor,
                  ),
                ),
              ],
            ),
          );
  }
}
