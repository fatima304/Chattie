import '../Conestance.dart';
import 'package:flutter/material.dart';
import 'package:chatapp/Models/modelMessage.dart';
import 'package:chatapp/Components/chatBubble.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

// ignore: must_be_immutable
class ChatScreen extends StatelessWidget {
  TextEditingController controller = TextEditingController();

  String? email;

  ChatScreen({required this.email});

  final _controller = ScrollController();

  CollectionReference messages =
      FirebaseFirestore.instance.collection(kMessagesCollection);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
        stream: messages.orderBy(time, descending: true).snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            List<Message> messagesList = [];
            for (int i = 0; i < snapshot.data!.docs.length; i++) {
              messagesList.add(
                Message.fromJson(
                  snapshot.data!.docs[i],
                ),
              );
            }
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
                    child: ListView.builder(
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
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: TextField(
                      controller: controller,
                      onSubmitted: (data) {
                        sendMessage(data);
                      },
                      decoration: InputDecoration(
                        hintText: 'Send Message',
                        suffixIcon: IconButton(
                          onPressed: () {
                            if (controller.text.isNotEmpty) {
                              sendMessage(controller.text);
                            }
                          },
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
          } else {
            return Text('Loading .....');
          }
        });
  }

  void sendMessage(String data) {
    messages.add({
      kMessagesCollection: data,
      time: DateTime.now(),
      'id': email,
    });
    controller.clear();
    _controller.animateTo(
      0,
      duration: Duration(
        seconds: 1,
      ),
      curve: Curves.fastOutSlowIn,
    );
  }
}
