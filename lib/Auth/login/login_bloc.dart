import 'package:authentication_system_with_bloc/Auth/auth_credentials.dart';
import 'package:authentication_system_with_bloc/Auth/auth_cubit.dart';
import 'package:authentication_system_with_bloc/Auth/auth_repository.dart';
import 'package:authentication_system_with_bloc/Auth/form_submission_status.dart';
import 'package:authentication_system_with_bloc/Auth/login/login_event.dart';
import 'package:authentication_system_with_bloc/Auth/login/login_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

//this class will map every single event to state
// cuz we know that event is getting from user and
// state our response to that event.
// UI 2 Backend ---> Event
// Backend 2 UI ---> state
class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final AuthRepository authRepo;
  final AuthCubit? authCubit;

  LoginBloc({required this.authRepo, this.authCubit})
      : super(LoginState(formStatus: InitialFormStatus())) {
    on<LoginEvent>(_onEvent);
  }

  // @override
  // Stream<LoginState> mapEventToState(LoginEvent event) async* {
  //   //username updated
  //   if (event is LoginUsernameChanged) {
  //     yield state.copyWith(username: event.username);
  //   }
  //   // password update
  //   else if (event is LoginPasswordChanged) {
  //     yield state.copyWith(password: event.password);
  //   }
  //   //form submitted
  //   else if (event is LoginSubmitted) {
  //     yield state.copyWith(formStatus: FormSubmitting());

  //     try {
  //       await authRepo.login();
  //       yield state.copyWith(formStatus: SubmissionSuccess());
  //     } catch (e) {
  //       yield state.copyWith(formStatus: SubmissionFailed(e.toString()));
  //     }
  //   }
  // }

  Future<void> _onEvent(LoginEvent event, Emitter<LoginState> emit) async {
    if (event is LoginUsernameChanged) {
      emit(state.copyWith(username: event.username));
    }
    // password update
    else if (event is LoginPasswordChanged) {
      emit(state.copyWith(password: event.password));
    }
    //form submitted
    else if (event is LoginSubmitted) {
      emit(state.copyWith(formStatus: FormSubmitting()));

      try {
        final userId = await authRepo.login(
            username: state.username, password: state.password);
        emit(state.copyWith(formStatus: SubmissionSuccess()));
        authCubit?.launchSession(AuthCredentials(
          username: state.username,
          userId: userId,
        ));
      } catch (e) {
        emit(state.copyWith(formStatus: SubmissionFailed(e.toString())));
      }
    }
  }
}
