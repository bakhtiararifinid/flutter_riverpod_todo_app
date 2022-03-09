import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../todo/models/todo/todo.dart';
import '../../../todo/pages/entry_todo/entry_todo_page.dart';
import '../../../todo/services/todo_service.dart';
import 'account_tab.dart';
import 'home_tab.dart';

class HomePage extends ConsumerStatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  static const routeName = '/home';

  @override
  ConsumerState<HomePage> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> {
  int _currentTab = 0;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance!.addPostFrameCallback((_) {
      ref.read(todoServiceProvider).getAll();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Todo App'),
      ),
      body: _currentTab == 0 ? const HomeTab() : const AccountTab(),
      floatingActionButton: _buildFloatingActionButton(),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Account',
          ),
        ],
        currentIndex: _currentTab,
        onTap: (index) => setState(() => _currentTab = index),
      ),
    );
  }

  Widget? _buildFloatingActionButton() {
    if (_currentTab != 0) return null;

    return FloatingActionButton(
      onPressed: _gotoEntryTodoPage,
      child: const Icon(Icons.add),
    );
  }

  void _gotoEntryTodoPage() {
    Navigator.of(context).pushNamed(
      EntryTodoPage.routeName,
      arguments: const Todo(),
    );
  }
}
