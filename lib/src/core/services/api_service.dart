import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;

import '../../auth/states/token.dart';
import '../exceptions/api_exception.dart';
import '../providers/package_providers.dart';

class ApiService {
  final http.Client httpClient;
  final Map<String, String> env;
  final String? token;

  ApiService(this.httpClient, this.env, this.token);

  Future<Object> get(String path) async {
    final response = await httpClient.get(
      _getUri(path),
      headers: _getHeaders(),
    );

    if (response.statusCode ~/ 100 != 2) {
      throw ApiException(response.body);
    }

    return jsonDecode(response.body);
  }

  Future<Object> post(
    String path, {
    Map<String, dynamic>? body,
  }) async {
    final response = await httpClient.post(
      _getUri(path),
      headers: _getHeaders(),
      body: _getBody(body),
    );

    if (response.statusCode ~/ 100 != 2) {
      throw ApiException(response.body);
    }

    return jsonDecode(response.body);
  }

  Future<Object> put(
    String path, {
    Map<String, dynamic>? body,
  }) async {
    final response = await httpClient.put(
      _getUri(path),
      headers: _getHeaders(),
      body: _getBody(body),
    );

    if (response.statusCode ~/ 100 != 2) {
      throw ApiException(response.body);
    }

    return jsonDecode(response.body);
  }

  Future<Object> delete(String path) async {
    final response = await httpClient.delete(
      _getUri(path),
      headers: _getHeaders(),
    );

    if (response.statusCode ~/ 100 != 2) {
      throw ApiException(response.body);
    }

    return jsonDecode(response.body);
  }

  Uri _getUri(String path) => Uri.parse(env['API_BASE_URL']! + path);

  Map<String, String> _getHeaders() {
    final headers = {"Content-Type": "application/json"};
    if (token != null) {
      headers['Authorization'] = 'Bearer $token';
    }

    return headers;
  }

  String? _getBody(Map<String, dynamic>? body) {
    if (body == null) return null;

    return jsonEncode(body);
  }
}

final apiServiceProvider = Provider<ApiService>((ref) {
  return ApiService(
    ref.watch(httpProvider),
    ref.watch(envProvider),
    ref.watch(tokenProvider),
  );
});
