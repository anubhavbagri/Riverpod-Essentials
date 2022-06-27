import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uuid/uuid.dart';

var _uuid = Uuid();

final _sampleTodos = [
  Todo('Buy groceries'),
  Todo('Learn Riverpod'),
];

final todosProvider = StateNotifierProvider<TodoNotifier, List<Todo>>((ref) {
  return TodoNotifier(ref.read, _sampleTodos);
});

// those widgets that listens to completedTodos will only be called when the completedTodos changes
final completedTodos = Provider<List<Todo>>((ref) {
  // Method 4
  // we are watching a provider within a provider; completedTodos watches the changes within the todos provider
  final todos = ref.watch(todosProvider);
  // only returning those todos that are marked as completed
  return todos.where((todo) => todo.completed).toList();
});

class TodoNotifier extends StateNotifier<List<Todo>> {
  TodoNotifier(this.read, [List<Todo>? state]) : super(state ?? <Todo>[]);

  final Reader read;

  void add(String desc) {
    state = [...state, Todo(desc)];
  }

  void toggle(String id) {
    // Method 5
    if (read(settingsProvider).deleteOnComplete) {
      remove(id);
      return;
    }

    state = state.map((todo) {
      if (todo.id == id) {
        return Todo(
          todo.description,
          id: todo.id,
          completed: !todo.completed,
        );
      }
      return todo;
    }).toList();
  }

  void edit({required String id, required String description}) {
    state = [
      for (final todo in state)
        if (todo.id == id)
          Todo(
            description,
            id: todo.id,
            completed: todo.completed,
          )
        else
          todo,
    ];
  }

  void remove(String id) {
    state = state.where((element) => element.id != id).toList();
  }
}

class Todo {
  final String id;
  final String description;
  final bool completed;

  Todo(
    this.description, {
    this.completed = false,
    String? id,
  }) : this.id = id ?? _uuid.v4();
}

final settingsProvider = StateProvider<Settings>((ref) {
  return Settings();
});

class Settings {
  final bool deleteOnComplete;

  Settings({this.deleteOnComplete = false});
}
