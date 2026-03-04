part of 'chats_cubit.dart';

sealed class ChatsState {}

final class ChatsInitial extends ChatsState {}

final class ChatsLoading extends ChatsState {}

final class ChatsLoaded extends ChatsState {
  final List<ChatModel> chats;

  ChatsLoaded(this.chats);
}

final class ChatsFailure extends ChatsState {
  final String errMessage;

  ChatsFailure(this.errMessage);
}
