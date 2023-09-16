import 'package:atendimento_samu_app/model/message.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ChatService extends ChangeNotifier {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final FirebaseFirestore _fireStore = FirebaseFirestore.instance;

  Future<void> sendMessage(String receiverId, String message) async {
    final String currentUserId = _firebaseAuth.currentUser!.uid;
    final String currentUserEmail = _firebaseAuth.currentUser!.email.toString();
    final Timestamp timestamp = Timestamp.now();

    Message newMessage = Message(
      senderId: currentUserId,
      senderEmail: currentUserEmail,
      receiverId: receiverId,
      message: message,
      timestamp: timestamp,
    );

    List<String> ids = [currentUserId, receiverId];
    ids.sort();
    String chatRoomId = ids.join('_');

    await _fireStore
        .collection('chat_rooms')
        .doc(chatRoomId)
        .collection('messages')
        .add(newMessage.toMap());
  }

  Stream<QuerySnapshot> getMessages(String userId, String otherUserId) {
    List<String> ids = [userId, otherUserId];
    ids.sort();
    String chatRoomId = ids.join('_');

    return _fireStore
        .collection('chat_rooms')
        .doc(chatRoomId)
        .collection('messages')
        .orderBy('timestamp', descending: false)
        .snapshots();
  }

  Future<void> clearChatRoomMessages(String receiverId) async {
    try {
      final String currentUserId = _firebaseAuth.currentUser!.uid;

      List<String> ids = [currentUserId, receiverId];
      ids.sort();
      String chatRoomId = ids.join('_');

      await _fireStore
          .collection('chat_rooms')
          .doc(chatRoomId)
          .collection('messages')
          .get()
          .then((value) => {
                value.docs.forEach((element) {
                  element.reference.delete();
                })
              });
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<bool> hasMessages(String userId) async {
    try {
      List<String> ids = [userId, 'ipe@gmail.com'];
      ids.sort();
      String chatRoomId = ids.join('_');

      final querySnapshot = await _fireStore
          .collection('chat_rooms')
          .doc(chatRoomId)
          .collection('messages')
          .get();

      return querySnapshot.docs.isNotEmpty;
    } catch (e) {
      throw Exception('Erro ao verificar mensagens: $e');
    }
  }
}
