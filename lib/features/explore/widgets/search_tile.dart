// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:twitter_clone/features/user_profile/views/user_profile_view.dart';

import 'package:twitter_clone/models/user_model.dart';
import 'package:twitter_clone/theme/pallete.dart';

class SearchTile extends StatelessWidget {
  final UserModel userModel;
  const SearchTile({
    super.key,
    required this.userModel,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () {
        Navigator.push(
          context,
          UserProfileView.route(userModel),
        );
        print('list tile  clicked for user-profile');
      },
      leading: CircleAvatar(
        backgroundImage: userModel.profilePic.isEmpty
            ? const NetworkImage(
                'https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_1280.png')
            : NetworkImage(
                userModel.profilePic,
              ),
        radius: 30,
      ),
      title: Text(
        userModel.name,
        style: const TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.w600,
        ),
      ),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '@${userModel.name}',
            style: const TextStyle(
              fontSize: 16,
            ),
          ),
          Text(
            userModel.bio,
            style: const TextStyle(
              color: Pallete.whiteColor,
            ),
          ),
        ],
      ),
    );
  }
}
