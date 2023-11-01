import 'package:flutter/material.dart';
import 'package:chatapp/Conestance.dart';
import 'package:chatapp/Screens/loginPage.dart';
import 'package:flutter_onboard/flutter_onboard.dart';

class OnBoarding extends StatelessWidget {
  final PageController _pageController = PageController();

  OnBoarding({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: OnBoard(
        pageController: _pageController,
        onBoardData: onBoardData,
        titleStyles: TextStyle(
          color: primaryColor,
          fontSize: 26,
          fontWeight: FontWeight.bold,
          letterSpacing: 1,
        ),
        descriptionStyles: TextStyle(
            fontSize: 16, color: Colors.grey, fontWeight: FontWeight.w500),
        pageIndicatorStyle: PageIndicatorStyle(
          width: 100,
          inactiveColor: Color.fromARGB(255, 122, 93, 176),
          activeColor: primaryColor,
          inactiveSize: Size(4, 4),
          activeSize: Size(8, 8),
        ),
        skipButton: TextButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => LoginScreen(),
              ),
            );
          },
          child: Text(
            "Skip",
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
        ),
        nextButton: OnBoardConsumer(
          builder: (context, ref, child) {
            final state = ref.watch(onBoardStateProvider);
            return InkWell(
              onTap: () => _onNextTap(state),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  state.isLastPage
                      ? GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => LoginScreen(),
                              ),
                            );
                          },
                          child: Container(
                            width: 150,
                            height: 40,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(30),
                              color: primaryColor,
                            ),
                            child: const Text(
                              "Done",
                              style: TextStyle(
                                fontSize: 20,
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        )
                      : Container(
                          width: 150,
                          height: 40,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30),
                            color: primaryColor,
                          ),
                          child: const Text(
                            "Next",
                            style: TextStyle(
                              fontSize: 20,
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        )
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  void _onNextTap(OnBoardState onBoardState) {
    if (!onBoardState.isLastPage) {
      _pageController.animateToPage(
        onBoardState.page + 1,
        duration: const Duration(milliseconds: 250),
        curve: Curves.easeInOutSine,
      );
    } else {}
  }
}

final List<OnBoardModel> onBoardData = [
  const OnBoardModel(
    imgUrl: 'assets/world.png',
    title: "Connect with Friends",
    description: '''A new way to connect with \nyour favourite people''',
  ),
  const OnBoardModel(
    imgUrl: "assets/login.png",
    title: "Log In ",
    description:
        "Already a member? Log in and continue\n your conversations seamlessly",
  ),
  const OnBoardModel(
    imgUrl: "assets/register.png",
    title: "Registration Made Simple",
    description:
        "New to our app? Register in a few easy steps\n to unlock the world of chat",
  ),
];
