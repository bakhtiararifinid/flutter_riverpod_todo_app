import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/exceptions/api_exception.dart';
import '../models/todo/todo.dart';
import '../repositories/todo_repository.dart';
import '../states/todo.dart';
import '../states/todos.dart';

class TodoService {
  final Reader read;

  TodoService(this.read);

  Future<List<Todo>> getAll() async {
    read(todosProvider.notifier).setLoading();
    try {
      final todos = await read(todoRepositoryProvider).getAll();
      read(todosProvider.notifier).setState(todos);

      return todos;
    } on ApiException catch (e) {
      read(todosProvider.notifier).setError(e);
      return [];
    }
  }

  Future<Todo?> getById(String id) async {
    read(todoProvider.notifier).setLoading();
    try {
      final todo = await read(todoRepositoryProvider).getById(id);
      read(todoProvider.notifier).setState(todo);

      return todo;
    } on ApiException catch (e) {
      read(todoProvider.notifier).setError(e);
      return null;
    }
  }

  Future<Todo> save(Todo param) async {
    Todo todo;
    if (param.id == null) {
      todo = await read(todoRepositoryProvider).add(param);
    } else {
      todo = await read(todoRepositoryProvider).update(param);
    }

    final todos = await read(todoRepositoryProvider).getAll();

    read(todoProvider.notifier).setState(todo);
    read(todosProvider.notifier).setState(todos);

    return todo;
  }

  Future<void> delete(String id) async {
    final param = await read(todoRepositoryProvider).getById(id);
    if (param == null) throw ApiException('Todo not found');

    await read(todoRepositoryProvider).delete(param);
    final todos = await read(todoRepositoryProvider).getAll();

    read(todoProvider.notifier).setState(null);
    read(todosProvider.notifier).setState(todos);
  }
}

final todoServiceProvider = Provider<TodoService>((ref) {
  return TodoService(
    ref.read,
  );
});
