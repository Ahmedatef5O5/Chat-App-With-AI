import 'package:flutter/material.dart';

class CustomDeleteBtn extends StatelessWidget {
  const CustomDeleteBtn({super.key, this.onTap});
  final Function()? onTap;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: CircleAvatar(
        backgroundColor: Colors.black54,
        radius: 12,
        child: Icon(Icons.close, size: 16, color: Colors.white),
      ),
    );
  }
}
