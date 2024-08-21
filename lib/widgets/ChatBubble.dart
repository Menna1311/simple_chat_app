import 'package:chat_app/constant.dart';
import 'package:chat_app/model/message.dart';
import 'package:flutter/material.dart';

class Chatbubble extends StatelessWidget {
  const Chatbubble({super.key, required this.text});
  final Message text;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Align(
        alignment: Alignment.centerLeft,
        child: Container(
          padding: EdgeInsets.all(16),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(16),
              topRight: Radius.circular(16),
              bottomRight: Radius.circular(16),
            ),
            color: kPrimaryColor,
          ),
          child: Text(text.message),
        ),
      ),
    );
  }
}

class ChatbubbleForFriend extends StatelessWidget {
  const ChatbubbleForFriend({super.key, required this.text});
  final Message text;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Align(
        alignment: Alignment.centerRight,
        child: Container(
          padding: EdgeInsets.all(16),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(16),
              topRight: Radius.circular(16),
              bottomLeft: Radius.circular(16),
            ),
            color: Colors.blueAccent,
          ),
          child: Text(text.message),
        ),
      ),
    );
  }
}
