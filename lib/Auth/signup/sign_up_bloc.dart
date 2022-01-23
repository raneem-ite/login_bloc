import 'package:authentication_system_with_bloc/Auth/auth_cubit.dart';
import 'package:authentication_system_with_bloc/Auth/auth_repository.dart';
import 'package:authentication_system_with_bloc/Auth/form_submission_status.dart';
import 'package:authentication_system_with_bloc/Auth/signup/sign_up_event.dart';
import 'package:authentication_system_with_bloc/Auth/signup/sign_up_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignUpBloc extends Bloc<SignUpEvent, SignUpState> {
  final AuthRepository authRepo;
  final AuthCubit authCubit;

  SignUpBloc({required this.authRepo, required this.authCubit})
      : super(SignUpState(formStatus: InitialFormStatus())) {
    on<SignUpEvent>(_onEvent);
  }

  Future<void> _onEvent(SignUpEvent event, Emitter<SignUpState> emit) async {
    if (event is SignUpUsernameChanged) {
      emit(state.copyWith(username: event.username));
    } else if (event is SignUpEmailChanged) {
      emit(state.copyWith(email: event.email));
    }
    // password update
    else if (event is SignUpPasswordChanged) {
      emit(state.copyWith(password: event.password));
    }
    //form submitted
    else if (event is SignUpSubmitted) {
      emit(state.copyWith(formStatus: FormSubmitting()));

      try {
        await authRepo.signUp(
          username: state.username,
          email: state.email,
          password: state.password,
        );
        emit(state.copyWith(formStatus: SubmissionSuccess()));
        authCubit.showConfirmSignUp(
          username: state.username,
          email: state.email,
          password: state.password,
        );
      } catch (e) {
        emit(state.copyWith(formStatus: SubmissionFailed(e.toString())));
      }
    }
  }
}
