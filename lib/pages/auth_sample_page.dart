import 'package:alexander/service/auth.dart';
import 'package:alexander/service/model/authentication.dart';
import 'package:alexander/view_model/common/auth_state_notifier.dart';
import 'package:alexander/view_model/model/sign_in_page_state.dart';
import 'package:alexander/view_model/sign_in_page_state_notifier.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final signInPageProvider =
    StateNotifierProvider.autoDispose<SignInPageStateNotifier, SignInPageState>(
  (refs) => SignInPageStateNotifier(const SignInPageState(), refs),
);

class AuthSamplePage extends HookWidget {
  // final _form = GlobalKey<FormState>();
  // final _emailController = TextEditingController();
  // final _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    useProvider(authStateProvider);
    useProvider(signInPageProvider);
    final notifier = useProvider(signInPageProvider.notifier);

    final authUser = notifier.authUser;

    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Form(
          key: notifier.form,
          child: Column(
            children: [
              if (authUser != null)
                Row(
                  children: [
                    const Text('ログイン済み：'),
                    Text(authUser.firstName),
                  ],
                ),
              TextFormField(
                controller: notifier.emailController,
              ),
              TextFormField(
                controller: notifier.passwordController,
              ),
              ElevatedButton(
                onPressed: notifier.onTapSignInButton(),
                child: const Text('ログイン'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
