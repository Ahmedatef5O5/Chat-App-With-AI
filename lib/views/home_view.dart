import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
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
  late final ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
    _scrollController = ScrollController();
  }

  @override
  void dispose() {
    _controller.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  void _scrollToBottom() {
    WidgetsBinding.instance.addPostFrameCallback(
      (_) => _scrollController.animateTo(
        // _scrollController.position.maxScrollExtent,
        0.0,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        appBar: AppBar(title: const Text('Chat view'), centerTitle: true),
        body: Column(
          children: [
            Expanded(
              child: BlocConsumer<ChatCubit, ChatState>(
                listenWhen:
                    (previous, current) =>
                        current is ChatFailure || current is ChatSuccess,

                listener: (BuildContext context, ChatState state) {
                  if (state is ChatFailure) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(state.errMessage),
                        backgroundColor: Colors.redAccent,
                        duration: const Duration(seconds: 3),
                      ),
                    );
                    _scrollToBottom();
                  } else if (state is ChatSuccess) {
                    _scrollToBottom();
                  }
                },
                builder: (context, state) {
                  List<MessageModel> messages = [];

                  if (state is ChatSuccess) messages = state.messages;
                  if (state is ChatLoading) messages = state.messages;
                  if (state is ChatFailure) messages = state.messages;
                  if (state is ImagePicked) messages = state.messages;
                  if (state is ImageRemoved) messages = state.messages;

                  return ListView.builder(
                    controller: _scrollController,
                    reverse: true,
                    itemCount: messages.length,
                    itemBuilder: (context, index) {
                      final message = messages.reversed.toList()[index];
                      return ChatBubble(message: message, animate: index == 0);
                    },
                  );
                },
              ),
            ),
            _buildInputArea(context),
          ],
        ),
      ),
    );
  }

  Widget _buildInputArea(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          BlocBuilder<ChatCubit, ChatState>(
            buildWhen:
                (previous, current) =>
                    current is ImagePicked || current is ImageRemoved,
            builder: (context, state) {
              if (state is ImagePicked) {
                return SizedBox(
                  height: 200,
                  width: MediaQuery.of(context).size.width - 100,
                  child: Card(
                    color: Colors.white,
                    child: Stack(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(16),
                          child: Image.file(
                            state.image,
                            width: MediaQuery.of(context).size.width - 70,
                            fit: BoxFit.fill,
                          ),
                        ),
                        Positioned(
                          top: 5,
                          right: 5,
                          child: DecoratedBox(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              shape: BoxShape.circle,
                            ),
                            child: InkWell(
                              child: Padding(
                                padding: const EdgeInsets.all(4.0),
                                child: const Icon(Icons.close),
                              ),
                              onTap:
                                  () =>
                                      BlocProvider.of<ChatCubit>(
                                        context,
                                      ).removeImage(),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }
              return const SizedBox.shrink();
            },
          ),
          Gap(10),
          Row(
            children: [
              Expanded(
                child: TextField(
                  minLines: 1,
                  maxLines: 6,
                  keyboardType: TextInputType.multiline,
                  controller: _controller,
                  decoration: InputDecoration(
                    hintText: 'Ask Gemini...',
                    suffixIcon: InkWell(
                      child: const Icon(Icons.camera_alt),
                      onTap:
                          () async =>
                              BlocProvider.of<ChatCubit>(context).pickImage(),
                    ),
                  ),
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
                              BlocProvider.of<ChatCubit>(context).removeImage();
                              _scrollToBottom();
                            },
                  );
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}
