import 'package:authentication_system_with_bloc/Auth/auth_credentials.dart';
import 'package:authentication_system_with_bloc/session_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

enum AuthState { login, signUp, confirmSignUp }

class AuthCubit extends Cubit<AuthState> {
  final SessionCubit? sessionCubit;
  AuthCubit({this.sessionCubit}) : super(AuthState.login);

  late AuthCredentials credentials;

  void showLogin() => emit(AuthState.login);
  void showSignUp() => emit(AuthState.signUp);
  void showConfirmSignUp({
    required String username,
    String? email,
    String? password,
  }) {
    credentials =
        AuthCredentials(username: username, email: email, password: password);

    emit(AuthState.confirmSignUp);
  }

  void launchSession(AuthCredentials credentials) =>
      sessionCubit?.showSession(credentials);
}
