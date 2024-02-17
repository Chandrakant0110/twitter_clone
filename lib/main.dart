import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:twitter_clone/common/common.dart';
import 'package:twitter_clone/features/auth/controller/auth_controller.dart';
import 'package:twitter_clone/features/auth/view/landing_view.dart';
import 'package:twitter_clone/features/home/view/home_view.dart';
import 'package:twitter_clone/theme/app_theme.dart';
import 'package:twitter_clone/theme/pallete.dart';

void main() {
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MaterialApp(
      title: 'Twitter',
      theme: AppTheme.theme.copyWith(
        textTheme: GoogleFonts.mulishTextTheme(
          Theme.of(context).textTheme.copyWith(
                // Set the default text color to white
                bodyText1: Theme.of(context).textTheme.bodyText1!.copyWith(
                      color: Colors.white,
                    ),
                bodyText2: Theme.of(context).textTheme.bodyText2!.copyWith(
                      color: Colors.white,
                    ),
              ),
        ),
      ),
      debugShowCheckedModeBanner: false,

      home: ref.watch(currentUserAccountProvider).when(
            data: (user) {
              // print(user!.email);
              if (user != null) {
                return const HomeView();
              }
              return const LandingView();
              // return const LandingView();
            },
            error: (error, stackTrace) => ErrorPage(
              error: error.toString(),
            ),
            loading: () => const LoadingPage(),
          ),
      // home: const LandingView(),
    );
  }
}
