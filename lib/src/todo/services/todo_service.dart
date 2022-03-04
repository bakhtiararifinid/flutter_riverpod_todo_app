import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/todo/todo.dart';
import '../repositories/todo_repository.dart';
import '../states/todo.dart';
import '../states/todos.dart';

class TodoService {
  final Reader read;
  final TodoRepository todoRepository;

  TodoService(this.read, this.todoRepository);

  Future<List<Todo>> getAll() async {
    final todos = await todoRepository.getAll();
    read(todosProvider.notifier).setState(todos);

    return todos;
  }

  Future<Todo> getById(int id) async {
    final todo = await todoRepository.getById(id);
    read(todoProvider.notifier).setState(todo);

    return todo;
  }

  Future<Todo> add(String title) async {
    final param = Todo(title: title);
    final todo = await todoRepository.add(param);
    read(todoProvider.notifier).setState(todo);

    final todos = await todoRepository.getAll();
    read(todosProvider.notifier).setState(todos);

    return todo;
  }

  Future<Todo> update(int id, String title) async {
    Todo param = await todoRepository.getById(id);
    param = param.copyWith(title: title);

    final todo = await todoRepository.update(param);
    read(todoProvider.notifier).setState(todo);

    final todos = await todoRepository.getAll();
    read(todosProvider.notifier).setState(todos);

    return todo;
  }

  Future<Todo> toggleIsCompleted(int id) async {
    Todo param = await todoRepository.getById(id);
    param = param.copyWith(isCompleted: !param.isCompleted);

    final todo = await todoRepository.update(param);
    read(todoProvider.notifier).setState(todo);

    final todos = await todoRepository.getAll();
    read(todosProvider.notifier).setState(todos);

    return todo;
  }

  Future<Todo> delete(int id) async {
    final param = await todoRepository.getById(id);
    final todo = await todoRepository.delete(param);
    read(todoProvider.notifier).setState(todo);

    final todos = await todoRepository.getAll();
    read(todosProvider.notifier).setState(todos);

    return todo;
  }
}

final todoServiceProvider = Provider<TodoService>((ref) {
  return TodoService(
    ref.read,
    ref.watch(todoRepositoryProvider),
  );
});
