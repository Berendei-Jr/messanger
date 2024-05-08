import 'package:flutter/material.dart';

class ChatBubble extends StatelessWidget {
  const ChatBubble({
    super.key,
    required this.message,
  });

  final String message;

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    return Container(
      padding: const EdgeInsets.all(12),
      constraints: BoxConstraints(minWidth: width * 0.2, maxWidth: width * 0.7),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color.fromARGB(255, 82, 81, 81),
              Color.fromARGB(255, 56, 55, 55),
            ]),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Center(
          widthFactor: 1.0,
          heightFactor: 1.0,
          child: Text(
            message,
            style: Theme.of(context).textTheme.bodyMedium,
          )),
    );
  }
}
