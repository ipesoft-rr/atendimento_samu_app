import 'package:atendimento_samu_app/components/chat_bubble.dart';
import 'package:atendimento_samu_app/components/my_text_field.dart';
import 'package:atendimento_samu_app/services/chat/chat_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ChatScreen extends StatefulWidget {
  final String receiverUserEmail;
  final String receiverUserID;

  const ChatScreen({
    super.key,
    required this.receiverUserEmail,
    required this.receiverUserID,
  });

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final TextEditingController _messageController = TextEditingController();
  final ChatService _chatService = ChatService();
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  void sendMessage() async {
    if (_messageController.text.isNotEmpty) {
      await _chatService.sendMessage(
          widget.receiverUserID, _messageController.text);

      _messageController.clear();
    }
  }

  void finishChat(BuildContext context) async {
    context.push('/');
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
          content: Text('Chamado finalizado'), backgroundColor: Colors.green),
    );
    await _chatService.sendMessage(widget.receiverUserID, 'CHAMADO FINALIZADO');
    await _chatService.clearChatRoomMessages(widget.receiverUserID);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white),
        backgroundColor: Theme.of(context).colorScheme.primary,
        automaticallyImplyLeading:
            _firebaseAuth.currentUser!.displayName == 'anonimo@gmail.com',
        title: Text(
          widget.receiverUserEmail,
          style: const TextStyle(
            color: Colors.white,
          ),
        ),
        actions: widget.receiverUserEmail != 'ipe@gmail.com'
            ? [
                IconButton(
                    onPressed: () => finishChat(context),
                    icon: const Icon(
                      Icons.health_and_safety,
                      color: Colors.white,
                    ))
              ]
            : [],
      ),
      body: SafeArea(
        child: Column(children: [
          Expanded(
            child: _buildMessageList(),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(24, 0, 0, 6),
            child: _buildMessageInput(),
          )
        ]),
      ),
    );
  }

  Widget _buildMessageList() {
    return StreamBuilder(
      stream: _chatService.getMessages(
        widget.receiverUserID,
        _firebaseAuth.currentUser!.uid,
      ),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Text('Error${snapshot.error}');
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Text('loading..');
        }

        for (var document in snapshot.data!.docs) {
          Map<String, dynamic> data = document.data() as Map<String, dynamic>;
          bool isNotAdmin = widget.receiverUserEmail == 'ipe@gmail.com';
          if (data['message'] == 'CHAMADO FINALIZADO' && isNotAdmin) {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              context.push('/finished');
            });
          }
        }

        return ListView(
          children: snapshot.data!.docs
              .map((document) => _buildMessageItem(document))
              .toList(),
        );
      },
    );
  }

  Widget _buildMessageItem(DocumentSnapshot document) {
    Map<String, dynamic> data = document.data() as Map<String, dynamic>;

    var alignment = (data['senderId'] == _firebaseAuth.currentUser!.uid)
        ? Alignment.centerRight
        : Alignment.centerLeft;

    return Container(
      alignment: alignment,
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: Column(
          crossAxisAlignment:
              (data['senderId'] == _firebaseAuth.currentUser!.uid)
                  ? CrossAxisAlignment.end
                  : CrossAxisAlignment.start,
          mainAxisAlignment:
              (data['senderId'] == _firebaseAuth.currentUser!.uid)
                  ? MainAxisAlignment.end
                  : MainAxisAlignment.start,
          children: [
            Text(data['senderEmail']),
            const SizedBox(
              height: 5,
            ),
            ChatBubble(message: data['message']),
          ],
        ),
      ),
    );
  }

  Widget _buildMessageInput() {
    return Row(
      children: [
        Expanded(
          child: MyTextField(
            controller: _messageController,
            hintText: 'Digite a mensagem',
            obscureText: false,
            onSubmitted: sendMessage,
          ),
        ),
        IconButton(
            onPressed: sendMessage,
            icon: const Icon(
              Icons.arrow_upward,
              size: 40,
            ))
      ],
    );
  }
}
