import 'package:atendimento_samu_app/screens/onboarding_screen.dart';
import 'package:atendimento_samu_app/services/auth/signin_or_signup.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:atendimento_samu_app/screens/home.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthGate extends StatefulWidget {
  const AuthGate({super.key});

  @override
  State<AuthGate> createState() => _AuthGateState();
}

class _AuthGateState extends State<AuthGate> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return const HomeScreen(title: 'Início');
          } else {
            return FutureBuilder<bool>(
              future: checkOnboardingStatus(),
              builder: (context, onboardingSnapshot) {
                bool showSignInOrSignUp = onboardingSnapshot.data == true;
                if (onboardingSnapshot.connectionState ==
                    ConnectionState.waiting) {
                  return const CircularProgressIndicator();
                } else {
                  bool isOnboardingCompleted = showSignInOrSignUp;

                  if (isOnboardingCompleted) {
                    return const SignInOrSignUp();
                  } else {
                    return OnboardingScreen(
                      callback: () {
                        setState(() {
                          isOnboardingCompleted = true;
                        });
                      },
                    );
                  }
                }
              },
            );
          }
        },
      ),
    );
  }

  Future<bool> checkOnboardingStatus() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final bool onboardingCompleted =
        prefs.getBool('onboarding_completed') ?? false;
    return onboardingCompleted;
  }
}
