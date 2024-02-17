import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:twitter_clone/common/loadin_page.dart';
import 'package:twitter_clone/common/rounded_button.dart';
import 'package:twitter_clone/constants/constants.dart';
import 'package:twitter_clone/features/auth/controller/auth_controller.dart';
import 'package:twitter_clone/features/auth/view/signup_view.dart';
import 'package:twitter_clone/features/auth/widgets/auth_field.dart';
import 'package:twitter_clone/theme/pallete.dart';

class LoginView extends ConsumerStatefulWidget {
  static route() => MaterialPageRoute(
        builder: (context) => const LoginView(),
      );
  const LoginView({super.key});

  @override
  ConsumerState<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends ConsumerState<LoginView> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    emailController.dispose();
    passwordController.dispose();
  }

  void onLogin() {
    ref.read(authControllerProvider.notifier).login(
          email: emailController.text,
          password: passwordController.text,
          context: context,
        );
  }

  @override
  Widget build(BuildContext context) {
    final isLoading = ref.watch(authControllerProvider);
    final appBar = AppBar(
      title: SvgPicture.asset(
        AssetsConstants.twitterXLogo,
        color: Pallete.whiteColor,
      ),
      centerTitle: true,
      leading: IconButton(
        onPressed: () {
          Navigator.pop(context);
        },
        icon: const Icon(
          Icons.close_rounded,
          size: 32,
        ),
      ),
    );
    return Scaffold(
      appBar: appBar,
      body: isLoading
          ? const Loader()
          : SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  // mainAxisAlignment: MainAxisAlignment.start,
                  // crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SizedBox(
                      height: 10,
                    ),
                    const Text(
                      'To get started, first enter your phone, email address or @username',
                      textAlign: TextAlign.start,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 28,
                      ),
                    ),
                    const SizedBox(
                      height: 24,
                    ),
                    // textfield 1
                    AuthField(
                      obSecureText: false,
                      controller: emailController,
                      hintText: 'Phone, email address, or username',
                    ),
                    const SizedBox(height: 12),
                    AuthField(
                      obSecureText: true,
                      controller: passwordController,
                      hintText: 'Password',
                    ),
                    const SizedBox(height: 40),
                  ],
                ),
              ),
            ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.only(left: 5.0, right: 5),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            RoundedButton(
              onTap: () {
                print('create a forget password function/method.');
              },
              label: 'Forget Password?',
              textColor: Pallete.whiteColor,
              backgroundColor: Pallete.backgroundColor,
            ),
            RoundedButton(
              onTap: onLogin,
              label: 'Done',
              backgroundColor: Pallete.whiteColor,
              textColor: Pallete.backgroundColor,
            ),
          ],
        ),
      ),
    );
  }
}
