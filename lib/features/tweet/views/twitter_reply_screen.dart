// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:twitter_clone/common/common.dart';
import 'package:twitter_clone/constants/constants.dart';
import 'package:twitter_clone/features/tweet/controller/tweet_controller.dart';
import 'package:twitter_clone/features/tweet/widgets/tweet_card.dart';

import 'package:twitter_clone/models/tweet_model.dart';

class TwitterReplyScreen extends ConsumerWidget {
  static route(Tweet tweet) => MaterialPageRoute(
        builder: (context) => TwitterReplyScreen(
          tweet: tweet,
        ),
      );

  final Tweet tweet;
  const TwitterReplyScreen({
    super.key,
    required this.tweet,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: UIConstants.appBar(),
      body: Column(
        children: [
          TweetCard(tweet: tweet),
          ref.watch(getRepliesToTweetProvider(tweet)).when(
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

                          if (!isTweetAlreadyPresent &&
                              latestTweet.repliedTo == tweet.id) {
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

                          return Expanded(
                            child: ListView.builder(
                              itemCount: tweets.length,
                              itemBuilder: (context, index) {
                                final tweet = tweets[index];
                                return TweetCard(tweet: tweet);
                              },
                            ),
                          );
                        },
                        error: (error, stackTrace) => ErrorText(
                          error: error.toString(),
                        ),
                        loading: () {
                          return Expanded(
                            child: ListView.builder(
                              itemCount: tweets.length,
                              itemBuilder: (context, index) {
                                final tweet = tweets[index];
                                return TweetCard(tweet: tweet);
                              },
                            ),
                          );
                        },
                      );
                },
                error: (error, stackTrace) => ErrorText(
                  error: error.toString(),
                ),
                loading: () => const Loader(),
              ),
        ],
      ),
      bottomNavigationBar: TextField(
        onSubmitted: (value) {
          ref.read(tweetControllerProvider.notifier).shareTweet(
            images: [],
            text: value,
            context: context,
            repliedTo: tweet.id,
          );
        },
        decoration: const InputDecoration(
          hintText: 'Reply to this tweet',
        ),
      ),
    );
  }
}
