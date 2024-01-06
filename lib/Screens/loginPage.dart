import 'package:chatapp/Cubits/ChatCubit/chat_cubit.dart';

import '../Helper/showSnackBar.dart';
import 'package:flutter/material.dart';
import 'package:chatapp/Conestance.dart';
import 'package:chatapp/Screens/chatPage.dart';
import 'package:chatapp/Components/button.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:chatapp/Screens/registerPage.dart';
import 'package:chatapp/Components/textField.dart';
import 'package:flutter_gutter/flutter_gutter.dart';
import 'package:chatapp/Cubits/LoginCubit/login_cubit.dart';
import 'package:chatapp/Cubits/LoginCubit/login_state.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

String? email;

String? password;

bool isLoading = false;

GlobalKey<FormState> formKey = GlobalKey();

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LoginCubit, LoginState>(
      listener: (context, state) {
        if (state is LoginLoadingState) {
          isLoading = true;
        } else if (state is LoginSuccessState) {
          BlocProvider.of<ChatCubit>(context).getMessage();
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) {
                return ChatScreen(email: email);
              },
            ),
          );
          isLoading = false;
        } else if (state is LoginFailureState) {
          showSnackBar(context, state.errorMessage);
          isLoading = false;
        }
      },
      builder: (context, state) {
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
                          BlocProvider.of<LoginCubit>(context)
                              .loginUser(email: email!, password: password!);
                          isLoading = false;
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
      },
    );
  }
}
