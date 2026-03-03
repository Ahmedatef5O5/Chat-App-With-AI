import 'dart:io';
import 'package:chat_app_with_ai/widgets/custom_delete_btn.dart';
import 'package:flutter/material.dart';

class ImagePreviewWidget extends StatelessWidget {
  const ImagePreviewWidget({
    super.key,
    required this.image,
    required this.onRemove,
  });
  final File image;
  final VoidCallback onRemove;
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return SizedBox(
      height: 200,
      width: size.width - 100,
      child: Card(
        clipBehavior: Clip.antiAlias,
        child: Stack(
          children: [
            Image.file(
              image,
              width: double.infinity,
              height: double.infinity,
              fit: BoxFit.cover,
            ),
            Positioned(
              top: 8,
              right: 8,
              child: CustomDeleteBtn(onTap: onRemove),
            ),
          ],
        ),
      ),
    );
  }
}
