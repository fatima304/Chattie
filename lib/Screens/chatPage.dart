import '../Conestance.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:chatapp/Models/modelMessage.dart';
import 'package:chatapp/Components/chatBubble.dart';
import 'package:chatapp/Cubits/ChatCubit/chat_cubit.dart';
import 'package:chatapp/Cubits/ChatCubit/chat_state.dart';

// ignore: must_be_immutable
class ChatScreen extends StatelessWidget {
  TextEditingController controller = TextEditingController();

  String? email;
  List<Message> messagesList = [];

  ChatScreen({required this.email});

  final _controller = ScrollController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 233, 231, 231),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        automaticallyImplyLeading: false,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/icon.png',
              height: 40,
            ),
            Text(
              'Chattie',
              style: TextStyle(
                fontFamily: 'pacifico',
                fontSize: 30,
                color: primaryColor,
              ),
            ),
          ],
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Expanded(
            child: BlocConsumer<ChatCubit, ChatState>(
              listener: (context, state) {
                if (state is ChatSuccessState) {
                  messagesList = state.message;
                }
              },
              builder: (context, state) {
                return ListView.builder(
                  reverse: true,
                  controller: _controller,
                  itemCount: messagesList.length,
                  itemBuilder: (context, index) {
                    return messagesList[index].id == email
                        ? chatBubble(
                            message: messagesList[index],
                          )
                        : chatBubble2(
                            message: messagesList[index],
                          );
                  },
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              controller: controller,
              onSubmitted: (data) {
                BlocProvider.of<ChatCubit>(context)
                    .sendMessage(message: data, email: email!);
                controller.clear();
                _controller.animateTo(
                  0,
                  duration: Duration(
                    microseconds: 500,
                  ),
                  curve: Curves.easeIn,
                );
              },
              decoration: InputDecoration(
                hintText: 'Send Message',
                suffixIcon: IconButton(
                  onPressed: () {},
                  color: primaryColor,
                  icon: Icon(Icons.send),
                ),
                contentPadding: EdgeInsets.symmetric(
                  vertical: 10,
                  horizontal: 10,
                ),
                border: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: primaryColor,
                  ),
                  borderRadius: BorderRadius.circular(15),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: primaryColor,
                  ),
                  borderRadius: BorderRadius.circular(15),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void sendMessage(String data) {}
}
