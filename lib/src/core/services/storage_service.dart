import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../providers/package_providers.dart';

class StorageService {
  final SharedPreferences _prefs;

  StorageService(this._prefs);

  Future<bool> set(String key, String value) => _prefs.setString(key, value);

  String? get(String key) => _prefs.getString(key);

  Future<bool> remove(String key) => _prefs.remove(key);
}

final storageServiceProvider = Provider<StorageService>((ref) {
  return StorageService(
    ref.watch(sharedPreferencesProvider),
  );
});
