import 'package:chat_app_with_ai/utilities/constants/app_colors.dart';
import 'package:chat_app_with_ai/utilities/constants/app_images.dart';
import 'package:chat_app_with_ai/widgets/file_preview_widget.dart';
import 'package:chat_app_with_ai/widgets/image_preview_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import '../cubits/chat_cubit/chat_cubit.dart';
import '../widgets/chat_bubble_widget.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  late final TextEditingController _controller;
  late final ScrollController _scrollController;
  bool _isTyping = false;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
    _controller.addListener(() {
      _isTyping = _controller.text.isNotEmpty;
    });
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

  void showOptions() {
    showCupertinoModalPopup(
      context: context,
      builder:
          (_) => CupertinoActionSheet(
            actions: [
              CupertinoActionSheetAction(
                onPressed: () {
                  Navigator.pop(context);
                  BlocProvider.of<ChatCubit>(context).pickImageFromCamera();
                },
                child: const Text('Camera'),
              ),
              CupertinoActionSheetAction(
                onPressed: () {
                  BlocProvider.of<ChatCubit>(context).pickImageFromGallery();
                  Navigator.pop(context);
                },
                child: const Text('Gallery'),
              ),
              CupertinoActionSheetAction(
                onPressed: () {
                  BlocProvider.of<ChatCubit>(context).pickDocument();
                  Navigator.pop(context);
                },
                child: const Text('Document (PDF/Word)'),
              ),
            ],
          ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final chatCubit = BlocProvider.of<ChatCubit>(context);
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: const Text('Chat view'),
          centerTitle: true,
        ),
        body: SafeArea(
          child: Column(
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
                    final messages = chatCubit.allMessages;
                    return ListView.builder(
                      controller: _scrollController,
                      reverse: true,
                      itemCount: messages.length,
                      itemBuilder: (context, index) {
                        final message = messages.reversed.toList()[index];
                        return ChatBubble(
                          message: message,
                          animate: index == 0,
                        );
                      },
                    );
                  },
                ),
              ),
              _buildInputArea(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildInputArea(BuildContext context) {
    final chatCubit = BlocProvider.of<ChatCubit>(context);
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          BlocBuilder<ChatCubit, ChatState>(
            buildWhen:
                (previous, current) =>
                    current is ImagePicked ||
                    current is ImageRemoved ||
                    current is FilePicked ||
                    current is FileRemoved ||
                    current is RecordingStarted ||
                    current is RecordRemoved,
            builder: (context, state) {
              if (state is ImagePicked) {
                return ImagePreviewWidget(
                  image: state.image,
                  onRemove: () => chatCubit.removeImage(),
                );
              }

              if (state is FilePicked) {
                return FilePreviewWidget(
                  title: state.file.path.split('/').last,
                  icon: Icons.description,
                  onRemove: () => chatCubit.removeFile(),
                );
              }
              if (state is RecordingStarted) {
                return FilePreviewWidget(
                  title: "Voice Message",
                  icon: CupertinoIcons.mic,
                  iconColor: Colors.red,
                  onRemove: () => chatCubit.removeRecord(),
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
                  onChanged:
                      (text) => setState(() {
                        _isTyping = text.isNotEmpty;
                      }),
                  decoration: InputDecoration(
                    hintText: 'Ask Gemini...',
                    suffixIcon: InkWell(
                      child: const Icon(Icons.attachment),
                      onTap: () async => showOptions(),
                    ),
                  ),
                ),
              ),
              BlocBuilder<ChatCubit, ChatState>(
                builder: (context, state) {
                  final isRecording = state is RecordingStarted;
                  final isLoading =
                      state is ChatLoading &&
                      state.messages.isNotEmpty &&
                      state.messages.last.isLoading;
                  if (_isTyping ||
                      chatCubit.selectedFile != null ||
                      chatCubit.selectedImage != null) {
                    return IconButton(
                      icon: Image.asset(AppImages.send, width: 24, height: 24),
                      // icon: const Icon(Icons.send),
                      onPressed:
                          isLoading
                              ? null
                              : () {
                                context.read<ChatCubit>().sendMessage(
                                  _controller.text,
                                );
                                _controller.clear();
                                chatCubit.removeImage();
                                chatCubit.removeFile();
                                chatCubit.removeRecord();
                                _scrollToBottom();
                              },
                    );
                  } else {
                    return GestureDetector(
                      onLongPressStart: (_) => chatCubit.startRecording(),
                      onLongPressEnd: (_) => chatCubit.stopRecordingAndSave(),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 12.0),
                        child: Image.asset(
                          AppImages.microphone,
                          width: 24,
                          height: 25,
                          color:
                              isRecording
                                  ? Colors.red
                                  // : Theme.of(context).primaryColor,
                                  : AppColors.grey4,
                        ),
                      ),

                      onTap:
                          () => ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('Hold to record')),
                          ),
                    );
                  }
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}
