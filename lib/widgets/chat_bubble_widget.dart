import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import '../models/message_model.dart';
import '../utilities/constants/app_images.dart';

class ChatBubble extends StatelessWidget {
  final MessageModel message;
  final bool animate;
  const ChatBubble({super.key, required this.message, this.animate = false});

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
              : Row(
                mainAxisAlignment:
                    message.isUser
                        ? MainAxisAlignment.end
                        : MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  if (!message.isUser)
                    CircleAvatar(
                      radius: 12,
                      backgroundColor: Colors.grey.shade400,
                      child: Icon(
                        Icons.computer,
                        size: 18,
                        color: Colors.white,
                      ),
                    ),
                  Flexible(
                    child: Column(
                      crossAxisAlignment:
                          message.isUser
                              ? CrossAxisAlignment.end
                              : CrossAxisAlignment.start,
                      children: [
                        Container(
                          margin: const EdgeInsets.symmetric(
                            vertical: 5,
                            horizontal: 10,
                          ),
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color:
                                message.isUser
                                    ? Colors.blueAccent
                                    : Colors.grey[300],
                            borderRadius: BorderRadius.only(
                              topLeft: const Radius.circular(15),
                              topRight: const Radius.circular(15),
                              bottomLeft: Radius.circular(
                                message.isUser ? 15 : 0,
                              ),
                              bottomRight: Radius.circular(
                                message.isUser ? 0 : 15,
                              ),
                            ),
                          ),
                          child:
                              message.isUser
                                  ? Text(
                                    message.text,
                                    style: TextStyle(
                                      color:
                                          message.isUser
                                              ? Colors.white
                                              : Colors.black,
                                    ),
                                  )
                                  : (animate && !message.isLoading)
                                  ? AnimatedTextKit(
                                    repeatForever: false,
                                    totalRepeatCount: 1,

                                    animatedTexts: [
                                      TyperAnimatedText(
                                        message.text,
                                        textStyle: TextStyle(
                                          color: Colors.black,
                                        ),
                                        speed: const Duration(milliseconds: 25),
                                      ),
                                    ],
                                  )
                                  : Text(
                                    message.text,
                                    style: const TextStyle(color: Colors.black),
                                  ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 2,
                          ),
                          child: Text(
                            DateFormat('hh:mm a').format(message.time),
                            style: TextStyle(
                              fontSize: 10,
                              color: Colors.grey.shade600,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  if (message.isUser)
                    CircleAvatar(
                      radius: 12,
                      backgroundColor: Colors.grey.shade400,
                      child: Icon(Icons.person, size: 18, color: Colors.black),
                    ),
                ],
              ),
    );
  }
}
