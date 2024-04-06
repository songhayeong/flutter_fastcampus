part of 'password_bloc.dart';

sealed class PasswordEvent {
  const PasswordEvent();
}

final class PasswordChanged extends PasswordEvent {
  final String password;

  const PasswordChanged(this.password);
}

final class ConfirmPasswordChanged extends PasswordEvent {
  final String confirmPassword;

  const ConfirmPasswordChanged(this.confirmPassword);
}

final class PasswordSubmitted extends PasswordEvent {
  const PasswordSubmitted();
}