import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:atendimento_samu_app/services/auth/auth_service.dart';

import 'package:atendimento_samu_app/components/my_button.dart';
import 'package:atendimento_samu_app/components/my_text_field.dart';

class SignIn extends StatefulWidget {
  const SignIn({super.key});

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  void signIn() async {
    final authService = Provider.of<AuthService>(context, listen: false);

    try {
      await authService.signInWithEmailAndPassword(
        emailController.text,
        passwordController.text,
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(e.toString()),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(
                  Icons.message,
                  size: 80,
                ),
                MyTextField(
                  controller: emailController,
                  hintText: 'Email',
                  obscureText: false,
                ),
                const SizedBox(
                  height: 20,
                ),
                MyTextField(
                  controller: passwordController,
                  hintText: 'Password',
                  obscureText: true,
                ),
                MyButton(onTap: signIn, text: 'Sign in'),
                const Row(
                  children: [
                    Text('Not a member?'),
                    SizedBox(
                      width: 4,
                    ),
                    Text('Register now')
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
