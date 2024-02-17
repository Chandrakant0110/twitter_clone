// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import 'package:twitter_clone/theme/pallete.dart';

class AuthField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  bool obSecureText;

  AuthField({
    super.key,
    required this.controller,
    required this.hintText,
    required this.obSecureText,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      child: TextFormField(
        controller: controller,
        
        cursorColor: Pallete.whiteColor,
        obscureText: obSecureText,
        decoration: InputDecoration(
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(4),
            borderSide: const BorderSide(
              color: Pallete.blueColor,
              width: 1.5,
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(4),
            borderSide: const BorderSide(
              color: Pallete.greyColor,
              // width: 3,
            ),
          ),
          contentPadding: const EdgeInsets.all(22),
          hintText: hintText,
        ),
      ),
    );
  }
}
