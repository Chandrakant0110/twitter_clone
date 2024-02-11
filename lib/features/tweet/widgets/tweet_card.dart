import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:like_button/like_button.dart';
import 'package:twitter_clone/common/common.dart';
import 'package:twitter_clone/constants/assets_constants.dart';
import 'package:twitter_clone/core/enum/tweet_type_enum.dart';
import 'package:twitter_clone/features/auth/controller/auth_controller.dart';
import 'package:twitter_clone/features/tweet/controller/tweet_controller.dart';
import 'package:twitter_clone/features/tweet/views/twitter_reply_screen.dart';
import 'package:twitter_clone/features/tweet/widgets/carousel_image.dart';
import 'package:twitter_clone/features/tweet/widgets/hashtags_text.dart';
import 'package:twitter_clone/features/tweet/widgets/tweet_icon_buttons.dart';
import 'package:twitter_clone/features/user_profile/views/user_profile_view.dart';
import 'package:twitter_clone/models/tweet_model.dart';
import 'package:twitter_clone/models/user_model.dart';
import 'package:twitter_clone/theme/pallete.dart';
import 'package:timeago/timeago.dart' as timeago;

class TweetCard extends ConsumerWidget {
  final Tweet tweet;
  const TweetCard({
    super.key,
    required this.tweet,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final AsyncValue<UserModel?> currentUserDetails =
        ref.watch(currentUserDetailsProvider);
    final currUser = currentUserDetails.value;
    return currUser == null
        ? const Text(
            'Please restart the app',
          )
        : ref.watch(userDetailsProvider(tweet.uid)).when(
            data: (user) => GestureDetector(
                  onTap: () =>
                      Navigator.push(context, TwitterReplyScreen.route(tweet)),
                  child: Container(
                    child: Column(
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              margin: const EdgeInsets.all(10),
                              child: GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    UserProfileView.route(user),
                                  );
                                },
                                child: CircleAvatar(
                                  backgroundImage: user.profilePic.isEmpty
                                      ? const NetworkImage(
                                          'https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_1280.png')
                                      : NetworkImage(user.profilePic),
                                  radius: 25,
                                ),
                              ),
                            ),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  if (tweet.retweetedBy.isNotEmpty)
                                    Row(
                                      children: [
                                        SvgPicture.asset(
                                          AssetsConstants.retweetIcon,
                                          color: Pallete.greyColor,
                                          height: 20,
                                        ),
                                        const SizedBox(width: 2),
                                        Text(
                                          '${tweet.retweetedBy} retweeted',
                                          style: const TextStyle(
                                            color: Pallete.greyColor,
                                            fontSize: 16,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                      ],
                                    ),
                                  Row(
                                    children: [
                                      Container(
                                        margin: EdgeInsets.only(
                                          right: user.isTwitterBlue ? 1 : 5,
                                          left: 5,
                                        ),
                                        child: Text(
                                          user.name,
                                          style: const TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                      if (user.isTwitterBlue)
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(right: 5.0),
                                          child: SvgPicture.asset(
                                            AssetsConstants.verifiedIcon,
                                          ),
                                        ),
                                      Text(
                                        '@${user.name} .  ${timeago.format(
                                          tweet.tweetedAt,
                                          locale: 'en_short',
                                        )}',
                                        style: const TextStyle(
                                          fontSize: 14,
                                          color: Pallete.greyColor,
                                        ),
                                      ),
                                      IconButton(
                                          padding:
                                              const EdgeInsets.only(left: 25),
                                          onPressed: () {},
                                          icon: const Icon(
                                              Icons.more_vert_rounded))
                                    ],
                                  ),
                                  if (tweet.repliedTo.isNotEmpty)
                                    ref
                                        .watch(getTweetByIdProvider(
                                            tweet.repliedTo))
                                        .when(
                                            data: (repliedToTweet) {
                                              final replyingToUser = ref
                                                  .watch(
                                                    userDetailsProvider(
                                                      repliedToTweet.uid,
                                                    ),
                                                  )
                                                  .value;
                                              return RichText(
                                                text: TextSpan(
                                                  text: 'Replying to ',
                                                  style: const TextStyle(
                                                    color: Pallete.greyColor,
                                                    fontSize: 16,
                                                  ),
                                                  children: [
                                                    TextSpan(
                                                        text:
                                                            '@${replyingToUser?.name}',
                                                        style: const TextStyle(
                                                          color:
                                                              Pallete.blueColor,
                                                          fontSize: 16,
                                                        ),
                                                        children: []),
                                                  ],
                                                ),
                                              );
                                            },
                                            error: (error, stackTrace) {
                                              print(
                                                  'tweet card file me kuch error hai.. ${error.toString()}');
                                              return const SizedBox(
                                                height: 1,
                                              );
                                              // return ErrorText(
                                              //   error: error.toString(),
                                              // );
                                            },
                                            loading: () => const SizedBox()),

                                  HashtagText(text: tweet.text),
                                  if (tweet.tweetType == TweetType.image)
                                    CarouselImage(
                                      imageLinks: tweet.imageLinks,
                                    ),
                                  // Text(tweet.imageLinks.toString()),
                                  if (tweet.link.isNotEmpty) ...[
                                    const SizedBox(
                                      height: 4,
                                    ),
                                    // Container(
                                    //   height: 100,
                                    //   width: 100,
                                    //   child: AnyLinkPreview(
                                    //     link: 'https://${tweet.link}',
                                    //     displayDirection:
                                    //         UIDirection.uiDirectionHorizontal,
                                    //   ),
                                    // ),
                                  ],
                                  Container(
                                    margin: const EdgeInsets.only(
                                        top: 10, right: 20),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        TweetIconButton(
                                          pathName: AssetsConstants.viewsIcon,
                                          text: (tweet.commentIds.length +
                                                  tweet.likes.length +
                                                  tweet.reshareCount)
                                              .toString(),
                                          onTap: () {},
                                        ),
                                        TweetIconButton(
                                          pathName: AssetsConstants.commentIcon,
                                          text: tweet.commentIds.length
                                              .toString(),
                                          onTap: () {
                                            Navigator.push(
                                                context,
                                                TwitterReplyScreen.route(
                                                    tweet));
                                          },
                                        ),
                                        TweetIconButton(
                                          pathName: AssetsConstants.retweetIcon,
                                          text: tweet.reshareCount.toString(),
                                          onTap: () {
                                            ref
                                                .read(tweetControllerProvider
                                                    .notifier)
                                                .reshareTweet(
                                                  tweet,
                                                  currUser,
                                                  context,
                                                );
                                          },
                                        ),
                                        LikeButton(
                                          size: 25,
                                          onTap: (isLiked) async {
                                            ref
                                                .read(tweetControllerProvider
                                                    .notifier)
                                                .likeTweet(tweet, currUser);
                                            return !isLiked;
                                          },
                                          likeBuilder: (isLiked) {
                                            return isLiked
                                                ? SvgPicture.asset(
                                                    AssetsConstants
                                                        .likeFilledIcon,
                                                    color: Pallete.redColor,
                                                  )
                                                : SvgPicture.asset(
                                                    AssetsConstants
                                                        .likeOutlinedIcon,
                                                    color: Pallete.greyColor,
                                                  );
                                          },
                                          likeCount: tweet.likes.length,
                                          isLiked: tweet.likes
                                              .contains(currUser.uid),
                                          countBuilder:
                                              (likeCount, isLiked, text) {
                                            return Text(
                                              text,
                                              style: TextStyle(
                                                  color: isLiked
                                                      ? Pallete.redColor
                                                      : Pallete.greyColor),
                                            );
                                          },
                                        ),
                                        // TweetIconButton(
                                        //   pathName: AssetsConstants.likeOutlinedIcon,
                                        //   text: tweet.likes.length.toString(),
                                        //   onTap: () {},
                                        // ),
                                        IconButton(
                                          onPressed: () {},
                                          icon: const Icon(
                                            Icons.share_outlined,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 1,
                                  )
                                ],
                              ),
                            ),
                            // replied to
                          ],
                        ),
                        const Padding(
                          padding: EdgeInsets.only(left: 8.0, right: 8),
                          child: Divider(
                            color: Pallete.greyColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
            error: (error, stackTrace) => ErrorText(error: error.toString()),
            loading: () => const Loader());
  }
}
