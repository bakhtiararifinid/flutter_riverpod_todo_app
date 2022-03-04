import 'package:flutter/material.dart';

import 'common/pages/home/home_page.dart';
import 'todo/pages/entry_todo/entry_todo_page.dart';
import 'todo/pages/todo/todo_page.dart';

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Riverpod Todo App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: HomePage.routeName,
      routes: {
        HomePage.routeName: (_) => const HomePage(),
        TodoPage.routeName: (_) => const TodoPage(),
        EntryTodoPage.routeName: (_) => const EntryTodoPage(),
      },
    );
  }
}
