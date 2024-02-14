import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:twitter_clone/constants/constants.dart';
import 'package:twitter_clone/core/enum/notification_type_enum.dart';
import 'package:twitter_clone/features/auth/controller/auth_controller.dart';
import 'package:twitter_clone/features/tweet/controller/tweet_controller.dart';
import 'package:twitter_clone/features/tweet/views/twitter_reply_screen.dart';
import 'package:twitter_clone/features/user_profile/controller/user_profile_controller.dart';
import 'package:twitter_clone/features/user_profile/views/user_profile_view.dart';

import 'package:twitter_clone/models/notification_model.dart' as model;
import 'package:twitter_clone/models/tweet_model.dart';
import 'package:twitter_clone/models/user_model.dart';
import 'package:twitter_clone/theme/pallete.dart';

class NotificationTile extends ConsumerWidget {
  final model.Notification notification;
  const NotificationTile({
    super.key,
    required this.notification,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(userDetailsProvider(notification.uid)).value;
    print(user.toString());

    void onTap() async {
      print('ontap clicked');
      if (notification.notificationType == NotificationType.follow) {
        // final userModel =
        //     ref.watch(userDetailsProvider(notification.uid)).value;
        // Navigator.push(context, UserProfileView.route(userModel!));
        print('user profile condition');
      } else {
        final id = notification.postId;
        final tweet =
            await ref.watch(tweetControllerProvider.notifier).getTweetByID(id);
        Navigator.push(context, TwitterReplyScreen.route(tweet));
      }
    }

    return Column(
      children: [
        ListTile(
          leading: notification.notificationType == NotificationType.follow
              ? const Icon(
                  Icons.person,
                  color: Pallete.blueColor,
                )
              : notification.notificationType == NotificationType.likes
                  ? SvgPicture.asset(
                      AssetsConstants.likeFilledIcon,
                      color: Pallete.redColor,
                      height: 20,
                    )
                  : notification.notificationType == NotificationType.retweet
                      ? SvgPicture.asset(
                          AssetsConstants.retweetIcon,
                          color: Pallete.whiteColor,
                          height: 20,
                        )
                      : notification.notificationType == NotificationType.reply
                          ? SvgPicture.asset(
                              AssetsConstants.commentIcon,
                              color: Pallete.whiteColor,
                              height: 20,
                            )
                          : null,
          title: GestureDetector(
            onTap: onTap,
            child: Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CircleAvatar(
                    backgroundImage: user!.profilePic.isEmpty
                        ? const NetworkImage(
                            'https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_1280.png')
                        : NetworkImage(user.profilePic),
                    radius: 25,
                  ),
                  const SizedBox(
                    height: 3,
                  ),
                  Text(notification.text),
                ],
              ),
            ),
          ),
        ),
        const Divider(
          color: Pallete.greyColor,
        ),
      ],
    );
  }
}
