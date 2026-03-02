import 'package:chat_app_with_ai/utilities/constants/app_constants.dart';
import 'package:google_generative_ai/google_generative_ai.dart';
import 'package:flutter/cupertino.dart';

class ChatService {
  late final GenerativeModel _model;
  ChatSession? _chatSession;

  ChatService() {
    _model = GenerativeModel(
      model: 'gemini-2.0-flash',
      apiKey: AppConstants.apiKey,
    );
  }

  void startChatSession() {
    _chatSession = _model.startChat();
  }

  Future<String?> sendMessage(String message) async {
    try {
      if (_chatSession == null) startChatSession();

      final response = await _chatSession!.sendMessage(Content.text(message));
      return response.text;
    } catch (e) {
      debugPrint('Service Error: $e');
      rethrow;
      // return 'Something went wrong.';
    }
  }
}
