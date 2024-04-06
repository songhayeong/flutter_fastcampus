part of 'password_bloc.dart';

class PasswordState {
  final String password;

  final String confirmPassword;

  final bool isPasswordValid;
  final bool isConfirmPasswordValid;

  PasswordState({
    required this.password,
    required this.confirmPassword,
    required this.isPasswordValid,
    required this.isConfirmPasswordValid,
  });

  PasswordState copyWith({
    String? password,
    String? confirmPassword,
    bool? isPasswordValid,
    bool? isConfirmPasswordValid,
  }) =>
      PasswordState(
        password: password ?? this.password,
        confirmPassword: confirmPassword ?? this.confirmPassword,
        isPasswordValid: isPasswordValid ?? this.isPasswordValid,
        isConfirmPasswordValid:
            isConfirmPasswordValid ?? this.isConfirmPasswordValid,
      );
}
