import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sliver_example/bloc_fastcampus/bloc/name/name_bloc.dart';
import 'package:sliver_example/bloc_fastcampus/bloc/password/password_bloc.dart';
import 'package:sliver_example/bloc_fastcampus/widgets/flat_button.dart';

import '../bloc/email/email_bloc.dart';

class StepThree extends StatelessWidget {
  const StepThree({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Step 3'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            BlocBuilder<PasswordBloc, PasswordState>(
              builder: (context, state) {
                return TextField(
                  onChanged: (password) => context
                      .read<PasswordBloc>()
                      .add(PasswordChanged(password)),
                  obscureText: true,
                  decoration: InputDecoration(
                    labelText: '비밀번호',
                    hintText: '비밀번호를 입력하세요.',
                    border: const OutlineInputBorder(),
                    errorText:
                        !state.isPasswordValid ? '비밀번호는 8자 이상이어야합니다.' : null,
                  ),
                );
              },
            ),
            const SizedBox(
              height: 20,
            ),
            BlocBuilder<PasswordBloc, PasswordState>(
              builder: (context, state) {
                return TextField(
                  onChanged: (confirmPassword) => context
                      .read<PasswordBloc>()
                      .add(ConfirmPasswordChanged(confirmPassword)),
                  obscureText: true,
                  decoration: InputDecoration(
                    labelText: '비밀번호 재입력',
                    hintText: '비밀번호를 다시 입력하세요.',
                    border: const OutlineInputBorder(),
                    errorText:
                    !state.isConfirmPasswordValid ? '비밀번호가 일치하지 않습니다.' : null,
                  ),
                );
              },
            ),
            const SizedBox(
              height: 20,
            ),
            BlocBuilder<PasswordBloc, PasswordState>(
              buildWhen: (previous, current) =>
                  previous.isPasswordValid != current.isPasswordValid ||
                  previous.isConfirmPasswordValid !=
                      current.isConfirmPasswordValid,
              builder: (context, state) {
                return FlatButton(
                  onPressed: () {
                    context.read<EmailBloc>().add(const EmailSubmitted());
                    context.read<NameBloc>().add(const NameSubmitted());
                    context.read<PasswordBloc>().add(const PasswordSubmitted());

                    Navigator.popUntil(context, (route) => route.isFirst);
                  },
                  text: 'Complete Registration',
                  isActive:
                      state.isPasswordValid && state.isConfirmPasswordValid,
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
