import 'package:chat_app_with_ai/widgets/custom_delete_btn.dart';
import 'package:flutter/material.dart';

class FilePreviewWidget extends StatelessWidget {
  const FilePreviewWidget({
    super.key,
    required this.title,
    required this.icon,
    this.iconColor = Colors.blueAccent,
    required this.onRemove,
  });
  final String title;
  final IconData icon;
  final Color iconColor;
  final VoidCallback onRemove;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 100,
      width: 180,
      child: Card(
        elevation: 2,
        child: Stack(
          children: [
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(icon, size: 40, color: iconColor),
                  const SizedBox(height: 4),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Text(
                      title,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(fontSize: 12),
                    ),
                  ),
                ],
              ),
            ),
            Positioned(
              top: 4,
              right: 4,
              child: CustomDeleteBtn(onTap: onRemove),

              // child: GestureDetector(
              //   onTap: onRemove,
              //   child: const Icon(Icons.cancel, color: Colors.grey, size: 20),
              // ),
            ),
          ],
        ),
      ),
    );
  }
}
