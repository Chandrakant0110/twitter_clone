import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:twitter_clone/constants/constants.dart';
import 'package:twitter_clone/features/auth/view/login_view.dart';
import 'package:twitter_clone/features/auth/view/signup_view.dart';
import 'package:twitter_clone/theme/theme.dart';

class LandingView extends ConsumerStatefulWidget {
  static route() {
    return MaterialPageRoute(
      builder: (context) {
        return const LandingView();
      },
    );
  }

  const LandingView({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _LandingViewState();
}

class _LandingViewState extends ConsumerState<LandingView> {
  final appBar = AppBar(
    title: SvgPicture.asset(
      AssetsConstants.twitterXLogo,
      color: Pallete.whiteColor,
    ),
    elevation: 0,
    centerTitle: true,
    backgroundColor: Pallete.backgroundColor,
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(32, 2, 32, 2),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(
                height: 120,
              ),
              const Text(
                'See what\'s happening in the  world right now.',
                style: TextStyle(
                  fontSize: 28,
                  color: Pallete.whiteColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(
                height: 230,
              ),
              ElevatedButton(
                onPressed: () {
                  print('Call the google sign in function here');
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Pallete.whiteColor,
                ),
                child: Center(
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width - 10,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SvgPicture.asset(AssetsConstants.googleIcon),
                        const SizedBox(
                          width: 8,
                        ),
                        const Text(
                          'Continue with Google',
                          style: TextStyle(
                              color: Pallete.backgroundColor,
                              fontSize: 16,
                              fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              const Center(child: Text('or')),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    SignUpView.route(),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Pallete.whiteColor,
                ),
                child: SizedBox(
                  width: MediaQuery.of(context).size.width - 10,
                  child: const Center(
                    child: Text(
                      'Create Account',
                      style: TextStyle(
                          color: Pallete.backgroundColor,
                          fontSize: 16,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 16,
              ),
              Padding(
                padding: EdgeInsets.all(4.0),
                child: RichText(
                  text: const TextSpan(
                    text: 'By signing up, you agree to our ',
                    style: TextStyle(color: Pallete.greyColor),
                    children: [
                      TextSpan(
                        text: 'Terms, Privacy Policy and Cookie Use.',
                        style: TextStyle(
                          color: Pallete.blueColor,
                        ),
                      ),
                    ],
                  ),
                  textAlign: TextAlign.start,
                ),
              ),
              const SizedBox(
                height: 12,
              ),
              Padding(
                padding: const EdgeInsets.all(5.0),
                child: RichText(
                  text: TextSpan(
                    text: "Have an account already?",
                    style: const TextStyle(
                      color: Pallete.greyColor,
                      fontSize: 16,
                    ),
                    children: [
                      TextSpan(
                          text: ' Login',
                          style: const TextStyle(
                            color: Pallete.blueColor,
                          ),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              print('Login clicked.');
                              Navigator.push(
                                context,
                                LoginView.route(),
                              );
                            }),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class widget2 extends StatelessWidget {
  const widget2({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        // crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          ElevatedButton(
            onPressed: () {
              print('Call the google sign in function here');
            },
            child: const Text(
              'Continue with Google',
              style: TextStyle(color: Pallete.backgroundColor),
            ),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                SignUpView.route(),
              );
            },
            child: const Text(
              'Create Account',
              style: TextStyle(color: Pallete.backgroundColor),
            ),
          ),
          const SizedBox(
            height: 8,
          ),
          ElevatedButton.icon(
            icon: const Icon(Icons.alarm), // Add your asset here
            // icon: Image.asset(
            //     'assets/google_icon.png'), // Add your asset here
            label: const Text('Continue with Google',
                style: TextStyle(color: Colors.black)),
            onPressed: () {},
            style: ElevatedButton.styleFrom(
              primary: Colors.white,
              padding: const EdgeInsets.symmetric(
                horizontal: 20,
                vertical: 10,
              ),
            ),
          ),
          const Expanded(
            child: Row(
              children: <Widget>[
                Checkbox(value: false, onChanged: null),
                Text("By signing up, you agree to our Terms,",
                    style: TextStyle(color: Colors.grey)),
                Text("Privacy Policy and Cookie Use.",
                    style: TextStyle(color: Colors.grey)),
              ],
            ),
          ),
          const Row(
            children: <Widget>[
              Checkbox(value: false, onChanged: null),
            ],
          ),
          const Row(
            children: <Widget>[
              Checkbox(value: false, onChanged: null),
              Text("Have an account already?",
                  style: TextStyle(color: Pallete.greyColor)),
              Text(" Log in", style: TextStyle(color: Pallete.blueColor)),
            ],
          ),
        ],
      ),
    );
  }
}
