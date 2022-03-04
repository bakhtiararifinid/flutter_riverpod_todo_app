import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../services/todo_service.dart';
import '../../states/todo.dart';
import '../entry_todo/entry_todo_page.dart';

class TodoPage extends ConsumerWidget {
  const TodoPage({Key? key}) : super(key: key);

  static const routeName = '/todo';

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final todoAsyncValue = ref.watch(todoProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Todo'),
        actions: todoAsyncValue.value != null
            ? _buildAppBarActions(context, ref)
            : null,
      ),
      body: todoAsyncValue.when(
        data: (todo) {
          return Column(
            children: [
              _Field(
                label: 'Title',
                value: todo?.title ?? '',
              ),
              _Field(
                label: 'Completed',
                value: todo?.isCompleted == true ? 'Yes' : 'No',
              ),
            ],
          );
        },
        error: (error, _) => Center(child: Text(error.toString())),
        loading: () => const Center(child: CircularProgressIndicator()),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _gotoEntryTodoPage(context),
        child: const Icon(Icons.edit),
      ),
    );
  }

  void _gotoEntryTodoPage(BuildContext context) {
    Navigator.of(context).pushNamed(EntryTodoPage.routeName);
  }

  List<Widget> _buildAppBarActions(BuildContext context, WidgetRef ref) {
    return [
      IconButton(
        onPressed: () => _toggleIsComplete(ref),
        icon: const Icon(Icons.check),
      ),
      IconButton(
        onPressed: () => _delete(context, ref),
        icon: const Icon(Icons.delete),
      ),
    ];
  }

  void _toggleIsComplete(WidgetRef ref) {
    final todo = ref.read(todoProvider).value;
    if (todo != null && todo.id != null) {
      ref.read(todoServiceProvider).toggleIsCompleted(todo.id!);
    }
  }

  void _delete(BuildContext context, WidgetRef ref) async {
    final todo = ref.read(todoProvider).value;
    if (todo != null && todo.id != null) {
      await ref.read(todoServiceProvider).delete(todo.id!);
      Navigator.of(context).pop();
    }
  }
}

class _Field extends StatelessWidget {
  const _Field({
    Key? key,
    required this.label,
    required this.value,
  }) : super(key: key);

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    final valueStyle = Theme.of(context).textTheme.subtitle1;
    final labelStyle = valueStyle?.copyWith(fontWeight: FontWeight.bold);

    return Container(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: labelStyle),
          Text(value, style: valueStyle),
        ],
      ),
    );
  }
}
