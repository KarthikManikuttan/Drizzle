import 'package:flutter/material.dart';

class ChatBubbleWidget extends StatelessWidget {
  final String message;
  final bool isCurrentUser;
  const ChatBubbleWidget(
      {super.key, required this.message, required this.isCurrentUser});

  @override
  Widget build(BuildContext context) {
    bool isDarkMode =
        MediaQuery.of(context).platformBrightness == Brightness.dark;
    return Container(
      constraints:
          const BoxConstraints(minHeight: 45, maxWidth: 250, minWidth: 50),
      decoration: BoxDecoration(
        color: isCurrentUser
            ? Theme.of(context).colorScheme.primaryContainer
            : Theme.of(context).colorScheme.secondaryContainer,
        borderRadius: isCurrentUser
            ? const BorderRadius.only(
                bottomLeft: Radius.circular(15),
                bottomRight: Radius.circular(15),
                topLeft: Radius.circular(15),
              )
            : const BorderRadius.only(
                bottomRight: Radius.circular(15),
                bottomLeft: Radius.circular(15),
                topRight: Radius.circular(15),
              ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Text(
              message,
              style: isCurrentUser
                  ? const TextStyle(
                      color: Colors.white,
                      fontFamily: 'Caros',
                    )
                  : TextStyle(
                      color: isDarkMode ? Colors.white : Colors.black,
                      fontFamily: 'Caros',
                    ),
            ),
          ),
        ],
      ),
    );
  }
}
