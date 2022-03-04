import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/todo/todo.dart';

class TodoRepository {
  int lastId = 4;
  List<Todo> todos = [
    const Todo(id: 1, title: 'Exersice', isCompleted: false),
    const Todo(id: 2, title: 'Meditate', isCompleted: false),
    const Todo(id: 3, title: 'Read a book', isCompleted: false),
  ];

  Future<List<Todo>> getAll() async {
    return todos;
  }

  Future<Todo> getById(int id) async {
    return todos.where((e) => e.id == id).first;
  }

  Future<Todo> add(Todo todo) async {
    todos.add(todo.copyWith(id: lastId));
    lastId++;
    return todo;
  }

  Future<Todo> update(Todo todo) async {
    todos = todos.map((e) => e.id == todo.id ? todo : e).toList();
    return todo;
  }

  Future<Todo> delete(Todo todo) async {
    todos = todos.where((e) => e.id != todo.id).toList();
    return todo;
  }
}

final todoRepositoryProvider = Provider<TodoRepository>((ref) {
  return TodoRepository();
});
