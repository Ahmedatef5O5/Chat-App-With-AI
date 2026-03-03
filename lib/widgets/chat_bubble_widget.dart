import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
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
                                  ? Column(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      if (message.image != null)
                                        ClipRRect(
                                          borderRadius: BorderRadius.circular(
                                            16,
                                          ),
                                          child: Image.file(
                                            message.image!,
                                            height: 175,
                                            width:
                                                MediaQuery.of(
                                                  context,
                                                ).size.width -
                                                200,
                                            fit: BoxFit.fill,
                                          ),
                                        ),
                                      if (message.file != null)
                                        _buildFileBubble(
                                          icon: Icons.description,
                                          fileName:
                                              message.file!.path
                                                  .split('/')
                                                  .last,
                                          color:
                                              message.isUser
                                                  ? Colors.white24
                                                  : Colors.grey.shade200,
                                        ),
                                      if (message.audio != null)
                                        _buildFileBubble(
                                          icon: Icons.mic,
                                          fileName: "Voice Message",
                                          color:
                                              message.isUser
                                                  ? Colors.white24
                                                  : Colors.grey.shade200,
                                        ),
                                      Gap(12),
                                      Text(
                                        message.text,
                                        style: TextStyle(
                                          color:
                                              message.isUser
                                                  ? Colors.white
                                                  : Colors.black,
                                        ),
                                      ),
                                    ],
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

Widget _buildFileBubble({
  required IconData icon,
  required String fileName,
  required Color color,
}) {
  return Container(
    margin: const EdgeInsets.only(bottom: 8),
    padding: const EdgeInsets.all(10),
    decoration: BoxDecoration(
      color: color,
      borderRadius: BorderRadius.circular(10),
    ),
    child: Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, size: 24, color: Colors.blue),
        const SizedBox(width: 8),
        Flexible(
          child: Text(
            fileName,
            style: const TextStyle(fontSize: 13, fontWeight: FontWeight.bold),
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    ),
  );
}
