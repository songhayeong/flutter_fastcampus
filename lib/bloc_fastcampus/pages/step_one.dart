import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sliver_example/bloc_fastcampus/bloc/email/email_bloc.dart';
import 'package:sliver_example/bloc_fastcampus/bloc/name/name_bloc.dart';
import 'package:sliver_example/bloc_fastcampus/pages/step_two.dart';
import 'package:sliver_example/bloc_fastcampus/regx.dart';
import 'package:sliver_example/bloc_fastcampus/widgets/flat_button.dart';

class StepOne extends StatelessWidget {
  const StepOne({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Step 1'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            BlocBuilder<EmailBloc, EmailState>(
              builder: (context, state) {
                return TextField(
                  onChanged: (email) =>
                      context.read<EmailBloc>().add(EmailChanged(email)),
                  decoration: InputDecoration(
                      labelText: '이메일',
                      hintText: '이메일을 입력하세요',
                      border: const OutlineInputBorder(),
                      errorText: !state.isValid ? '유효하지 않은 이메일입니다.' : null),
                  keyboardType: TextInputType.emailAddress,
                );
              },
            ),
            const SizedBox(
              height: 20,
            ),
            BlocBuilder<EmailBloc, EmailState>(
              buildWhen: (previous, current) =>
                  previous.isValid != current.isValid,
              builder: (context, state) {
                return FlatButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => BlocProvider(
                            create: (context) => NameBloc(),
                            child: const StepTwo()),
                      ),
                    );
                  },
                  text: 'Next',
                  isActive: state.isValid,
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
