import 'package:atendimento_samu_app/screens/signin.dart';
import 'package:atendimento_samu_app/screens/signup.dart';
import 'package:flutter/material.dart';

class SignInOrSignUp extends StatefulWidget {
  const SignInOrSignUp({super.key});

  @override
  State<SignInOrSignUp> createState() => _SignInOrSignUpState();
}

class _SignInOrSignUpState extends State<SignInOrSignUp> {
  bool showSignInPage = true;

  void togglePages() {
    setState(() {
      showSignInPage = !showSignInPage;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (showSignInPage) {
      return SignIn(onTap: () => togglePages());
    }

    return SignUp(onTap: () => togglePages());
  }
}
