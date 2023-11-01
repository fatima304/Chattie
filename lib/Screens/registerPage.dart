import '../Helper/showSnackBar.dart';
import 'package:flutter/material.dart';
import 'package:chatapp/Conestance.dart';
import 'package:chatapp/Screens/chatPage.dart';
import 'package:chatapp/Components/button.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:chatapp/Components/textField.dart';
import 'package:flutter_gutter/flutter_gutter.dart';
// import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class RegisterScreen extends StatefulWidget {
  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  String? email;

  String? password;

  bool isLoading = false;

  GlobalKey<FormState> formKey = GlobalKey();

  // String id = 'RegisterPage';
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
              children: [
                Image.asset(
                  'assets/sign up.png',
                  width: 250,
                  height: 250,
                ),
                Center(
                  child: Text(
                    'Register',
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
                  text: 'Register',
                  onTap: () async {
                    if (formKey.currentState!.validate()) {
                      isLoading = true;
                      setState(() {});
                      try {
                        await registerUser();
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: ((context) => ChatScreen(
                                  email: email,
                                )),
                          ),
                        );
                      } on FirebaseAuthException catch (e) {
                        if (e.code == 'weak-password') {
                          showSnackBar(context, 'Weak Password');
                        } else if (e.code == 'email-already-in-use') {
                          showSnackBar(context, 'Email already exist');
                        }
                      }
                      isLoading = false;
                      setState(() {});
                    } else {}
                  },
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'already have an account?',
                    ),
                    TextButton(
                      onPressed: () {
                        // Navigator.push(
                        //   context,
                        //   MaterialPageRoute(
                        //     builder: ((context) => const LoginScreen()),
                        //   ),
                        // );

                        Navigator.pop(context);

                        // Navigator.pushNamed(context, id);
                      },
                      child: Text(
                        'Login',
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

  Future<void> registerUser() async {
    UserCredential user = await FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email!, password: password!);
    print(user.user!.displayName);
  }
}



// Alert(
//         context: context,
//         type: AlertType.error,
//         title: "Login failed",
//         desc: "Invalid email or password!",
//         buttons: [
//           DialogButton(
//             color: Colors.purple,
//             child: Text(
//               "OK",
//               style: TextStyle(color: Colors.white, fontSize: 20),
//             ),
//             onPressed: () => Navigator.pop(context),
//             width: 120,
//           )
//         ],
//       ).show();