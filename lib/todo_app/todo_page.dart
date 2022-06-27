import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_essentials/todo_app/state.dart';
import 'package:riverpod_essentials/todo_app/widgets/add_to_do_panel.dart';
import 'package:riverpod_essentials/todo_app/widgets/menu.dart';
import 'package:riverpod_essentials/todo_app/widgets/to_do_item.dart';

class TodoPage extends StatelessWidget {
  const TodoPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            'To-Do',
            style: Theme.of(context).textTheme.headline5!.copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
          ),
          actions: [
            Menu(),
          ],
          bottom: TabBar(
            tabs: [
              Padding(
                padding: const EdgeInsets.only(bottom: 10.0),
                child: Text(
                  'All',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 10.0),
                child: Text(
                  'Completed',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
        ),
        body: SafeArea(
          child: TabBarView(
            children: [
              Column(
                children: [
                  AddTodoPanel(),
                  SizedBox(
                    height: 20,
                  ),
                  Expanded(
                    // Method 1
                    child: Consumer(
                      builder: ((context, ref, child) {
                        return ListView(
                          children: [
                            ...ref
                                .watch(todosProvider)
                                // TODO
                                .map(
                                  (todo) => ProviderScope(
                                    overrides: [
                                      currentTodo.overrideWithValue(todo),
                                    ],
                                    child: TodoItem(),
                                  ),
                                )
                                .toList(),
                          ],
                        );
                      }),
                      // child of consumer actually allow us to increase the performance of the application by reducing the build of this particular child over here as it gets cached & only build once when the consumer is initially built
                      // child: Text('asdf'),
                    ),
                  ),
                ],
              ),
              // Method 1
              Consumer(
                builder: ((context, ref, child) {
                  return ListView(
                    children: [
                      ...ref
                          .watch(completedTodos)
                          .map(
                            (todo) => ProviderScope(
                              overrides: [
                                currentTodo.overrideWithValue(todo),
                              ],
                              child: TodoItem(),
                            ),
                          )
                          .toList(),
                    ],
                  );
                }),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
