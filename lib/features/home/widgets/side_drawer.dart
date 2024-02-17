import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:twitter_clone/constants/constants.dart';
import 'package:twitter_clone/core/utils.dart';
import 'package:twitter_clone/features/auth/controller/auth_controller.dart';
import 'package:twitter_clone/features/payment/payment_page.dart';
import 'package:twitter_clone/features/user_profile/views/user_profile_view.dart';
import 'package:twitter_clone/features/user_profile/widget/follow_count.dart';
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
          // mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 50,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CircleAvatar(
                        backgroundImage: currUser!.profilePic.isEmpty
                            ? const NetworkImage(
                                'https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_1280.png')
                            : NetworkImage(currUser.profilePic),
                        radius: 20,
                      ),
                      IconButton(
                        icon: const Icon(Icons.more_vert_rounded),
                        onPressed: () {},
                      ),
                      // const SizedBox(
                      //   width: 5,
                      // )
                    ],
                  ),
                  Row(
                    children: [
                      Text(
                        currUser.name,
                        style: const TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      if (currUser.isTwitterBlue)
                        Padding(
                          padding: const EdgeInsets.only(left: 3.0),
                          child: SvgPicture.asset(
                            AssetsConstants.verifiedIcon,
                          ),
                        ),
                    ],
                  ),
                  Text(
                    '@${currUser.name}',
                    style: const TextStyle(
                      fontSize: 17,
                      color: Pallete.greyColor,
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      FollowCount(
                        count: currUser.following.length,
                        text: 'Following',
                      ),
                      const SizedBox(
                        width: 15,
                      ),
                      FollowCount(
                        count: currUser.followers.length,
                        text: 'Followers',
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 2,
                  ),
                  const Divider(
                    color: Pallete.greyColor,
                    endIndent: 30,
                  )
                ],
              ),
            ),
            ListTile(
              leading: const Icon(
                Icons.person_outline_sharp,
                size: 30,
              ),
              title: const Text(
                'Profile',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
              onTap: () {
                Navigator.push(
                  context,
                  UserProfileView.route(currUser),
                );
              },
            ),
            ListTile(
              leading: SvgPicture.asset(
                AssetsConstants.twitterXLogo,
                color: Pallete.whiteColor,
                height: 28,
              ),
              title: const Text(
                'Premium',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
              onTap: () {
                if (currUser.isTwitterBlue) {
                  showSnackBar(context, 'Already Verified');
                } else {
                  Navigator.push(context, RazorPayPage.route());
                }
              },
            ),
            ListTile(
              leading: const Icon(
                Icons.people_outline_sharp,
                size: 30,
              ),
              title: const Text(
                'Communities',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
              onTap: () {},
            ),
            ListTile(
              leading: const Icon(
                Icons.bookmark_outline_rounded,
                size: 30,
              ),
              title: const Text(
                'Bookmarks',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
              onTap: () {},
            ),
            ListTile(
              leading: const Icon(
                Icons.library_books_outlined,
                size: 30,
              ),
              title: const Text(
                'Lists',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
              onTap: () {},
            ),
            ListTile(
              leading: const Icon(
                Icons.mic_none,
                size: 30,
              ),
              title: const Text(
                'Spaces',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
              onTap: () {},
            ),
            ListTile(
              leading: const Icon(
                Icons.wallet_rounded,
                size: 30,
              ),
              title: const Text(
                'Monetisation',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
              onTap: () {},
            ),
            const SizedBox(
              height: 5,
            ),
            const Divider(
              color: Pallete.greyColor,
              indent: 15,
              endIndent: 30,
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
                  fontWeight: FontWeight.bold,
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
