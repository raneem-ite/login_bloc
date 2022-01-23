import 'package:authentication_system_with_bloc/Auth/form_submission_status.dart';

class ConfirmationState {
  final String code;
  bool get isValidCode => code.length == 3;

  final FormSubmissionStatus formStatus;

  ConfirmationState({
    this.code = " ",
    required this.formStatus,
  });

  ConfirmationState copyWith({
    String? code,
    FormSubmissionStatus? formStatus,
  }) {
    return ConfirmationState(
      code: code ?? this.code,
      formStatus: formStatus ?? this.formStatus,
    );
  }
}
