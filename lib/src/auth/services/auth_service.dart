import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/exceptions/api_exception.dart';
import '../../core/services/storage_service.dart';
import '../models/credential/credential.dart';
import '../models/user/user.dart';
import '../repositories/auth_repository.dart';
import '../states/token.dart';
import '../states/user.dart';

class AuthService {
  final Reader read;
  final String _credentialKey = 'credential';

  AuthService(this.read);

  Future<User?> loginWithSavedCredential() async {
    final strCredential = read(storageServiceProvider).get(_credentialKey);
    if (strCredential == null) return null;

    final Map<String, dynamic> json = jsonDecode(strCredential);
    final credential = Credential.fromJson(json);

    try {
      final user = await login(credential);
      read(userProvider.notifier).setState(user);
      return user;
    } on ApiException {
      return null;
    }
  }

  Future<User> login(Credential credential) async {
    final userAndToken = await read(authRepositoryProvider).login(credential);
    read(userProvider.notifier).setState(userAndToken.user);
    read(tokenProvider.notifier).state = userAndToken.token;

    await read(storageServiceProvider).set(
      _credentialKey,
      jsonEncode(credential.toJson()),
    );

    return userAndToken.user;
  }

  Future<void> logout() async {
    await read(authRepositoryProvider).logout();
    read(userProvider.notifier).setState(null);
    read(tokenProvider.notifier).state = null;

    await read(storageServiceProvider).remove(_credentialKey);
  }
}

final authServiceProvider = Provider<AuthService>((ref) {
  return AuthService(ref.read);
});
