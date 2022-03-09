import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/services/api_service.dart';
import '../models/credential/credential.dart';
import '../models/user/user.dart';

class AuthRepository {
  final ApiService _apiService;

  AuthRepository(this._apiService);

  Future<UserAndToken> login(Credential credential) async {
    final json = await _apiService.post(
      '/user/login',
      body: credential.toJson(),
    ) as Map;
    final user = User.fromJson(json['user']);
    final String token = json['token'];

    return UserAndToken(user, token);
  }

  Future<void> logout() async {
    await _apiService.post('/user/logout');
  }
}

class UserAndToken {
  final User user;
  final String token;

  UserAndToken(this.user, this.token);
}

final authRepositoryProvider = Provider<AuthRepository>((ref) {
  return AuthRepository(
    ref.watch(apiServiceProvider),
  );
});
