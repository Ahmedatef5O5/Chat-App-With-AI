import 'package:firebase_ai/firebase_ai.dart';
import 'package:firebase_app_check/firebase_app_check.dart';
import 'package:flutter/cupertino.dart';

class ChatService {
  final GenerativeModel _model;
  ChatSession? _chatSession;

  ChatService()
    : _model = FirebaseAI.vertexAI(
        appCheck: FirebaseAppCheck.instance,
      ).generativeModel(model: 'gemini-2.5-flash-lite');

  void startChatSession() {
    _chatSession = _model.startChat();
  }

  Future<String?> sendMessage(String message) async {
    try {
      if (_chatSession == null) startChatSession();

      final response = await _chatSession!.sendMessage(Content.text(message));
      return response.text;
    } catch (e) {
      debugPrint('Error: $e');
      return 'Something went wrong.';
    }
  }
}
