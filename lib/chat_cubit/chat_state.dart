part of 'chat_cubit.dart';

sealed class ChatState {}

final class ChatInitial extends ChatState {}

final class ChatLoading extends ChatState {
  final List<MessageModel> messages;

  ChatLoading(this.messages);
}

final class ChatSuccess extends ChatState {
  final List<MessageModel> messages;

  ChatSuccess(this.messages);
}

final class ChatFailure extends ChatState {
  final String errMessage;
  final List<MessageModel> messages;

  ChatFailure(this.errMessage, this.messages);
}
