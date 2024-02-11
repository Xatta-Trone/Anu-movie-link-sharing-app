import 'package:anu3/auth/auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sign_in_button/sign_in_button.dart';

class LoginPage extends ConsumerStatefulWidget {
  const LoginPage({super.key});

  @override
  ConsumerState<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends ConsumerState<LoginPage> {
  _login() {
    ref.read(authRepositoryProvider).logIn();
    if (kDebugMode) {
      print('login');
    }
  }

  @override
  Widget build(BuildContext context) {
    // final user = ref.watch(authUserProvider).asData?.value;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Login'),
        elevation: 5.0,
      ),
      body: SafeArea(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: SignInButton(
              Buttons.google,
              onPressed: _login,
            ),
          ),
        ],
      )),
    );
  }
}
