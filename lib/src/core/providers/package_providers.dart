import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

final httpProvider = Provider<http.Client>((ref) {
  return http.Client();
});

final envProvider = Provider<Map<String, String>>((ref) {
  return dotenv.env;
});

final sharedPreferencesProvider = Provider<SharedPreferences>((ref) {
  throw UnimplementedError();
});
