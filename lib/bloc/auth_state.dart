part of 'auth_bloc.dart';

@immutable
sealed class AuthState {}

final class AuthInitial extends AuthState {}

class LoginLoadingState extends AuthState {}

class LoginSuccessState extends AuthState {}

// ignore: must_be_immutable
class LoginFailureState extends AuthState {
  String errorMessage;
  LoginFailureState({required this.errorMessage});
}


