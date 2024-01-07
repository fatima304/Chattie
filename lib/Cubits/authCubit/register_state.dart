
class RegisterState{}

class RegisterInitialState extends RegisterState {}

class RegisterLoadingState extends RegisterState {}

class RegisterSuccessState extends RegisterState {}

// ignore: must_be_immutable
class RegisterFailureState extends RegisterState {
  String errorMessage;
  RegisterFailureState({required this.errorMessage});
}