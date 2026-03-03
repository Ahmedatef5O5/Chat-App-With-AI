import 'dart:io';
import 'package:chat_app_with_ai/utilities/constants/app_constants.dart';
import 'package:google_generative_ai/google_generative_ai.dart';
import 'package:flutter/cupertino.dart';

class ChatService {
  late final GenerativeModel _model;
  ChatSession? _chatSession;

  ChatService() {
    _model = GenerativeModel(
      model: 'gemini-2.0-flash',
      // model: 'gemini-2.5-flash',
      apiKey: AppConstants.apiKey,
    );
  }

  void startChatSession() {
    _chatSession = _model.startChat();
  }

  Future<String?> sendMessage(
    String message, [
    File? image,
    File? file,
    File? audio,
  ]) async {
    List<Part> parts = [TextPart(message)];

    if (image != null) {
      parts.add(DataPart('image/jpeg', await image.readAsBytes()));
    }

    if (file != null) {
      parts.add(DataPart('application/pdf', await file.readAsBytes()));
    }

    if (audio != null) {
      parts.add(DataPart('audio/m4a', await audio.readAsBytes()));
    }
    final content = Content.multi(parts);
    try {
      if (_chatSession == null) startChatSession();

      final response = await _chatSession!.sendMessage(content);
      return response.text;
    } catch (e) {
      debugPrint('Service Error: $e');
      rethrow;
      // return 'Something went wrong.';
    }
  }
}
