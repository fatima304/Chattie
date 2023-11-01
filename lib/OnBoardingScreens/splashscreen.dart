import 'dart:async';
import 'package:flutter/material.dart';
import 'package:chatapp/Conestance.dart';
import 'package:chatapp/OnBoardingScreens/onBoardingPage.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 4), () {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) => OnBoarding(),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image.asset(
              'assets/icon.png',
              width: 230,
              height: 100,
            ),
            Text(
              'Chattie',
              style: TextStyle(
                fontFamily: 'pacifico',
                fontSize: 45,
                color: primaryColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
