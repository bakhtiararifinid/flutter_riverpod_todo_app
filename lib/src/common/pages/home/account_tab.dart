import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../auth/pages/login/login_page.dart';
import '../../../auth/services/auth_service.dart';
import '../../../auth/states/user.dart';
import '../../../core/exceptions/api_exception.dart';
import '../../widgets/show_snackbar.dart';

class AccountTab extends ConsumerWidget {
  const AccountTab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(userProvider);

    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        CircleAvatar(
          backgroundColor: Theme.of(context).primaryColorLight,
          child: Text(
            user?.name?[0].toUpperCase() ?? '',
            style: const TextStyle(fontSize: 64),
          ),
          radius: 64,
        ),
        const SizedBox(height: 8),
        Text(
          user?.name ?? '',
          style: Theme.of(context).textTheme.headline5,
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 8),
        Text(
          user?.email ?? '',
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 32),
        const _LogoutButton(),
      ],
    );
  }
}

class _LogoutButton extends ConsumerStatefulWidget {
  const _LogoutButton({
    Key? key,
  }) : super(key: key);

  @override
  ConsumerState<_LogoutButton> createState() => _LogoutButtonState();
}

class _LogoutButtonState extends ConsumerState<_LogoutButton> {
  bool _loading = false;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: _buildLeading(),
      title: const Text('Logout'),
      trailing: const Icon(Icons.chevron_right),
      onTap: _logout,
    );
  }

  Widget _buildLeading() {
    if (_loading) {
      return const SizedBox(
        height: 24,
        width: 24,
        child: CircularProgressIndicator(
          color: Colors.grey,
          strokeWidth: 3,
        ),
      );
    }

    return const Icon(Icons.logout);
  }

  void _logout() async {
    try {
      _startLoading();
      await ref.read(authServiceProvider).logout();
      _gotoLoginPage();
    } on ApiException catch (e) {
      showErrorSnackbar(context, e.message);
    } finally {
      _finishLoading();
    }
  }

  void _gotoLoginPage() {
    Navigator.of(context).pushReplacementNamed(LoginPage.routeName);
  }

  void _startLoading() => setState(() => _loading = true);

  void _finishLoading() => setState(() => _loading = false);
}
