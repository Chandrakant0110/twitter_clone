import 'package:flutter/material.dart';
import 'package:twitter_clone/theme/pallete.dart';

class AuthField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final obSecureText;

  const AuthField({
    super.key,
    required this.controller,
    required this.hintText,
    this.obSecureText,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      // obscureText: obSecureText,
      decoration: InputDecoration(
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(
            color: Pallete.blueColor,
            width: 3,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(
            color: Pallete.greyColor,
            // width: 3,
          ),
        ),
        contentPadding: const EdgeInsets.all(22),
        hintText: hintText,
      ),
    );
  }
}
