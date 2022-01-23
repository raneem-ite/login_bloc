abstract class LoginEvent {}

// on the event page :
// you must think what the interacts of user with your UI
// for login it could :
// 1- the user change the username
// 2- the user change the password
// 3- the user press loginButton
// so we will have three Events

class LoginUsernameChanged extends LoginEvent {
  final String username;

  LoginUsernameChanged({required this.username});
}

class LoginPasswordChanged extends LoginEvent {
  final String password;

  LoginPasswordChanged({required this.password});
}

class LoginSubmitted extends LoginEvent {}
