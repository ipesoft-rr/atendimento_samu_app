import 'package:atendimento_samu_app/screens/chat.dart';
import 'package:atendimento_samu_app/services/auth/auth_service.dart';
import 'package:atendimento_samu_app/services/chat/chat_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key, required this.title});

  final String title;

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final ChatService _chatService = ChatService();
  final AuthService _authService = AuthService();

  void signOut() {
    final authService = Provider.of<AuthService>(context, listen: false);
    authService.signOut();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.primary,
        title: Text(
          widget.title,
          style: const TextStyle(
            color: Colors.white,
          ),
        ),
        actions: [
          IconButton(
              onPressed: signOut,
              icon: const Icon(
                Icons.logout,
                color: Colors.white,
              ))
        ],
      ),
      body: _authService.isAdmin()
          ? _buildUserList()
          : ListView(
              padding: const EdgeInsets.all(24),
              children: [
                const Text(
                  'Bem vindo!',
                  style: TextStyle(
                    fontSize: 32.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const Text(
                  'Deseja solicitar um atendimento?',
                  style: TextStyle(fontSize: 16),
                ),
                const SizedBox(
                  height: 20,
                ),
                ElevatedButton(
                  onPressed: () => context.go('/details'),
                  style: ButtonStyle(
                    backgroundColor: MaterialStatePropertyAll(
                      Theme.of(context).colorScheme.primary,
                    ),
                  ),
                  child: const Text(
                    'SOLICITAR AJUDA!',
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                const Text(
                  'Quando devo acionar o samu?',
                  style: TextStyle(fontSize: 16),
                ),
                const SizedBox(height: 16),
                const Text(
                    '\u2022 Na ocorrência de problemas cardio-respiratórios.'),
                const Text('\u2022 Intoxicação exógena e envenenamento.'),
                const Text('\u2022 Queimaduras graves.'),
                const Text('\u2022 Na ocorrência de maus tratos.'),
                const Text(
                    '\u2022 Trabalhos de parto em que haja risco de morte da mãe ou do feto.'),
                const Text('\u2022 Em tentativas de suicídio.'),
                const Text(
                    '\u2022 Crises hipertensivas e dores no peito de aparecimento súbito.'),
                const Text(
                    '\u2022 Quando houver acidentes/traumas com vítimas.'),
                const Text('\u2022 Afogamentos.'),
                const Text('\u2022 Choque elétrico.'),
                const Text('\u2022 Acidentes com produtos perigosos.'),
                const Text(
                    '\u2022 Suspeita de Infarto ou AVC (alteração súbita na fala, perda de força em um lado do corpo e desvio da comissura labial são os sintomas mais comuns).'),
                const Text('\u2022 Agressão por arma de fogo ou arma branca.'),
                const Text('\u2022 Soterramento, Desabamento.'),
                const Text('\u2022 Crises Convulsivas.'),
                const Text(
                    '\u2022 Transferência inter-hospitalar de doentes graves.'),
                const Text(
                    '\u2022 Outras situações consideradas de urgência ou emergência, com risco de morte, sequela ou sofrimento intenso.'),
              ],
            ),
    );
  }

  Widget _buildUserList() {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance.collection('users').snapshots(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return const Text('error');
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Text('loading');
        }

        return ListView(
          children: snapshot.data!.docs
              .map<Widget>(
                (doc) => _buildUserListItem(doc),
              )
              .toList(),
        );
      },
    );
  }

  Widget _buildUserListItem(DocumentSnapshot document) {
    Map<String, dynamic> data = document.data()! as Map<String, dynamic>;

    List<String> ids = [data['uid'], 'v6CrEksU4dafuKK3qxcYfiDehP72'];
    ids.sort();
    String chatRoomId = ids.join('_');

    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance
          .collection('chat_rooms')
          .doc(chatRoomId)
          .collection('messages')
          .snapshots(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return const Text('error');
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Text('loading');
        }

        return ListTile(
          title:
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            Text(
              data['email'],
            ),
            snapshot.data!.docs.isEmpty
                ? const Icon(
                    Icons.check,
                    color: Colors.red,
                  )
                : const Icon(
                    Icons.mark_chat_unread_outlined,
                    color: Colors.red,
                  )
          ]),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ChatScreen(
                  receiverUserEmail: data['email'],
                  receiverUserID: data['uid'],
                ),
              ),
            );
          },
        );
      },
    );
  }
}
