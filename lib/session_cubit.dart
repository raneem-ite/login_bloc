import 'package:authentication_system_with_bloc/Auth/auth_credentials.dart';
import 'package:authentication_system_with_bloc/Auth/auth_repository.dart';
import 'package:authentication_system_with_bloc/session_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SessionCubit extends Cubit<SessionState> {
  final AuthRepository? authRepo;

  SessionCubit({this.authRepo}) : super(UnkownSessionState()) {
    attemptAutoLogin();
  }

  void showAuth() => emit(Unauthenticated());
  void showSession(AuthCredentials credentials) {
    // final user = dataRepo.getUser(credentials.userId);
    final user = credentials.username;
    emit(Authenticated(user: user));
  }

  void attemptAutoLogin() async {
    try {
      final userId = await authRepo?.attemptAutoLogin();
      // final user = dataRepo.getUser(userId);
      final user = userId;
      emit(Authenticated(user: user));
    } catch (e) {
      emit(Unauthenticated());
    }
  }

  void signOut() {
    authRepo?.signOut();

    emit(Unauthenticated());
  }
}
