import 'package:authentication_system_with_bloc/Auth/auth_cubit.dart';
import 'package:authentication_system_with_bloc/Auth/auth_repository.dart';
import 'package:authentication_system_with_bloc/Auth/confirmation/confirmation_event.dart';
import 'package:authentication_system_with_bloc/Auth/confirmation/confirmation_state.dart';
import 'package:authentication_system_with_bloc/Auth/form_submission_status.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

//this class will map every single event to state
// cuz we know that event is getting from user and
// state our response to that event.
// UI 2 Backend ---> Event
// Backend 2 UI ---> state
class ConfirmationBloc extends Bloc<ConfirmationEvent, ConfirmationState> {
  final AuthRepository authRepo;
  final AuthCubit authCubit;

  ConfirmationBloc({required this.authRepo, required this.authCubit})
      : super(ConfirmationState(formStatus: InitialFormStatus())) {
    on<ConfirmationEvent>(_onEvent);
  }

  Future<void> _onEvent(
      ConfirmationEvent event, Emitter<ConfirmationState> emit) async {
    if (event is ConfirmationCodeChanged) {
      emit(state.copyWith(code: event.code));
    }
    //form submitted
    else if (event is ConfirmationSubmitted) {
      emit(state.copyWith(formStatus: FormSubmitting()));

      try {
        final userId = await authRepo.confirmSignUp(
            username: authCubit.credentials.username,
            confirmationCode: state.code);
        emit(state.copyWith(formStatus: SubmissionSuccess()));
        final credentials = authCubit.credentials;
        credentials.userId = userId;
        authCubit.launchSession(credentials);
      } catch (e) {
        emit(state.copyWith(formStatus: SubmissionFailed(e.toString())));
      }
    }
  }
}
