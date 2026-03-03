import 'dart:convert';
import 'dart:io';

class MessageModel {
  final String text;
  final bool isUser;
  final bool isLoading;
  final DateTime time;
  final File? image;
  final File? file;
  final File? audio;

  const MessageModel({
    this.text = '',
    required this.isUser,
    this.isLoading = false,
    required this.time,
    this.image,
    this.file,
    this.audio,
  });

  MessageModel copyWith({
    String? text,
    bool? isUser,
    bool? isLoading,
    DateTime? time,
    File? image,
    File? file,
    File? audio,
  }) {
    return MessageModel(
      text: text ?? this.text,
      isUser: isUser ?? this.isUser,
      isLoading: isLoading ?? this.isLoading,
      time: time ?? this.time,
      image: image ?? this.image,
      file: file ?? this.file,
      audio: audio ?? this.audio,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'text': text,
      'isUser': isUser,
      'isLoading': isLoading,
      'time': time.millisecondsSinceEpoch,
    };
  }

  factory MessageModel.fromMap(Map<String, dynamic> map) {
    return MessageModel(
      text: map['text'] as String? ?? '',
      isUser: map['isUser'] as bool? ?? true,
      isLoading: map['isLoading'] as bool? ?? false,
      time: DateTime.fromMillisecondsSinceEpoch(map['time'] as int? ?? 0),
    );
  }

  String toJson() => json.encode(toMap());

  factory MessageModel.fromJson(String source) =>
      MessageModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
