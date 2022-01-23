abstract class FormSubmissionStatus {}

// any form submission will have three status :
// 1- the form submitting
// 2- submission success
// 3- submission failed
// and always we have a Initial Status

class InitialFormStatus extends FormSubmissionStatus {
  InitialFormStatus();
}

class FormSubmitting extends FormSubmissionStatus {}

class SubmissionSuccess extends FormSubmissionStatus {}

class SubmissionFailed extends FormSubmissionStatus {
  final String exception;

  SubmissionFailed(this.exception);
}
