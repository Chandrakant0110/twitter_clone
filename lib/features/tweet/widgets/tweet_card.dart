import 'package:any_link_preview/any_link_preview.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fpdart/fpdart.dart';
import 'package:like_button/like_button.dart';
import 'package:twitter_clone/common/common.dart';
import 'package:twitter_clone/constants/appwrite_constants.dart';
import 'package:twitter_clone/constants/assets_constants.dart';
import 'package:twitter_clone/core/enum/tweet_type_enum.dart';
import 'package:twitter_clone/features/auth/controller/auth_controller.dart';
import 'package:twitter_clone/features/tweet/controller/tweet_controller.dart';
import 'package:twitter_clone/features/tweet/widgets/carousel_image.dart';
import 'package:twitter_clone/features/tweet/widgets/hashtags_text.dart';
import 'package:twitter_clone/features/tweet/widgets/tweet_icon_buttons.dart';
import 'package:twitter_clone/models/tweet_model.dart';
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
    final currUser = ref.watch(currentUserDetailsProvider).value;
    return currUser == null
        ? const SizedBox(
            height: 1,
          )
        : ref.watch(userDetailsProvider(tweet.uid)).when(
            data: (user) => Column(
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          margin: const EdgeInsets.all(10),
                          child: CircleAvatar(
                            backgroundImage: NetworkImage(user.profilePic),
                            radius: 25,
                          ),
                        ),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              //retweeted
                              Row(
                                children: [
                                  Container(
                                    margin: const EdgeInsets.only(
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
                                  const SizedBox(
                                    width: 5,
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
                                ],
                              ),

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
                                margin:
                                    const EdgeInsets.only(top: 10, right: 16),
                                child: Row(
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
                                      text: tweet.commentIds.length.toString(),
                                      onTap: () {},
                                    ),
                                    TweetIconButton(
                                      pathName: AssetsConstants.retweetIcon,
                                      text: tweet.reshareCount.toString(),
                                      onTap: () {},
                                    ),
                                    LikeButton(
                                      size: 25,
                                      onTap: (isLiked) async {
                                        ref
                                            .read(tweetControllerProvider
                                                .notifier)
                                            .likeTweet(tweet, currUser!);
                                        return !isLiked;
                                      },
                                      likeBuilder: (isLiked) {
                                        return isLiked
                                            ? SvgPicture.asset(
                                                AssetsConstants.likeFilledIcon,
                                                color: Pallete.redColor,
                                              )
                                            : SvgPicture.asset(
                                                AssetsConstants
                                                    .likeOutlinedIcon,
                                                color: Pallete.greyColor,
                                              );
                                      },
                                      likeCount: tweet.likes.length,
                                      isLiked:
                                          tweet.likes.contains(currUser.uid),
                                      countBuilder: (likeCount, isLiked, text) {
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
            error: (error, stackTrace) => ErrorText(error: error.toString()),
            loading: () => const Loader());
  }
}
