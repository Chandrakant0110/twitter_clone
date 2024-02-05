// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:twitter_clone/common/common.dart';
import 'package:twitter_clone/constants/constants.dart';
import 'package:twitter_clone/features/auth/controller/auth_controller.dart';
import 'package:twitter_clone/features/tweet/controller/tweet_controller.dart';
import 'package:twitter_clone/features/tweet/widgets/tweet_card.dart';
import 'package:twitter_clone/features/user_profile/controller/user_profile_controller.dart';
import 'package:twitter_clone/features/user_profile/views/edit_profile_view.dart';
import 'package:twitter_clone/features/user_profile/widget/follow_count.dart';
import 'package:twitter_clone/models/tweet_model.dart';
import 'package:twitter_clone/models/user_model.dart';
import 'package:twitter_clone/theme/pallete.dart';

class UserProfile extends ConsumerWidget {
  final UserModel user;
  const UserProfile({
    super.key,
    required this.user,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currUser = ref.watch(currentUserDetailsProvider).value;

    return Scaffold(
      body: currUser == null
          ? const Loader()
          : NestedScrollView(
              headerSliverBuilder: (context, innerBoxIsScrolled) {
                return [
                  SliverAppBar(
                    expandedHeight: 200,
                    floating: true,
                    snap: true,
                    flexibleSpace: Stack(
                      children: [
                        Positioned.fill(
                          child: user.bannerPic.isEmpty
                              ? Container(
                                  color: Pallete.blueColor,
                                )
                              : Image.network(
                                  user.bannerPic,
                                  fit: BoxFit.fitWidth,
                                ),
                        ),
                        Positioned(
                          bottom: 0,
                          child: CircleAvatar(
                            backgroundImage: NetworkImage(user.profilePic),
                            radius: 45,
                          ),
                        ),
                        Container(
                          alignment: Alignment.bottomRight,
                          margin: const EdgeInsets.all(20),
                          child: OutlinedButton(
                            onPressed: () {
                              if (currUser.uid == user.uid) {
                                Navigator.push(
                                  context,
                                  EditProfileView.route(),
                                );

                                print('edit profile button clicked');
                              } else {
                                print('edit follow button clicked');
                                ref
                                    .read(
                                        userProfileControllerProvider.notifier)
                                    .followUser(
                                      user: user,
                                      context: context,
                                      currentUser: currUser,
                                    );
                              }
                            },
                            style: ElevatedButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20),
                                side: const BorderSide(
                                  color: Pallete.whiteColor,
                                ),
                              ),
                              padding: const EdgeInsets.symmetric(
                                horizontal: 25,
                              ),
                            ),
                            child: Text(
                              currUser.uid == user.uid
                                  ? 'Edit Profile'
                                  : currUser.uid.contains(user.uid)
                                      ? 'unfollow'
                                      : 'follow',
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SliverPadding(
                    padding: const EdgeInsets.all(8),
                    sliver: SliverList(
                      delegate: SliverChildListDelegate(
                        [
                          Text(
                            user.name,
                            style: const TextStyle(
                              fontSize: 25,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            '@${user.name}',
                            style: const TextStyle(
                              fontSize: 17,
                              color: Pallete.greyColor,
                            ),
                          ),
                          Text(
                            user.bio,
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
                                count: user.following.length,
                                text: 'Following',
                              ),
                              const SizedBox(
                                width: 15,
                              ),
                              FollowCount(
                                count: user.followers.length,
                                text: 'Followers',
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 2,
                          ),
                          const Divider(
                            color: Pallete.whiteColor,
                          )
                        ],
                      ),
                    ),
                  ),
                ];
              },
              body: ref.watch(getUserTweetsProvider(user.uid)).when(
                    data: (tweets) {
                      return ref.watch(getLatestTweetProvider).when(
                            data: (data) {
                              final latestTweet = Tweet.fromMap(data.payload);

                              bool isTweetAlreadyPresent = false;

                              for (final tweetModel in tweets) {
                                if (tweetModel.id == latestTweet.id) {
                                  isTweetAlreadyPresent = true;
                                  break;
                                }
                              }

                              if (!isTweetAlreadyPresent) {
                                if (data.events.contains(
                                    'databases.*.collections.${AppWriteConstants.tweetCollections}.documents.*.create')) {
                                  // condition is above
                                  tweets.insert(0, Tweet.fromMap(data.payload));
                                } else if (data.events.contains(
                                    'databases.*.collections.${AppWriteConstants.tweetCollections}.documents.*.update')) {
                                  // Steps for fetching the updates of retweeted in a App.
                                  // 1. get id of original tweet
                                  // 2. remove that tweet
                                  // 3. replace with the updated tweet

                                  // Step 1
                                  // find index of tweet from index array
                                  final startingPoint =
                                      data.events[0].lastIndexOf('documents.');

                                  final endPoint =
                                      data.events[0].lastIndexOf('.update');
                                  // Finding the tweetID form the data.events
                                  final tweetID = data.events[0].substring(
                                      startingPoint + 10,
                                      endPoint); //10 = no. of characters in "documents."
                                  // fetching that particular tweet
                                  var tweet = tweets
                                      .where((element) => element.id == tweetID)
                                      .first;
                                  // fetching the tweetIndex before removing the tweet
                                  final tweetIndex = tweets.indexOf(tweet);
                                  // Step 2
                                  // remove the tweet
                                  tweets.removeWhere(
                                      (element) => element.id == tweetID);
                                  // get new latest data
                                  tweet = Tweet.fromMap(data.payload);

                                  // Step 3
                                  // add the latest data
                                  tweets.insert(tweetIndex, tweet);
                                }
                              }

                              return ListView.builder(
                                itemCount: tweets.length,
                                itemBuilder: (context, index) {
                                  final tweet = tweets[index];
                                  return TweetCard(tweet: tweet);
                                },
                              );
                            },
                            error: (error, stackTrace) => ErrorText(
                              error: error.toString(),
                            ),
                            loading: () {
                              return ListView.builder(
                                itemCount: tweets.length,
                                itemBuilder: (context, index) {
                                  final tweet = tweets[index];
                                  return TweetCard(tweet: tweet);
                                },
                              );
                            },
                          );
                    },
                    error: (error, stackTrace) {
                      return ErrorText(
                        error: error.toString(),
                      );
                    },
                    loading: () => const Loader(),
                  ),
            ),
    );
  }
}
