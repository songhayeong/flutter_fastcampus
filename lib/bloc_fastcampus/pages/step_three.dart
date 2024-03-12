import 'package:flutter/material.dart';
import 'package:sliver_example/bloc_fastcampus/widgets/flat_button.dart';

class StepThree extends StatefulWidget {
  const StepThree({super.key});

  @override
  State<StepThree> createState() => _StepThreeState();
}

class _StepThreeState extends State<StepThree> {
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();

  bool _isButtonActive = false;

  void _checkPasswordValidity() {
    final isPasswordMatch =
        _passwordController.text == _confirmPasswordController.text;
    final isPasswordNotEmpty = _passwordController.text.isNotEmpty &&
        _confirmPasswordController.text.isNotEmpty;

    setState(() {
      _isButtonActive = isPasswordMatch && isPasswordNotEmpty;
    });
  }

  @override
  void initState() {
    super.initState();
    _passwordController.addListener(_checkPasswordValidity);
    _confirmPasswordController.addListener(_checkPasswordValidity);
  }

  @override
  void dispose() {
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

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
            TextField(
              obscureText: true,
              controller: _passwordController,
              decoration: const InputDecoration(
                labelText: '비밀번호',
                hintText: '비밀번호를 입력하세요.',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            TextField(
              obscureText: true,
              controller: _confirmPasswordController,
              decoration: const InputDecoration(
                labelText: '비밀번호 재입력',
                hintText: '비밀번호를 다시 입력하세요.',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            FlatButton(
              onPressed: () {
                Navigator.popUntil(context, (route) => route.isFirst);
              },
              text: 'Complete Registration',
              isActive: _isButtonActive,
            ),
          ],
        ),
      ),
    );
  }
}
