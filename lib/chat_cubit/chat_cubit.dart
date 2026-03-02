import 'dart:io';

import 'package:chat_app_with_ai/models/message_model.dart';
import 'package:chat_app_with_ai/services/native_services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

import '../services/chat_services.dart';
part 'chat_state.dart';

class ChatCubit extends Cubit<ChatState> {
  ChatCubit() : super(ChatInitial());

  final _chatService = ChatService();
  final _nativeService = NativeServices();

  final List<MessageModel> _allMessages = [];
  File? selectedImage;

  Future<void> sendMessage(String userText) async {
    if (userText.trim().isEmpty) return;
    _allMessages.add(
      MessageModel(
        text: userText,
        isUser: true,
        time: DateTime.now(),
        image: selectedImage,
      ),
    );
    _allMessages.add(
      MessageModel(
        text: userText,
        isUser: false,
        isLoading: true,
        time: DateTime.now(),
      ),
    );
    emit(ChatLoading(List.from(_allMessages)));
    try {
      final aiResponse = await _chatService.sendMessage(
        userText,
        selectedImage,
      );
      _allMessages.removeLast();
      _allMessages.add(
        MessageModel(
          isUser: false,
          text: aiResponse ?? 'No response received.',
          time: DateTime.now(),
        ),
      );

      emit(ChatLoading(List.from(_allMessages)));
    } catch (e) {
      String errorMessage = 'An unexpected error occurred. Please try again.';

      final errorString = e.toString().toLowerCase();

      if (errorString.contains('network') || errorString.contains('socket')) {
        errorMessage =
            'Connection failed. Please check your internet and try again.';
      } else if (errorString.contains('quota') || errorString.contains('429')) {
        errorMessage =
            'Rate limit exceeded. Please wait a moment before sending more messages.';
      } else if (errorString.contains('api key') ||
          errorString.contains('invalid')) {
        errorMessage = 'Authentication error. Please contact the developer.';
      } else if (errorString.contains('high demand') ||
          errorString.contains('503') ||
          errorString.contains('unavailable')) {
        errorMessage =
            'Gemini is currently busy. Please try again in a few seconds.';
      } else if (errorString.contains('safety')) {
        errorMessage =
            'Content blocked: This request violates safety policies.';
      }
      _allMessages.removeLast();
      _allMessages.add(
        MessageModel(
          isUser: false,
          time: DateTime.now(),
          text: "Error: $errorMessage",
        ),
      );
      emit(ChatFailure(errorMessage, List.from(_allMessages)));
    }
  }

  Future<void> pickImageFromCamera() async {
    final image = await _nativeService.pickImage(ImageSource.camera);
    if (image != null) {
      selectedImage = image;
      emit(ImagePicked(image, List.from(_allMessages)));
    }
  }

  Future<void> pickImageFromGallery() async {
    final image = await _nativeService.pickImage(ImageSource.gallery);
    if (image != null) {
      selectedImage = image;
      emit(ImagePicked(image, List.from(_allMessages)));
    }
  }

  void removeImage() {
    selectedImage = null;
    emit(ImageRemoved(List.from(_allMessages)));
  }
}
