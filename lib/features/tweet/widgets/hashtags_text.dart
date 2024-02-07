// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:twitter_clone/features/tweet/views/hashtag_view.dart';
import 'package:twitter_clone/theme/pallete.dart';

class HashtagText extends StatelessWidget {
  final String text;
  const HashtagText({
    super.key,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    List<TextSpan> textSpans = [];

    text.split(' ').forEach((element) {
      if (element.startsWith('#')) {
        textSpans.add(
          TextSpan(
            text: '$element ',
            style: const TextStyle(
              color: Pallete.blueColor,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
            recognizer: TapGestureRecognizer()
              ..onTap = () {
                Navigator.push(
                  context,
                  HashtagView.route(element),
                );
              },
          ),
        );
      } else if (element.startsWith('www.') || element.startsWith('https://')) {
        textSpans.add(
          TextSpan(
            text: '$element ',
            style: const TextStyle(
              color: Pallete.blueColor,
              fontSize: 18,
              // fontWeight: FontWeight.bold,
            ),
          ),
        );
      } else {
        textSpans.add(
          TextSpan(
            text: '$element ',
            style: const TextStyle(
              color: Pallete.greyColor,
              fontSize: 18,
            ),
          ),
        );
      }
    });

    return RichText(text: TextSpan(children: textSpans));
  }
}
