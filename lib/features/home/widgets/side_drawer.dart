import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:twitter_clone/constants/constants.dart';
import 'package:twitter_clone/core/utils.dart';
import 'package:twitter_clone/features/auth/controller/auth_controller.dart';
import 'package:twitter_clone/features/payment/payment_page.dart';
import 'package:twitter_clone/features/user_profile/controller/user_profile_controller.dart';
import 'package:twitter_clone/features/user_profile/views/user_profile_view.dart';
import 'package:twitter_clone/theme/theme.dart';

class SideDrawer extends ConsumerWidget {
  const SideDrawer({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currUser = ref.watch(currentUserDetailsProvider).value;
    return SafeArea(
      child: Drawer(
        backgroundColor: Pallete.backgroundColor,
        child: Column(
          children: [
            SizedBox(
              height: 50,
            ),
            ListTile(
              leading: const Icon(
                Icons.person,
                size: 30,
              ),
              title: const Text(
                'My Profile',
                style: TextStyle(
                  fontSize: 22,
                ),
              ),
              onTap: () {
                Navigator.push(
                  context,
                  UserProfileView.route(currUser!),
                );
              },
            ),
            ListTile(
              leading: SvgPicture.asset(
                AssetsConstants.verifiedIcon,
                height: 28,
              ),
              title: const Text(
                'Twitter Blue',
                style: TextStyle(
                  fontSize: 22,
                ),
              ),
              onTap: () {
                if (currUser!.isTwitterBlue) {
                  showSnackBar(context, 'Already Verified');
                } else {
                  Navigator.push(context, RazorPayPage.route());
                }
              },
            ),
            ListTile(
              leading: const Icon(
                Icons.logout_outlined,
                size: 30,
              ),
              title: const Text(
                'Log Out',
                style: TextStyle(
                  fontSize: 22,
                ),
              ),
              onTap: () {
                ref.read(authControllerProvider.notifier).logout(context);
              },
            ),
          ],
        ),
      ),
    );
  }
}
