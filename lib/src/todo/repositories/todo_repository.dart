import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/services/api_service.dart';
import '../models/todo/todo.dart';

class TodoRepository {
  final ApiService apiService;

  TodoRepository(this.apiService);

  Future<List<Todo>> getAll() async {
    final json = await apiService.get('/task') as Map;
    return (json['data'] as List).map((e) => Todo.fromJson(e)).toList();
  }

  Future<Todo?> getById(String id) async {
    final json = await apiService.get('/task/$id') as Map;
    return Todo.fromJson(json['data']);
  }

  Future<Todo> add(Todo param) async {
    final json = await apiService.post(
      '/task',
      body: param.toJsonForm(),
    ) as Map;

    return Todo.fromJson(json['data']);
  }

  Future<Todo> update(Todo param) async {
    final json = await apiService.put(
      '/task/${param.id}',
      body: param.toJsonForm(),
    ) as Map;

    return Todo.fromJson(json['data']);
  }

  Future<void> delete(Todo param) async {
    await apiService.delete('/task/${param.id}');
  }
}

final todoRepositoryProvider = Provider<TodoRepository>((ref) {
  return TodoRepository(
    ref.watch(apiServiceProvider),
  );
});
