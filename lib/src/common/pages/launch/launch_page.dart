import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../auth/pages/login/login_page.dart';
import '../../../auth/services/auth_service.dart';
import '../home/home_page.dart';

class LaunchPage extends ConsumerStatefulWidget {
  const LaunchPage({Key? key}) : super(key: key);

  static const routeName = '/launch';

  @override
  ConsumerState<LaunchPage> createState() => _LaunchPageState();
}

class _LaunchPageState extends ConsumerState<LaunchPage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance?.addPostFrameCallback((_) async {
      await Future.delayed(const Duration(seconds: 1));

      final authService = ref.read(authServiceProvider);
      final user = await authService.loginWithSavedCredential();
      if (user != null) {
        _gotoHomePage();
      } else {
        _gotoLoginPage();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }

  void _gotoHomePage() {
    Navigator.of(context).pushReplacementNamed(HomePage.routeName);
  }

  void _gotoLoginPage() {
    Navigator.of(context).pushReplacementNamed(LoginPage.routeName);
  }
}
