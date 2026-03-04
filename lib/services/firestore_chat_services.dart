import 'package:chat_app_with_ai/models/message_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../models/chat_model.dart';

class FirestoreChatServices {
  final _firestore = FirebaseFirestore.instance;
  final _auth = FirebaseAuth.instance;

  String get _uid => _auth.currentUser!.uid;

  /// create new chat
  Future<String> createChat() async {
    final doc =
        _firestore.collection('users').doc(_uid).collection('chats').doc();
    await doc.set({
      'title': 'New Chat',
      'createdAt': DateTime.now().toIso8601String(),
      'updatedAt': DateTime.now().toIso8601String(),
      'lastMessage': '',
    });
    return doc.id;
  }

  /// save message
  Future<void> saveMessage(String chatId, MessageModel message) async {
    final chatRef = _firestore
        .collection('users')
        .doc(_uid)
        .collection('chats')
        .doc(chatId);
    await chatRef.collection('messages').add({
      'text': message.text,
      'isUser': message.isUser,
      'createdAt': message.time.toIso8601String(),
    });
    await chatRef.set({
      'lastMessage': message.text,
      'updatedAt': DateTime.now().toIso8601String(),
    }, SetOptions(merge: true));
  }

  /// get messages
  Future<List<MessageModel>> getMessages(String chatId) async {
    final snapshot =
        await _firestore
            .collection('users')
            .doc(_uid)
            .collection('chats')
            .doc(chatId)
            .collection('messages')
            .orderBy('createdAt')
            .get();

    return snapshot.docs.map((doc) {
      final data = doc.data();
      return MessageModel(
        text: data['text'] ?? '',
        isUser: data['isUser'] ?? true,
        time: DateTime.parse(data['createdAt']),
      );
    }).toList();
  }

  Future<void> ensureChatExists(String chatId) async {
    final chatRef = _firestore
        .collection('users')
        .doc(_uid)
        .collection('chats')
        .doc(chatId);

    final snapshot = await chatRef.get();

    if (!snapshot.exists) {
      await chatRef.set({
        'title': 'Temp Chat',
        'createdAt': DateTime.now().toIso8601String(),
        'updatedAt': DateTime.now().toIso8601String(),
        'lastMessage': '',
      });
    }
  }

  /// load messages
  Stream<List<MessageModel>> messagesStream(String chatId) {
    return _firestore
        .collection('users')
        .doc(_uid)
        .collection('chats')
        .doc(chatId)
        .collection('messages')
        .orderBy('createdAt')
        .snapshots()
        .map(
          (snapshot) =>
              snapshot.docs.map((doc) {
                final data = doc.data();
                return MessageModel(
                  text: data['text'],
                  isUser: data['isUser'],
                  time: DateTime.parse(data['createdAt']),
                );
              }).toList(),
        );
  }

  /// load chats list
  Stream<List<ChatModel>> chatsStream() {
    return _firestore
        .collection('users')
        .doc(_uid)
        .collection('chats')
        .orderBy('updatedAt', descending: true)
        .snapshots()
        .map(
          (snapshot) =>
              snapshot.docs
                  .map((doc) => ChatModel.fromMap(doc.data(), doc.id))
                  .toList(),
        );
  }
}
