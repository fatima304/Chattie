import 'package:chatapp/Cubits/RegisterCubit/register_cubit.dart';
import 'package:chatapp/Cubits/RegisterCubit/register_state.dart';

import '../Helper/showSnackBar.dart';
import 'package:flutter/material.dart';
import 'package:chatapp/Conestance.dart';
import 'package:chatapp/Screens/chatPage.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:chatapp/Components/button.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:chatapp/Components/textField.dart';
import 'package:flutter_gutter/flutter_gutter.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class RegisterScreen extends StatelessWidget {
  String? email;

  String? password;

  bool isLoading = false;

  GlobalKey<FormState> formKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<RegisterCubit, RegisterState>(
      listener: (context, state) {
        if (state is RegisterLoadingState) {
          isLoading = true;
        } else if (state is RegisterSuccessState) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) {
                return ChatScreen(email: email);
              },
            ),
          );
          isLoading = false;
        } else if (state is RegisterFailureState) {
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
                          BlocProvider.of<RegisterCubit>(context)
                              .registerUser(email: email!, password: password!);
                          isLoading = false;
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
                            Navigator.pop(context);
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
      },
    );
  }
}
