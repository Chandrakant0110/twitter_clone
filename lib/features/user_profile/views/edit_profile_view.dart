
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:twitter_clone/common/common.dart';
import 'package:twitter_clone/core/utils.dart';
import 'package:twitter_clone/features/auth/controller/auth_controller.dart';
import 'package:twitter_clone/features/user_profile/controller/user_profile_controller.dart';
import 'package:twitter_clone/theme/theme.dart';

class EditProfileView extends ConsumerStatefulWidget {
  static route() => MaterialPageRoute(
        builder: (context) => const EditProfileView(),
      );

  const EditProfileView({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _EditProfileViewState();
}

class _EditProfileViewState extends ConsumerState<EditProfileView> {
  late TextEditingController nameController;
  late TextEditingController bioController;

  File? bannerFile;
  File? profileFile;

  @override
  void initState() {
    super.initState();
    nameController = TextEditingController(
      text: ref.read(currentUserDetailsProvider).value?.name ?? '',
    );
    bioController = TextEditingController(
      text: ref.read(currentUserDetailsProvider).value?.bio ?? '',
    );
  }

  @override
  void dispose() {
    super.dispose();
    nameController.dispose();
    bioController.dispose();
  }

  void selectBannerImage() async {
    final bannerImg = await pickImage();
    if (bannerImg != null) {
      setState(() {
        bannerFile = bannerImg;
      });
    }
  }

  void selectProfileImage() async {
    final profileImg = await pickImage();
    if (profileImg != null) {
      setState(() {
        profileFile = profileImg;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final user = ref.watch(currentUserDetailsProvider).value;
    final isLoading = ref.watch(userProfileControllerProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Profile'),
        // centerTitle: true,
        actions: [
          TextButton(
            onPressed: () {
              ref
                  .read(userProfileControllerProvider.notifier)
                  .updateUserProfile(
                    userModel: user!.copyWith(
                      name: nameController.text,
                      bio: bioController.text,
                    ),
                    context: context,
                    bannerFile: bannerFile,
                    profileFile: profileFile,
                  );
            },
            child: const Text(
              'Save',
              style: TextStyle(
                color: Pallete.blueColor,
              ),
            ),
          ),
        ],
      ),
      body: isLoading || user == null
          ? const Loader()
          : Column(
              children: [
                SizedBox(
                  height: 200,
                  child: Stack(
                    children: [
                      GestureDetector(
                        onTap: selectBannerImage,
                        child: Container(
                          width: double.infinity,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10)),
                          child: bannerFile != null
                              ? Image.file(bannerFile!)
                              : user.bannerPic.isEmpty
                                  ? Container(
                                      color: Pallete.blueColor,
                                    )
                                  : Image.network(
                                      user.bannerPic,
                                      fit: BoxFit.fitWidth,
                                    ),
                        ),
                      ),
                      Positioned(
                        bottom: 20,
                        left: 20,
                        child: GestureDetector(
                          onTap: selectProfileImage,
                          child: profileFile != null
                              ? CircleAvatar(
                                  backgroundImage: FileImage(profileFile!),
                                  radius: 40,
                                )
                              : CircleAvatar(
                                  backgroundImage:
                                      NetworkImage(user.profilePic),
                                  radius: 40,
                                ),
                        ),
                      ),
                    ],
                  ),
                ),
                TextField(
                  controller: nameController,
                  decoration: const InputDecoration(
                    hintText: 'Name',
                    contentPadding: EdgeInsets.all(18),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                TextField(
                  controller: bioController,
                  decoration: const InputDecoration(
                    hintText: 'Bio',
                    contentPadding: EdgeInsets.all(18),
                  ),
                  maxLines: 4,
                ),
              ],
            ),
    );
  }
}
