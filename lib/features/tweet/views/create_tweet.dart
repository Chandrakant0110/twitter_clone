import 'dart:async';
import 'dart:io';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:twitter_clone/common/common.dart';
import 'package:twitter_clone/constants/assets_constants.dart';
import 'package:twitter_clone/core/utils.dart';
import 'package:twitter_clone/features/auth/controller/auth_controller.dart';
import 'package:twitter_clone/theme/pallete.dart';

class CreateTweetScreen extends ConsumerStatefulWidget {
  static route() => MaterialPageRoute(
        builder: (context) => const CreateTweetScreen(),
      );
  const CreateTweetScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _CreateTweetScreenState();
}

class _CreateTweetScreenState extends ConsumerState<CreateTweetScreen> {
  final TextEditingController tweetTextController = TextEditingController();
  List<XFile> images = [];

  @override
  void dispose() {
    super.dispose();
    tweetTextController.dispose();
  }

  void onPickImages() async {
    print('pick images function called');
    images = await pickImage();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final currentUser = ref.watch(currentUserDetailsProvider).value;

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.close, size: 30),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.all(2.0),
            child: RoundedButton(
              onTap: () {
                print('drafts button clicked');
              },
              label: 'Drafts',
              backgroundColor: Pallete.backgroundColor,
              textColor: Pallete.blueColor,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(2.0),
            child: RoundedButton(
              onTap: () {
                print('tweet button clicked');
              },
              label: 'Post',
              backgroundColor: Pallete.blueColor,
              textColor: Pallete.whiteColor,
            ),
          ),
        ],
      ),
      body: currentUser == null
          ? const Loader()
          : SafeArea(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          CircleAvatar(
                            backgroundImage:
                                NetworkImage(currentUser.profilePic),
                            radius: 28,
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Expanded(
                            child: TextField(
                              controller: tweetTextController,
                              style: const TextStyle(
                                fontSize: 20,
                              ),
                              decoration: const InputDecoration(
                                hintText: 'What\'s happening?',
                                hintStyle: TextStyle(
                                  color: Pallete.greyColor,
                                  fontSize: 20,
                                  fontWeight: FontWeight.w400,
                                ),
                                border: InputBorder.none,
                              ),
                              maxLines: null,
                              maxLength: 256,
                            ),
                          ),
                        ],
                      ),
                    ),
                    if (images.isNotEmpty)
                      CarouselSlider(
                        items: images.map((xfile) {
                          File file = File(xfile.path);
                          return Container(
                              width: MediaQuery.of(context).size.width,
                              margin: const EdgeInsets.symmetric(horizontal: 5),
                              child: Image.file(file));
                        }).toList(),
                        options: CarouselOptions(
                          height: 400,
                          enableInfiniteScroll: false,
                        ),
                      ),
                  ],
                ),
              ),
            ),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.only(bottom: 10),
        decoration: const BoxDecoration(
          border: Border(
            top: BorderSide(
              color: Pallete.greyColor,
              width: 0.3,
            ),
          ),
        ),
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0).copyWith(
                left: 15,
                right: 15,
              ),
              child: GestureDetector(
                  onTap: onPickImages,
                  child: SvgPicture.asset(AssetsConstants.galleryIcon)),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0).copyWith(
                left: 15,
                right: 15,
              ),
              child: SvgPicture.asset(AssetsConstants.gifIcon),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0).copyWith(
                left: 15,
                right: 15,
              ),
              child: SvgPicture.asset(AssetsConstants.emojiIcon),
            ),
          ],
        ),
      ),
    );
  }
}
