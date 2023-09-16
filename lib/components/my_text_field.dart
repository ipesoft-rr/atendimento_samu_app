import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class MyTextField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final bool obscureText;
  final TextInputFormatter? mask;

  const MyTextField(
      {super.key,
      required this.controller,
      required this.hintText,
      required this.obscureText,
      this.mask});

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      obscureText: obscureText,
      decoration: InputDecoration(
        hintText: hintText,
      ),
      inputFormatters: mask != null ? [mask as TextInputFormatter] : [],
    );
  }
}
