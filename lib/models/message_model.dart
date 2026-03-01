import 'dart:convert';

class MessageModel {
  final String text;
  final bool isUser;
  final DateTime time;

  const MessageModel({
    required this.text,
    required this.isUser,
    required this.time,
  });

  MessageModel copyWith({String? text, bool? isUser, DateTime? time}) {
    return MessageModel(
      text: text ?? this.text,
      isUser: isUser ?? this.isUser,
      time: time ?? this.time,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'text': text,
      'isUser': isUser,
      'time': time.millisecondsSinceEpoch,
    };
  }

  factory MessageModel.fromMap(Map<String, dynamic> map) {
    return MessageModel(
      text: map['text'] as String? ?? '',
      isUser: map['isUser'] as bool? ?? true,
      time: DateTime.fromMillisecondsSinceEpoch(map['time'] as int? ?? 0),
    );
  }

  String toJson() => json.encode(toMap());

  factory MessageModel.fromJson(String source) =>
      MessageModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
