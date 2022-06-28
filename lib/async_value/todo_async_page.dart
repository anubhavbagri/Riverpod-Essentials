import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_essentials/async_value/services/fake_todo_repository.dart';
import 'package:riverpod_essentials/async_value/todo_state.dart';
import 'package:riverpod_essentials/async_value/widgets/async_add_todo_panel.dart';
import 'package:riverpod_essentials/async_value/widgets/async_menu.dart';
import 'package:riverpod_essentials/async_value/widgets/completed_todos.dart';
import 'package:riverpod_essentials/async_value/widgets/todo_list.dart';

class TodoAsyncPage extends ConsumerWidget {
  const TodoAsyncPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // ref.listen only listens for a change on a provider so it won't cause a rebuild in your widget
    ref.listen<TodoException?>(
      todoExceptionProvider,
      (e, exceptionState) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              exceptionState!.error.toString(),
            ),
          ),
        );
      },
    );
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            'TODOS',
            style: Theme.of(context)
                .textTheme
                .headline3!
                .copyWith(color: Colors.white),
          ),
          actions: const [
            AsyncMenu(),
          ],
          bottom: const TabBar(
            tabs: [
              Padding(
                padding: EdgeInsets.only(bottom: 10.0),
                child: Text(
                  'All',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(bottom: 10.0),
                child: Text(
                  'Completed',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ),
        body: SafeArea(
          child: TabBarView(
            children: [
              Column(
                children: const [
                  AsyncAddTodoPanel(),
                  SizedBox(
                    height: 20,
                  ),
                  TodoList(),
                ],
              ),
              const CompletedTodos(),
            ],
          ),
        ),
      ),
    );
  }
}
