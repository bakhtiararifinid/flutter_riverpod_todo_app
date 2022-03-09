import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/user/user.dart';

class UserNotifier extends StateNotifier<User?> {
  UserNotifier() : super(null);

  void setState(User? user) => state = user;
}

final userProvider = StateNotifierProvider<UserNotifier, User?>((ref) {
  return UserNotifier();
});
