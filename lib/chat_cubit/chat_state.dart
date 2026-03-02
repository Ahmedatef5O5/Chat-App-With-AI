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

final class ImagePicked extends ChatState {
  final File image;
  final List<MessageModel> messages;
  ImagePicked(this.image, this.messages);
}

final class ImageRemoved extends ChatState {
  final List<MessageModel> messages;

  ImageRemoved(this.messages);
}
