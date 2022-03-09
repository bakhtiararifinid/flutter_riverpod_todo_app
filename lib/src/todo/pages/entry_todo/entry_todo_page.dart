import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../common/widgets/checkbox_form_field.dart';
import '../../../common/widgets/loading_button.dart';
import '../../../common/widgets/show_snackbar.dart';
import '../../../core/exceptions/api_exception.dart';
import '../../models/todo/todo.dart';
import '../../services/todo_service.dart';

class EntryTodoPage extends ConsumerStatefulWidget {
  const EntryTodoPage(this.todo, {Key? key}) : super(key: key);

  static const routeName = '/entry_todo';
  final Todo todo;

  @override
  ConsumerState<EntryTodoPage> createState() => _EntryTodoPageState();
}

class _EntryTodoPageState extends ConsumerState<EntryTodoPage> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  bool? _completed = false;
  bool _loading = false;

  @override
  void initState() {
    super.initState();
    _titleController.text = widget.todo.title ?? '';
    _completed = widget.todo.completed;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.todo.id == null ? 'Add Todo' : 'Update Todo'),
      ),
      body: Form(
        key: _formKey,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16),
              child: TextFormField(
                decoration: const InputDecoration(label: Text('Title')),
                controller: _titleController,
                validator: _validateTitle,
              ),
            ),
            CheckboxFormField(
              title: const Text('Completed'),
              onChanged: (value) => setState(() => _completed = value),
              initialValue: _completed == true,
            ),
            const Spacer(),
            _buildSubmitButton(),
            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }

  Widget _buildSubmitButton() {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: SizedBox(
        width: double.infinity,
        child: _loading
            ? const LoadingButton()
            : ElevatedButton(
                onPressed: _submit,
                child: const Text('Save'),
              ),
      ),
    );
  }

  void _submit() async {
    if (!_formKey.currentState!.validate()) return;

    _startLoading();
    try {
      final todoService = ref.read(todoServiceProvider);
      final param = widget.todo.copyWith(
        title: _titleController.text,
        completed: _completed == true,
      );

      await todoService.save(param);

      Navigator.of(context).pop();
    } on ApiException catch (e) {
      showErrorSnackbar(context, e.message);
    } finally {
      _finishLoading();
    }
  }

  String? _validateTitle(value) {
    if (value == null || value.isEmpty) {
      return 'Title is required';
    }
    return null;
  }

  void _startLoading() => setState(() => _loading = true);

  void _finishLoading() => setState(() => _loading = false);
}
