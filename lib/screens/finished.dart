import 'package:flutter/material.dart';

import 'package:lottie/lottie.dart';
import 'package:go_router/go_router.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FinishedScreen extends StatefulWidget {
  const FinishedScreen({super.key});

  @override
  State<FinishedScreen> createState() => _FinishedScreenState();
}

class _FinishedScreenState extends State<FinishedScreen> {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          Lottie.asset(
            'assets/finished1.json',
            width: 300,
            height: 300,
            repeat: false,
          ),
          const Text(
            'A ajuda está a caminho!',
            style: TextStyle(
              fontSize: 24,
            ),
          ),
          const SizedBox(height: 8),
          ElevatedButton(
              onPressed: () {
                if (_firebaseAuth.currentUser!.displayName != 'anonimo@gmail.com') {
                  _firebaseAuth.signOut();
                  context.push('/');
                } else {
                  _firebaseAuth.signOut();
                  context.push('/signin');
                }
              },
              child: const Text('Início'))
        ]),
      ),
    );
  }
}
