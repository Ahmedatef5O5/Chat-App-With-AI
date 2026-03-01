import 'package:chat_app_with_ai/models/message_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../services/chat_services.dart';
part 'chat_state.dart';

class ChatCubit extends Cubit<ChatState> {
  ChatCubit() : super(ChatInitial());

  final _chatService = ChatService();

  final List<MessageModel> _allMessages = [];

  Future<void> sendMessage(String userText) async {
    if (userText.trim().isEmpty) return;
    _allMessages.add(
      MessageModel(text: userText, isUser: true, time: DateTime.now()),
    );

    emit(ChatLoading(List.from(_allMessages)));

    try {
      final aiResponse = await _chatService.sendMessage(userText);
      _allMessages.add(
        MessageModel(
          text: aiResponse ?? 'No Results',
          isUser: false,
          time: DateTime.now(),
        ),
      );

      emit(ChatLoading(List.from(_allMessages)));
    } catch (e) {
      emit(
        ChatFailure(
          'There is an Error: ${e.toString()}',
          List.from(_allMessages),
        ),
      );
    }
  }
}
