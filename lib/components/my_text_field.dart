import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class MyTextField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final bool obscureText;
  final TextInputFormatter? mask;
  final Function? onSubmitted;

  const MyTextField(
      {super.key,
      required this.controller,
      required this.hintText,
      required this.obscureText,
      this.mask,
      this.onSubmitted});

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      obscureText: obscureText,
      decoration: InputDecoration(
        hintText: hintText,
      ),
      inputFormatters: mask != null ? [mask as TextInputFormatter] : [],
      onSubmitted: (value) {
        if (onSubmitted != null) {
          onSubmitted!();
        }
      },
    );
  }
}
