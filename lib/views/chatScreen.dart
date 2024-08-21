import 'package:chat_app/constant.dart';
import 'package:chat_app/model/message.dart';
import 'package:chat_app/widgets/ChatBubble.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

class ChatScreen extends StatelessWidget {
  ChatScreen({super.key});
  CollectionReference messages =
      FirebaseFirestore.instance.collection('messages');
  TextEditingController controller = TextEditingController();
  final ScrollController _controller = ScrollController();

  @override
  Widget build(BuildContext context) {
    var email = ModalRoute.of(context)!.settings.arguments;
    print(email);
    return StreamBuilder<QuerySnapshot>(
        stream: messages.orderBy('createsAt').snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            List<Message> messageList = [];
            for (int i = 0; i < snapshot.data!.docs.length; i++) {
              messageList.add(Message.fromJson(snapshot.data!.docs[i]));
              SchedulerBinding.instance.addPostFrameCallback((_) {
                _scrollDown();
              });
            }
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
                      Text('Chat'),
                    ],
                  ),
                ),
                body: Column(
                  children: [
                    Expanded(
                      child: ListView.builder(
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
                          suffixIcon: Icon(Icons.send),
                          focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(18),
                              borderSide: BorderSide(color: Colors.black)),
                          enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(18),
                              borderSide: BorderSide(color: Colors.black)),
                        ),
                      ),
                    )
                  ],
                ));
          } else {
            return Text('Loading...');
          }
        });
  }

  void _scrollDown() {
    _controller.animateTo(
      _controller.position.maxScrollExtent,
      duration: Duration(seconds: 2),
      curve: Curves.fastOutSlowIn,
    );
  }
}
