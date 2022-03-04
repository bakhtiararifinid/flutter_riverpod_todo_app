import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/todo/todo.dart';

class TodoNotifier extends StateNotifier<AsyncValue<Todo?>> {
  TodoNotifier() : super(const AsyncValue.data(null));

  void setState(Todo todo) => state = AsyncValue.data(todo);
  void setAsLoading() => state = const AsyncValue.loading();
  void setAsError(Object error) => state = AsyncValue.error(error);
}

final todoProvider =
    StateNotifierProvider<TodoNotifier, AsyncValue<Todo?>>((ref) {
  return TodoNotifier();
});
