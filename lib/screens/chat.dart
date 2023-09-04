import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.primary,
        title: const Text(
          'Chat',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      ),
      body: ElevatedButton(
        child: const Text('Finalizar'),
        onPressed: () {
          context.push('/finished');
        },
      ),
    );
  }
}
