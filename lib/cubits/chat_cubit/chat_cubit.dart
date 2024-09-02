import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:meta/meta.dart';

import '../../model/message.dart';

part 'chat_state.dart';

class ChatCubit extends Cubit<ChatState> {
  ChatCubit() : super(ChatInitial());
  CollectionReference messages =
      FirebaseFirestore.instance.collection('messages');
  void sendMessage({required String message, required String email}) {
    messages
        .add({'message': message, 'createsAt': DateTime.now(), 'id': email});
  }

  void getmessages() {
    messages.orderBy('createsAt').snapshots().listen(
      (event) {
        List<Message> messageList = [];
        for (var messagee in event.docs) {
          messageList.add(Message.fromJson(messagee));
        }
        emit(ChatMessageSent(messages: messageList));
      },
    );
  }
}
