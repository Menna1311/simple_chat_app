part of 'chat_cubit.dart';

@immutable
sealed class ChatState {}

final class ChatInitial extends ChatState {}

final class ChatMessageSent extends ChatState {
  List<Message> messages;
  ChatMessageSent({required this.messages});
}
