import 'package:flutter/material.dart';

import 'package:lottie/lottie.dart';
import 'package:go_router/go_router.dart';

class FinishedScreen extends StatelessWidget {
  const FinishedScreen({super.key});

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
                context.go('/');
              },
              child: const Text('Início'))
        ]),
      ),
    );
  }
}
