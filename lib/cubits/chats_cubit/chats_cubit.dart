import 'package:chat_app_with_ai/services/firestore_chat_services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../models/chat_model.dart';
part 'chats_state.dart';

class ChatsCubit extends Cubit<ChatsState> {
  ChatsCubit(this._service) : super(ChatsLoading());
  final FirestoreChatServices _service;

  Stream<List<ChatModel>> getChats() {
    return _service.chatsStream();
  }

  Future<String> createNewChat() async {
    return _service.createChat();
  }
}
