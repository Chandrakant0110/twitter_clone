import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:twitter_clone/constants/assets_constants.dart';
import 'package:twitter_clone/features/chat/view/chat_section.dart';
import 'package:twitter_clone/features/explore/view/explore_view_page.dart';
import 'package:twitter_clone/features/grok/view/grok_view.dart';
import 'package:twitter_clone/features/notifications/views/notification_view.dart';
import 'package:twitter_clone/features/tweet/widgets/tweet_list.dart';
import 'package:twitter_clone/theme/pallete.dart';

class UIConstants {
  static AppBar appBar() {
    return AppBar(
      title: SvgPicture.asset(
        AssetsConstants.twitterXLogo,
        color: Pallete.whiteColor,
        // AssetsConstants.twitterLogo,
        // color: Pallete.blueColor,
      ),
      centerTitle: true,
      actions: [
        IconButton(
          onPressed: () {},
          icon: const Icon(
            Icons.settings_outlined,
            size: 25,
          ),
        ),
      ],
      // leading: IconButton(
      //   onPressed: () {},
      //   icon: const Icon(
      //     Icons.image_outlined,
      //   ),
      // ),
    );
  }

  static const List<Widget> bottomTabBarPages = [
    TweetList(),
    ExploreViewPage(),
    GrokView(),
    NotificationView(),
    ChatSection(),
  ];
}
