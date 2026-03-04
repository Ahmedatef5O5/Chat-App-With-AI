part of 'home_chat_cubit.dart';

sealed class HomeChatState {}

final class HomeChatInitial extends HomeChatState {}

final class HomeChatLoading extends HomeChatState {
  final List<MessageModel> messages;

  HomeChatLoading(this.messages);
}

final class HomeChatSuccess extends HomeChatState {
  final List<MessageModel> messages;

  HomeChatSuccess(this.messages);
}

final class HomeChatFailure extends HomeChatState {
  final String errMessage;
  final List<MessageModel> messages;

  HomeChatFailure(this.errMessage, this.messages);
}

final class ImagePicked extends HomeChatState {
  final File image;
  final List<MessageModel> messages;
  ImagePicked(this.image, this.messages);
}

final class ImageRemoved extends HomeChatState {
  final List<MessageModel> messages;

  ImageRemoved(this.messages);
}

final class FilePicked extends HomeChatState {
  final File file;
  final List<MessageModel> messages;

  FilePicked(this.file, this.messages);
}

final class FileRemoved extends HomeChatState {
  final List<MessageModel> messages;

  FileRemoved(this.messages);
}

final class RecordingStarted extends HomeChatState {
  final File record;
  final List<MessageModel> messages;

  RecordingStarted(this.messages, this.record);
}

final class RecordRemoved extends HomeChatState {
  final List<MessageModel> messages;

  RecordRemoved(this.messages);
}
