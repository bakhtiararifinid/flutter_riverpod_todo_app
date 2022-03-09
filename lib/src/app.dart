import 'package:flutter/material.dart';

import 'auth/pages/login/login_page.dart';
import 'common/pages/home/home_page.dart';
import 'common/pages/launch/launch_page.dart';
import 'todo/models/todo/todo.dart';
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
      initialRoute: LaunchPage.routeName,
      routes: {
        LaunchPage.routeName: (_) => const LaunchPage(),
        LoginPage.routeName: (_) => const LoginPage(),
        HomePage.routeName: (_) => const HomePage(),
        TodoPage.routeName: (_) => const TodoPage(),
        EntryTodoPage.routeName: (context) {
          final todo = ModalRoute.of(context)!.settings.arguments as Todo;
          return EntryTodoPage(todo);
        },
      },
    );
  }
}
