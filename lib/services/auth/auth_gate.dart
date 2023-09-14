import 'package:atendimento_samu_app/services/auth/signin_or_signup.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:atendimento_samu_app/screens/home.dart';

class AuthGate extends StatelessWidget {
  const AuthGate({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return const HomeScreen(title: 'Início');
          } else {
            return const SignInOrSignUp();
          }
        },
      ),
    );
  }
}
