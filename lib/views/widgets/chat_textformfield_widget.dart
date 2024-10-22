import 'package:flutter/material.dart';

class ChatTextformfieldWidget extends StatelessWidget {
  final TextEditingController textController;
  final FocusNode myFocusNode;
  const ChatTextformfieldWidget({
    super.key,
    required this.textController,
    required this.myFocusNode,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: TextFormField(
        cursorColor: Colors.grey,
        controller: textController,
        focusNode: myFocusNode,
        style: const TextStyle(color: Colors.black),
        keyboardType: TextInputType.emailAddress,
        decoration: const InputDecoration(
          hintText: "Write your message",
          hintStyle: TextStyle(
            color: Color(0xff797C7B),
          ),
          filled: true,
          fillColor: Color(0xffF3F6F6),
          border: OutlineInputBorder(
            borderSide: BorderSide.none,
            borderRadius: BorderRadius.all(Radius.circular(17)),
          ),
        ),
      ),
    );
  }
}
