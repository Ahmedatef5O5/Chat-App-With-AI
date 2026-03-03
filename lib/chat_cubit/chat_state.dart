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

final class FilePicked extends ChatState {
  final File file;
  final List<MessageModel> messages;

  FilePicked(this.messages, this.file);
}

final class FileRemoved extends ChatState {
  final List<MessageModel> messages;

  FileRemoved(this.messages);
}

final class RecordingStarted extends ChatState {
  final File record;
  final List<MessageModel> messages;

  RecordingStarted(this.messages, this.record);
}

final class RecordRemoved extends ChatState {
  final List<MessageModel> messages;

  RecordRemoved(this.messages);
}
