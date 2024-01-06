import 'package:chatapp/Models/modelMessage.dart';

class ChatState {}

class ChatInitialState extends ChatState {}

class ChatSuccessState extends ChatState {
  List<Message> message;
  ChatSuccessState({required this.message});
}
