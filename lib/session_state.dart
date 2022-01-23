abstract class SessionState {}

class UnkownSessionState extends SessionState {}

class Unauthenticated extends SessionState {}

class Authenticated extends SessionState {
  final dynamic user;
  Authenticated({required this.user});
}
