import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:chatapp/Cubits/LoginCubit/login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(LoginInitialState());

  Future<void> loginUser(
      {required String email, required String password}) async {
    emit(LoginLoadingState());
    try {
      UserCredential user = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      print(user.user!.displayName);
      emit(LoginSuccessState());
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        emit(LoginFailureState(errorMessage: 'No user found for that email'));
      } else if (e.code == 'wrong-password') {
        emit(LoginFailureState(errorMessage: 'Wrong password'));
      }
    } catch (e) {
      emit(LoginFailureState(errorMessage: 'something went wrong'));
    }
  }
}
