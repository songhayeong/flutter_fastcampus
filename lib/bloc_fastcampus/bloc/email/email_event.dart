part of 'email_bloc.dart';

sealed class EmailEvent {
  const EmailEvent();
}

final class EmailChanged extends EmailEvent {
  final String email;

  const EmailChanged(this.email);
}

final class EmailSubmitted extends EmailEvent {
  const EmailSubmitted();
}
