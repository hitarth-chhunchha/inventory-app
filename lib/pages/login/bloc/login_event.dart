part of 'login_bloc.dart';

sealed class LoginEvent extends Equatable {
  const LoginEvent();

  @override
  List<Object> get props => [];
}

class TogglePasswordVisibility extends LoginEvent {
  const TogglePasswordVisibility();

  @override
  List<Object> get props => [];
}

class LoginSubmitted extends LoginEvent {
  final String mobile;
  final String password;

  const LoginSubmitted({required this.mobile, required this.password});

  @override
  List<Object> get props => [mobile, password];
}
