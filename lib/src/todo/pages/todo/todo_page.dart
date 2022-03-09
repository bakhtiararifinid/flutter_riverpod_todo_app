import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../common/widgets/loading_icon_button.dart';
import '../../../common/widgets/show_snackbar.dart';
import '../../../core/exceptions/api_exception.dart';
import '../../models/todo/todo.dart';
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
        actions: const [
          _DeleteTodoButton(),
        ],
      ),
      body: todoAsyncValue.when(
        data: _buildData,
        error: _buildError,
        loading: _buildLoading,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _gotoEntryTodoPage(context, ref),
        child: const Icon(Icons.edit),
      ),
    );
  }

  Widget _buildData(Todo? todo) {
    return ListView(
      children: [
        ListTile(
          title: const Text('Title'),
          subtitle: Text(todo?.title ?? ''),
        ),
        ListTile(
          title: const Text('Completed'),
          subtitle: Text(todo?.completed == true ? 'Yes' : 'No'),
        ),
      ],
    );
  }

  Widget? _buildError(error, _) => Center(child: Text(error.toString()));

  Widget? _buildLoading() => const Center(child: CircularProgressIndicator());

  void _gotoEntryTodoPage(BuildContext context, WidgetRef ref) {
    final todo = ref.read(todoProvider).value;
    Navigator.of(context).pushNamed(EntryTodoPage.routeName, arguments: todo!);
  }
}

class _DeleteTodoButton extends ConsumerStatefulWidget {
  const _DeleteTodoButton({Key? key}) : super(key: key);

  @override
  ConsumerState<_DeleteTodoButton> createState() => _DeleteTodoButtonState();
}

class _DeleteTodoButtonState extends ConsumerState<_DeleteTodoButton> {
  bool _loading = false;

  @override
  Widget build(BuildContext context) {
    if (_loading) return const LoadingIconButton();

    return IconButton(
      onPressed: () => _delete(),
      icon: const Icon(Icons.delete),
    );
  }

  void _delete() async {
    _startLoading();
    try {
      final todo = ref.read(todoProvider).value;
      await ref.read(todoServiceProvider).delete(todo!.id!);
      Navigator.of(context).pop();
    } on ApiException catch (e) {
      showErrorSnackbar(context, e.message);
    } finally {
      _finishLoading();
    }
  }

  void _startLoading() => setState(() => _loading = true);

  void _finishLoading() => setState(() => _loading = false);
}
