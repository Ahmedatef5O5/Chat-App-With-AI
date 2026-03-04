import 'package:chat_app_with_ai/cubits/home_cubit/home_chat_cubit.dart';
import 'package:chat_app_with_ai/models/chat_model.dart';
import 'package:chat_app_with_ai/utilities/constants/app_colors.dart';
import 'package:chat_app_with_ai/widgets/chat_list_tile.dart';
import 'package:chat_app_with_ai/widgets/custom_elevated_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import '../cubits/chats_cubit/chats_cubit.dart';

class ChatDrawer extends StatelessWidget {
  const ChatDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    final chatsCubit = context.read<ChatsCubit>();
    final chatCubit = context.read<HomeChatCubit>();
    return Drawer(
      child: SafeArea(
        child: Column(
          children: [
            //Header
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'Your Chats',
                style: Theme.of(context).textTheme.titleSmall!.copyWith(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),

            /// Chats List
            Expanded(
              child: StreamBuilder<List<ChatModel>>(
                stream: chatsCubit.getChats(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(
                      child: CupertinoActivityIndicator(
                        color: AppColors.blackColor12,
                      ),
                    );
                  }
                  final chats = snapshot.data ?? [];
                  if (chats.isEmpty) {
                    return const Center(child: Text('No chats yet'));
                  }
                  return ListView.builder(
                    itemCount: chats.length,
                    itemBuilder: (context, index) {
                      final chat = chats[index];
                      return ChatListTile(
                        chat: chat,
                        onTap: () {
                          Navigator.of(context).pop();
                          chatCubit.loadChat(chat.id);
                        },
                      );
                    },
                  );
                },
              ),
            ),

            /// New chat
            CustomElevatedButton(
              minimumSize: Size(50, 40),
              maximumSize: Size(200, 40),

              suffixIcon: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.add, size: 20, color: AppColors.white),
                  Gap(8),
                  Text(
                    'New chat',
                    style: Theme.of(context).textTheme.titleSmall!.copyWith(
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                      color: AppColors.white,
                    ),
                  ),
                ],
              ),
              txtBtn: 'New chat',

              onpreesed: () async {
                Navigator.of(context).pop();
                final chatId = await chatsCubit.createNewChat();
                chatCubit.loadChat(chatId);
              },
            ),
            Gap(20),
          ],
        ),
      ),
    );
  }
}
