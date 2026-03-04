import 'dart:io';

import 'package:chat_app_with_ai/models/message_model.dart';
import 'package:chat_app_with_ai/services/firestore_chat_services.dart';
import 'package:chat_app_with_ai/services/native_services.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../services/chat_services.dart';
part 'chat_state.dart';

class ChatCubit extends Cubit<ChatState> {
  ChatCubit() : super(ChatInitial());
  static const String tempChatId =
      'TEMP_CHAT_ID'; // temp solution just for testing
  late String currentChatId;
  final _firestoreChatService = FirestoreChatServices();
  final _chatService = ChatService();
  final _nativeService = NativeServices();

  final List<MessageModel> allMessages = [];
  File? selectedImage, selectedFile, selectedAudio;

  Future<void> loadChat(String chatId) async {
    currentChatId = chatId;
    await _firestoreChatService.ensureChatExists(chatId);
    final messages = await _firestoreChatService.getMessages(chatId);
    allMessages
      ..clear()
      ..addAll(messages);
    emit(ChatSuccess(List.from(allMessages)));
  }

  Future<void> startNewChat() async {
    currentChatId = await _firestoreChatService.createChat();
    allMessages.clear();
    emit(ChatInitial());
  }

  Future<void> sendMessage(String userText) async {
    if (userText.trim().isEmpty &&
        selectedImage == null &&
        selectedFile == null &&
        selectedAudio == null) {
      return;
    }
    final userMessage = MessageModel(
      text: userText,
      isUser: true,
      time: DateTime.now(),
      image: selectedImage,
      file: selectedFile,
      audio: selectedAudio,
    );
    allMessages.add(userMessage);
    _firestoreChatService.saveMessage(currentChatId, userMessage);

    final botLoadingMessage = MessageModel(
      text: userText,
      isUser: false,
      isLoading: true,
      time: DateTime.now(),
    );
    allMessages.add(botLoadingMessage);
    emit(ChatLoading(List.from(allMessages)));

    try {
      final aiResponse = await _chatService.sendMessage(
        userText,
        selectedImage,
        selectedFile,
        selectedAudio,
      );
      final botMessage = MessageModel(
        isUser: false,
        text: aiResponse ?? 'No response received.',
        time: DateTime.now(),
      );
      allMessages.removeLast();
      allMessages.add(botMessage);

      _firestoreChatService.saveMessage(currentChatId, botMessage);
      // emit(ChatLoading(List.from(_allMessages)));
      selectedImage = null;
      selectedFile = null;
      selectedAudio = null;
      emit(ChatSuccess(List.from(allMessages)));
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
      allMessages.removeLast();
      allMessages.add(
        MessageModel(
          isUser: false,
          time: DateTime.now(),
          text: "Error: $errorMessage",
        ),
      );
      emit(ChatFailure(errorMessage, List.from(allMessages)));
    }
  }

  Future<void> pickDocument() async {
    final file = await _nativeService.pickFile();
    if (file != null) {
      selectedFile = file;
      emit(FilePicked(file, List.from(allMessages)));
    }
  }

  void removeFile() {
    selectedFile = null;
    emit(FileRemoved(List.from(allMessages)));
  }

  Future<void> startRecording() async {
    try {
      var status = await Permission.microphone.request();
      if (status.isGranted) {
        await _nativeService.startRecording();
      } else {
        debugPrint('User cancel request to record');
      }
    } catch (e) {
      debugPrint('Recording Error : $e');
    }
  }

  Future<void> stopRecordingAndSave() async {
    final path = await _nativeService.stopRecording();
    if (path != null && path.isNotEmpty) {
      selectedAudio = File(path);
      emit(RecordingStarted(List.from(allMessages), selectedAudio!));
    } else {
      debugPrint('Recording path is null');
      // debugPrint('User cancel request to record');
    }
  }

  void removeRecord() {
    selectedAudio = null;
    emit(RecordRemoved(List.from(allMessages)));
  }

  Future<void> pickImageFromCamera() async {
    final image = await _nativeService.pickImage(ImageSource.camera);
    if (image != null) {
      selectedImage = image;
      emit(ImagePicked(image, List.from(allMessages)));
    }
  }

  Future<void> pickImageFromGallery() async {
    final image = await _nativeService.pickImage(ImageSource.gallery);
    if (image != null) {
      selectedImage = image;
      emit(ImagePicked(image, List.from(allMessages)));
    }
  }

  void removeImage() {
    selectedImage = null;
    emit(ImageRemoved(List.from(allMessages)));
  }
}
