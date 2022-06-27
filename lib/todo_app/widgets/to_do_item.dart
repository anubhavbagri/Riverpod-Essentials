import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_essentials/todo_app/state.dart';

final currentTodo = Provider<Todo>((ref) => throw UnimplementedError());

class TodoItem extends StatefulWidget {
  TodoItem({Key? key}) : super(key: key);

  @override
  State<TodoItem> createState() => _TodoItemState();
}

class _TodoItemState extends State<TodoItem> {
  late TextEditingController _textEditingController;
  late FocusNode _textFocusNode;

  bool hasFocus = false;

  @override
  void initState() {
    super.initState();
    _textEditingController = TextEditingController();
    _textFocusNode = FocusNode();
  }

  @override
  void dispose() {
    _textEditingController.dispose();
    _textFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, ref, select) {
        final todo = ref.watch(currentTodo);
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: Dismissible(
            key: UniqueKey(),
            background: Container(color: Colors.red),
            onDismissed: (_) {
              // Method 3
              ref.read(todosProvider.notifier).remove(todo.id);
            },
            child: FocusScope(
              child: Focus(
                onFocusChange: (isFocused) {
                  if (!isFocused) {
                    setState(() {
                      hasFocus = false;
                    });
                    // Method 3
                    ref.read(todosProvider.notifier).edit(
                        id: todo.id, description: _textEditingController.text);
                  } else {
                    _textEditingController.text = todo.description;
                    _textEditingController.selection =
                        TextSelection.fromPosition(
                      TextPosition(
                        offset: _textEditingController.text.length,
                      ),
                    );
                  }
                },
                child: ListTile(
                  onTap: () {
                    setState(() {
                      hasFocus = true;
                    });
                    _textFocusNode.requestFocus();
                  },
                  title: hasFocus
                      ? TextField(
                          focusNode: _textFocusNode,
                          controller: _textEditingController,
                        )
                      : Text(todo.description),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Checkbox(
                        value: todo.completed,
                        onChanged: (_) {
                          // Method 3
                          ref.read(todosProvider.notifier).toggle(todo.id);
                        },
                      ),
                      IconButton(
                        icon: Icon(Icons.delete),
                        onPressed: () {
                          // Method 3
                          ref.read(todosProvider.notifier).remove(todo.id);
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
