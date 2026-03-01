import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import '../models/message_model.dart';
import '../utilities/constants/app_images.dart';

class ChatBubble extends StatelessWidget {
  final MessageModel message;
  const ChatBubble({super.key, required this.message});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: message.isUser ? Alignment.centerRight : Alignment.centerLeft,
      child:
          message.isLoading
              ? Lottie.asset(
                AppImages.loadingDotsBlue,
                height: 60,
                width: 40,
                fit: BoxFit.cover,
              )
              : Container(
                margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: message.isUser ? Colors.blueAccent : Colors.grey[300],
                  borderRadius: BorderRadius.only(
                    topLeft: const Radius.circular(15),
                    topRight: const Radius.circular(15),
                    bottomLeft: Radius.circular(message.isUser ? 15 : 0),
                    bottomRight: Radius.circular(message.isUser ? 0 : 15),
                  ),
                ),
                child: Text(
                  message.text,
                  style: TextStyle(
                    color: message.isUser ? Colors.white : Colors.black,
                  ),
                ),
              ),
    );
  }
}
