import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/todo/todo.dart';

class TodosNotifier extends StateNotifier<AsyncValue<List<Todo>>> {
  TodosNotifier() : super(const AsyncValue.data([]));

  void setState(List<Todo> todos) => state = AsyncValue.data(todos);
  void setLoading() => state = const AsyncValue.loading();
  void setError(Object error) => state = AsyncValue.error(error);
}

final todosProvider =
    StateNotifierProvider<TodosNotifier, AsyncValue<List<Todo>>>((ref) {
  return TodosNotifier();
});
