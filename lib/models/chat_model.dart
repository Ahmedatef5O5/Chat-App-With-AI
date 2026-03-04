class ChatModel {
  final String id;
  final String title;
  final DateTime createdAt;
  final DateTime updatedAt;
  final String lastMsg;

  const ChatModel({
    required this.id,
    required this.title,
    required this.createdAt,
    required this.updatedAt,
    required this.lastMsg,
  });

  ChatModel copyWith({
    String? id,
    String? title,
    DateTime? createdAt,
    DateTime? updatedAt,
    String? lastMsg,
  }) {
    return ChatModel(
      id: id ?? this.id,
      title: title ?? this.title,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      lastMsg: lastMsg ?? this.lastMsg,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'title': title,
      'createdAt': createdAt.millisecondsSinceEpoch,
      'updatedAt': updatedAt.millisecondsSinceEpoch,
      'lastMsg': lastMsg,
    };
  }

  factory ChatModel.fromMap(Map<String, dynamic> map, String id) {
    return ChatModel(
      id: map['id'] as String? ?? '',
      title: map['title'] as String? ?? '',
      createdAt: DateTime.fromMillisecondsSinceEpoch(
        map['createdAt'] as int? ?? 0,
      ),
      updatedAt: DateTime.fromMillisecondsSinceEpoch(
        map['updatedAt'] as int? ?? 0,
      ),
      lastMsg: map['lastMsg'] as String? ?? '',
    );
  }

  // String toJson() => json.encode(toMap());

  // factory ChatModel.fromJson(String source) =>
  //     ChatModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
