import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:meta/meta.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc() : super(AuthInitial()) {
    on<AuthEvent>(
      (event, emit) async {
        if (event is AuthLoginEvent) {
          emit(LoginLoadingState());
          try {
            UserCredential user = await FirebaseAuth.instance
                .signInWithEmailAndPassword(
                    email: event.email, password: event.password);
            print(user.user!.displayName);
            emit(LoginSuccessState());

          } on FirebaseAuthException catch (e) {
            if (e.code == 'user-not-found') {
              emit(LoginFailureState(
                  errorMessage: 'No user found for that email'));
            } else if (e.code == 'wrong-password') {
              emit(LoginFailureState(errorMessage: 'Wrong password'));
            }
          } catch (e) {
            emit(LoginFailureState(errorMessage: 'something went wrong'));
          }
        }
      },
    );
  }
}
