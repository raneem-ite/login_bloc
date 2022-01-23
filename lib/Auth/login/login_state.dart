import 'package:authentication_system_with_bloc/Auth/form_submission_status.dart';

class LoginState {
  final String username;
  bool get isValidUser => username.length > 3;

  final String password;
  bool get isValidPassword => password.length > 6;

  final FormSubmissionStatus formStatus;

  LoginState({
    this.username = " ",
    this.password = " ",
    required this.formStatus,
  });

  LoginState copyWith({
    String? username,
    String? password,
    FormSubmissionStatus? formStatus,
  }) {
    return LoginState(
      username: username ?? this.username,
      password: password ?? this.password,
      formStatus: formStatus ?? this.formStatus,
    );
  }
}
