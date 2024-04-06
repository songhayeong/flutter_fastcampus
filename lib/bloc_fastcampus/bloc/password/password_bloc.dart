import 'package:flutter_bloc/flutter_bloc.dart';

part 'password_event.dart';

part 'password_state.dart';

class PasswordBloc extends Bloc<PasswordEvent, PasswordState> {
  PasswordBloc()
      : super(PasswordState(
          password: '',
          confirmPassword: '',
          isPasswordValid: false,
          isConfirmPasswordValid: false,
        )) {
    on<PasswordChanged>(_onPasswordChanged);
    on<ConfirmPasswordChanged>(_onConfirmPasswordChanged);
    on<PasswordSubmitted>(_onPasswordSubmitted);
  }

  void _onPasswordChanged(PasswordChanged event, Emitter<PasswordState> emit) {
    final newPassword = event.password;
    final newState = state.copyWith(
        password: newPassword,
        isPasswordValid: _isValidPassword(newPassword),
        isConfirmPasswordValid: _isValidPassword(state.confirmPassword) &&
            newPassword == state.confirmPassword);

    emit(newState);
  }

  void _onConfirmPasswordChanged(
      ConfirmPasswordChanged event, Emitter<PasswordState> emit) {
    final newConfirmPassword = event.confirmPassword;
    final newState = state.copyWith(
      confirmPassword: newConfirmPassword,
      isConfirmPasswordValid: _isValidPassword(newConfirmPassword) &&
          newConfirmPassword == state.password,
    );
    emit(newState);
  }

  void _onPasswordSubmitted(
      PasswordSubmitted event, Emitter<PasswordState> emit) {
    emit(PasswordState(
        password: '',
        confirmPassword: '',
        isPasswordValid: false,
        isConfirmPasswordValid: false));
  }

  bool _isValidPassword(String password) {
    return password.length >= 8;
  }
}
