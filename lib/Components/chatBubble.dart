import 'package:chatapp/Models/modelMessage.dart';
import 'package:flutter/material.dart';
import 'package:chatapp/Conestance.dart';

// ignore: must_be_immutable
class chatBubble extends StatelessWidget {
  chatBubble({required this.message});

  Message message;
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Container(
        padding: EdgeInsets.all(16),
        margin: EdgeInsets.all(
          16,
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(30),
            bottomRight: Radius.circular(30),
            topLeft: Radius.circular(30),
          ),
          color: primaryColor,
        ),
        child: Text(
          message.message,
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
          ),
        ),
      ),
    );
  }
}

// ignore: must_be_immutable
class chatBubble2 extends StatelessWidget {
  chatBubble2({required this.message});

  Message message;
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: Container(
        padding: EdgeInsets.all(16),
        margin: EdgeInsets.all(
          16,
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(30),
            bottomRight: Radius.circular(30),
            topLeft: Radius.circular(30),
          ),
          color: Color.fromARGB(255, 108, 101, 126),
        ),
        child: Text(
          message.message,
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
          ),
        ),
      ),
    );
  }
}
