import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../models/todo/todo.dart';
import '../../services/todo_service.dart';
import '../../states/todo.dart';

class EntryTodoPage extends ConsumerStatefulWidget {
  const EntryTodoPage({
    Key? key,
  }) : super(key: key);

  static const routeName = '/entry_todo';

  @override
  ConsumerState<EntryTodoPage> createState() => _EntryTodoPageState();
}

class _EntryTodoPageState extends ConsumerState<EntryTodoPage> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  late final Todo? _todo;

  @override
  void initState() {
    super.initState();
    _todo = ref.read(todoProvider).value;
    if (_todo != null) {
      _titleController.text = _todo!.title ?? '';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_todo?.id == null ? 'Add Todo' : 'Update Todo'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                decoration: const InputDecoration(label: Text('Title')),
                controller: _titleController,
                validator: _validateTitle,
              ),
              const Spacer(),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _submit,
                  child: const Text('Simpan'),
                ),
              ),
              const SizedBox(height: 32),
            ],
          ),
        ),
      ),
    );
  }

  void _submit() async {
    if (!_formKey.currentState!.validate()) return;

    final todoService = ref.read(todoServiceProvider);
    if (_todo?.id == null) {
      await todoService.add(_titleController.text);
    } else {
      await todoService.update(_todo!.id!, _titleController.text);
    }

    Navigator.of(context).pop();
  }

  String? _validateTitle(value) {
    if (value == null || value.isEmpty) {
      return 'Title is required';
    }
    return null;
  }
}
