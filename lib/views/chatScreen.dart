import 'package:chat_app/constant.dart';
import 'package:chat_app/cubits/chat_cubit/chat_cubit.dart';
import 'package:chat_app/model/message.dart';
import 'package:chat_app/widgets/ChatBubble.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChatScreen extends StatelessWidget {
  ChatScreen({super.key});
  CollectionReference messages =
      FirebaseFirestore.instance.collection('messages');
  TextEditingController controller = TextEditingController();
  final ScrollController _controller = ScrollController();
  List<Message> messageList = [];
  @override
  Widget build(BuildContext context) {
    var email = ModalRoute.of(context)!.settings.arguments;
    print(email);

    return Scaffold(
        appBar: AppBar(
          backgroundColor: kPrimaryColor,
          automaticallyImplyLeading: false,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                klogo,
                height: 50,
              ),
              const Text('Chat'),
            ],
          ),
        ),
        body: Column(
          children: [
            Expanded(
              child: BlocConsumer<ChatCubit, ChatState>(
                listener: (context, state) {
                  if (state is ChatMessageSent) {
                    messageList = state.messages;
                  }
                },
                builder: (context, state) {
                  return ListView.builder(
                    controller: _controller,
                    itemBuilder: (context, index) {
                      return messageList[index].id == email
                          ? Chatbubble(
                              text: messageList[index],
                            )
                          : ChatbubbleForFriend(
                              text: messageList[index],
                            );
                      // return Chatbubble(
                      //   text: messageList[index],
                      // );
                    },
                    itemCount: messageList.length,
                  );
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: controller,
                onSubmitted: (data) {
                  messages.add({
                    'message': data,
                    'createsAt': DateTime.now(),
                    'id': email
                  });
                  controller.clear();
                  _scrollDown();
                },
                decoration: InputDecoration(
                  hintText: 'send message',
                  suffixIcon: const Icon(Icons.send),
                  focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(18),
                      borderSide: const BorderSide(color: Colors.black)),
                  enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(18),
                      borderSide: const BorderSide(color: Colors.black)),
                ),
              ),
            )
          ],
        ));
  }

  void _scrollDown() {
    _controller.animateTo(
      _controller.position.maxScrollExtent,
      duration: const Duration(seconds: 2),
      curve: Curves.fastOutSlowIn,
    );
  }
}
