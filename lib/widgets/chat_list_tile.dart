import 'package:chat_app_with_ai/models/chat_model.dart';
import 'package:flutter/material.dart';

class ChatListTile extends StatelessWidget {
  final ChatModel chat;
  final VoidCallback onTap;

  const ChatListTile({super.key, required this.chat, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: const Icon(Icons.chat_bubble_outline),
      title: Text(chat.title),
      subtitle: Text(
        chat.lastMsg.isEmpty ? 'No messages yet' : chat.lastMsg,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      ),
      onTap: onTap,
    );
  }
}
