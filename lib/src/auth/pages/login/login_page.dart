import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../common/pages/home/home_page.dart';
import '../../../common/widgets/loading_button.dart';
import '../../../common/widgets/show_snackbar.dart';
import '../../../core/exceptions/api_exception.dart';
import '../../models/credential/credential.dart';
import '../../services/auth_service.dart';

class LoginPage extends ConsumerStatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  static const routeName = '/login';

  @override
  ConsumerState<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends ConsumerState<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _loading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _emailController,
                decoration: const InputDecoration(label: Text('Email')),
                validator: _validateEmail,
              ),
              TextFormField(
                controller: _passwordController,
                decoration: const InputDecoration(label: Text('Password')),
                validator: _validatePassword,
                obscureText: true,
              ),
              const SizedBox(height: 32),
              SizedBox(
                width: double.infinity,
                child: _loading
                    ? const LoadingButton()
                    : ElevatedButton(
                        onPressed: _login,
                        child: const Text('Login'),
                      ),
              )
            ],
          ),
        ),
      ),
    );
  }

  String? _validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Email is required';
    }

    return null;
  }

  String? _validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Password is required';
    }

    return null;
  }

  Future<void> _login() async {
    if (!_formKey.currentState!.validate()) return;
    _startLoading();

    try {
      final credential = Credential(
        email: _emailController.text,
        password: _passwordController.text,
      );
      await ref.read(authServiceProvider).login(credential);
      _gotoHomePage();
    } on ApiException catch (e) {
      showErrorSnackbar(context, e.message);
    } finally {
      _finishLoading();
    }
  }

  void _gotoHomePage() {
    Navigator.of(context).pushReplacementNamed(HomePage.routeName);
  }

  void _startLoading() => setState(() => _loading = true);

  void _finishLoading() => setState(() => _loading = false);
}
