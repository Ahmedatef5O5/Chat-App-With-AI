import 'package:chat_app_with_ai/utilities/constants/app_constants.dart';
import 'package:google_generative_ai/google_generative_ai.dart';
import 'package:flutter/cupertino.dart';

class ChatService {
  // final GenerativeModel _model;
  late final GenerativeModel _model;
  ChatSession? _chatSession;

  ChatService() {
    _model = GenerativeModel(
      model: 'gemini-2.5-flash-lite',
      apiKey: AppConstants.apiKey,
    );
  }
  // ChatService()
  //   : _model = FirebaseAI.vertexAI(
  //       appCheck: FirebaseAppCheck.instance,
  //       location: 'us-central1',
  //     ).generativeModel(model: 'gemini-2.5-flash-lite');

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
