import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_essentials/async_value/todo_state.dart';
import 'package:riverpod_essentials/async_value/widgets/async_todo_item.dart';

class TodoList extends StatefulWidget {
  const TodoList({Key? key}) : super(key: key);

  @override
  _TodoListState createState() => _TodoListState();
}

class _TodoListState extends State<TodoList> {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Consumer(
        builder: (context, ref, child) {
          final todosState = ref.watch(todosNotifierProvider);
          return todosState.when(
            data: (todos) {
              return RefreshIndicator(
                onRefresh: () {
                  return ref.read(todosNotifierProvider.notifier).refresh();
                },
                child: ListView(
                  children: [
                    ...todos
                        .map(
                          (todo) => ProviderScope(
                            overrides: [currentTodo.overrideWithValue(todo)],
                            child: const AsyncTodoItem(),
                          ),
                        )
                        .toList()
                  ],
                ),
              );
            },
            loading: () => const Center(
              child: CircularProgressIndicator(),
            ),
            error: (e, st) => Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text('Todos could not be loaded'),
                  ElevatedButton(
                    onPressed: () {
                      ref
                          .read(todosNotifierProvider.notifier)
                          .retryLoadingTodo();
                    },
                    child: const Text('Retry'),
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
