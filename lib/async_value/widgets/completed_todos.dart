import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_essentials/async_value/todo_state.dart';
import 'package:riverpod_essentials/async_value/widgets/async_todo_item.dart';

class CompletedTodos extends ConsumerWidget {
  const CompletedTodos({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final todosState = ref.watch(completedTodosProvider);
    return todosState.when(
      data: (todos) {
        return ListView(
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
        );
      },
      loading: () => const Center(
        child: CircularProgressIndicator(),
      ),
      error: (e, st) => const Center(
        child: Text('Something went wrong'),
      ),
    );
  }
}
