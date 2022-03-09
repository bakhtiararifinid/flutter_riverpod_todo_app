import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../todo/models/todo/todo.dart';
import '../../../todo/pages/todo/todo_page.dart';
import '../../../todo/services/todo_service.dart';
import '../../../todo/states/todos.dart';

class HomeTab extends ConsumerWidget {
  const HomeTab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final todosAsyncValue = ref.watch(todosProvider);

    return todosAsyncValue.when(
      data: (todos) => _buildData(ref, todos),
      error: _buildError,
      loading: _buildLoading,
    );
  }

  Widget _buildData(WidgetRef ref, List<Todo> todos) {
    return ListView.builder(
      itemCount: todos.length,
      itemBuilder: (context, i) {
        return ListTile(
          title: Text(todos[i].title ?? ''),
          trailing: todos[i].completed ? const Icon(Icons.check) : null,
          onTap: () => _gotoTodoPage(context, ref, todos[i]),
        );
      },
    );
  }

  Widget _buildLoading() => const Center(child: CircularProgressIndicator());

  Widget _buildError(error, _) => Center(child: Text(error.toString()));

  void _gotoTodoPage(
    BuildContext context,
    WidgetRef ref,
    Todo todo,
  ) {
    ref.read(todoServiceProvider).getById(todo.id ?? '');
    Navigator.of(context).pushNamed(TodoPage.routeName);
  }
}
