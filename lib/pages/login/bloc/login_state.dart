part of 'login_bloc.dart';

enum LoginStatus { initial, loading, success, failure }

class LoginState extends Equatable {
  final LoginStatus status;
  final bool hidePassword;
  final String? errorMessage;

  const LoginState({
    this.status = LoginStatus.initial,
    this.hidePassword = true,
    this.errorMessage,
  });

  LoginState copyWith({
    LoginStatus? status,
    bool? hidePassword,
    String? errorMessage,
  }) {
    return LoginState(
      status: status ?? this.status,
      hidePassword: hidePassword ?? this.hidePassword,
      errorMessage: errorMessage,
    );
  }

  @override
  List<Object?> get props => [status, hidePassword, errorMessage];
}
