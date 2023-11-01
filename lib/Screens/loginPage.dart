import '../Helper/showSnackBar.dart';
import 'package:flutter/material.dart';
import 'package:chatapp/Conestance.dart';
import 'package:chatapp/Screens/chatPage.dart';
import 'package:chatapp/Components/button.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:chatapp/Screens/registerPage.dart';
import 'package:chatapp/Components/textField.dart';
import 'package:flutter_gutter/flutter_gutter.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class LoginScreen extends StatefulWidget {
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  String? email;

  String? password;

  bool isLoading = false;

  GlobalKey<FormState> formKey = GlobalKey();

  // String id = 'loginPage';
  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      inAsyncCall: isLoading,
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: formKey,
            child: ListView(
              // mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  'assets/1.png',
                  width: 250,
                  height: 250,
                ),
                Center(
                  child: Text(
                    'Login',
                    style: TextStyle(
                      fontFamily: 'pacifico',
                      fontSize: 30,
                      color: primaryColor,
                    ),
                  ),
                ),
                const Gutter(),
                CustomTextFormField(
                  hintText: 'Email',
                  onChanged: (data) {
                    email = data;
                  },
                ),
                const Gutter(),
                CustomTextFormField(
                  hintText: 'Password',
                  onChanged: (data) {
                    password = data;
                  },
                ),
                const Gutter(),
                CustomButton(
                  text: 'Login',
                  onTap: () async {
                    if (formKey.currentState!.validate()) {
                      isLoading = true;
                      setState(() {});
                      try {
                        await loginUser();
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: ((context) => ChatScreen(
                                  email: email,
                                )),
                          ),
                        );
                      } on FirebaseAuthException catch (e) {
                        if (e.code == 'user-not-found') {
                          showSnackBar(context, 'No user found for that email');
                        } else if (e.code == 'wrong-password') {
                          showSnackBar(context, 'Wrong password');
                        }
                      } catch (e) {
                        showSnackBar(context, 'There is an error');
                      }
                      isLoading = false;
                      setState(() {});
                    } else {}
                  },
                ),
                const Gutter(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'Don\'t have an account? ',
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: ((context) => RegisterScreen()),
                          ),
                        );

                        // Navigator.pushNamed(context, id);
                      },
                      child: Text(
                        'Create',
                        style: TextStyle(
                          color: primaryColor,
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> loginUser() async {
    UserCredential user = await FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email!, password: password!);
    print(user.user!.displayName);
  }
}
