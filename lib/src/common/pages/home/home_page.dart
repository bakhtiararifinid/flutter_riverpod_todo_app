import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../todo/models/todo/todo.dart';
import '../../../todo/pages/entry_todo/entry_todo_page.dart';
import '../../../todo/pages/todo/todo_page.dart';
import '../../../todo/services/todo_service.dart';
import '../../../todo/states/todo.dart';
import '../../../todo/states/todos.dart';

class HomePage extends ConsumerStatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  static const routeName = '/home';

  @override
  ConsumerState<HomePage> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> {
  @override
  void initState() {
    super.initState();
    ref.read(todoServiceProvider).getAll();
  }

  @override
  Widget build(BuildContext context) {
    final todosAsyncValue = ref.watch(todosProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Flutter Riverpod Todo App'),
      ),
      body: todosAsyncValue.when(
        data: (todos) {
          return ListView.builder(
            itemCount: todos.length,
            itemBuilder: (context, i) {
              return ListTile(
                title: Text(todos[i].title ?? ''),
                trailing: todos[i].isCompleted ? const Icon(Icons.check) : null,
                onTap: () => _gotoTodoPage(todos[i]),
              );
            },
          );
        },
        error: (error, _) => Center(child: Text(error.toString())),
        loading: () => const Center(child: CircularProgressIndicator()),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _gotoEntryTodoPage,
        child: const Icon(Icons.add),
      ),
    );
  }

  void _gotoEntryTodoPage() {
    ref.read(todoProvider.notifier).setState(const Todo());
    Navigator.of(context).pushNamed(EntryTodoPage.routeName);
  }

  void _gotoTodoPage(Todo todo) {
    ref.read(todoProvider.notifier).setState(todo);
    Navigator.of(context).pushNamed(TodoPage.routeName);
  }
}
