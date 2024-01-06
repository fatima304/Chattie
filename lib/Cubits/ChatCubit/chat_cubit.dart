import 'package:chatapp/Conestance.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:chatapp/Models/modelMessage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:chatapp/Cubits/ChatCubit/chat_state.dart';

class ChatCubit extends Cubit<ChatState> {
  ChatCubit() : super(ChatInitialState());

  CollectionReference messages =
      FirebaseFirestore.instance.collection(kMessagesCollection);

  void sendMessage({required String message, required String email}) {
    try {
      messages.add({
        kMessagesCollection: message,
        time: DateTime.now(),
        'id': email,
      });
    } catch (e) {}
  }

  void getMessage() {
    messages.orderBy(time, descending: true).snapshots().listen((event) {
      List<Message> messagesList = [];
      for (var doc in event.docs) {
        messagesList.add(Message.fromJson(doc));
      }
      emit(ChatSuccessState(message: messagesList));
    });
  }
}
