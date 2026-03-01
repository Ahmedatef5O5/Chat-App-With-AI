import 'package:chat_app_with_ai/utilities/constants/app_images.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import '../chat_cubit/chat_cubit.dart';
import '../models/message_model.dart';
import '../widgets/chat_bubble_widget.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  late final TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Chat view'), centerTitle: true),
      body: Column(
        children: [
          Expanded(
            child: BlocConsumer<ChatCubit, ChatState>(
              listenWhen: (previous, current) => current is ChatFailure,

              listener: (BuildContext context, ChatState state) {
                if (state is ChatFailure) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(state.errMessage),
                      backgroundColor: Colors.redAccent,
                    ),
                  );
                }
              },
              builder: (context, state) {
                List<MessageModel> messages = [];

                if (state is ChatSuccess) messages = state.messages;
                if (state is ChatLoading) messages = state.messages;
                if (state is ChatFailure) messages = state.messages;

                return ListView.builder(
                  reverse: true,
                  itemCount: messages.length,
                  itemBuilder: (context, index) {
                    final message = messages[messages.length - 1 - index];
                    return ChatBubble(message: message);
                  },
                );
              },
            ),
          ),
          _buildInputArea(context),
        ],
      ),
    );
  }

  Widget _buildInputArea(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: _controller,
              decoration: const InputDecoration(hintText: 'Ask Gemini...'),
            ),
          ),
          BlocBuilder<ChatCubit, ChatState>(
            builder: (context, state) {
              final isLoading =
                  state is ChatLoading &&
                  state.messages.isNotEmpty &&
                  state.messages.last.isLoading;

              return IconButton(
                icon: const Icon(Icons.send),
                onPressed:
                    isLoading
                        ? null
                        : () {
                          context.read<ChatCubit>().sendMessage(
                            _controller.text,
                          );
                          _controller.clear();
                        },
              );
            },
          ),
        ],
      ),
    );
  }
}
