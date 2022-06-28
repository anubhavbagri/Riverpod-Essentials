import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_essentials/async_value/models/todo.dart';
import 'package:riverpod_essentials/async_value/todo_state.dart';

final currentTodo = Provider<Todo>((ref) {
  throw UnimplementedError();
});

class AsyncTodoItem extends ConsumerStatefulWidget {
  const AsyncTodoItem({
    Key? key,
  }) : super(key: key);

  @override
  _AsyncTodoItemState createState() => _AsyncTodoItemState();
}

class _AsyncTodoItemState extends ConsumerState<AsyncTodoItem> {
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
    final todo = ref.watch(currentTodo);
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Dismissible(
        key: UniqueKey(),
        background: Container(color: Colors.red),
        onDismissed: (_) {
          ref.read(todosNotifierProvider.notifier).remove(todo.id);
        },
        child: FocusScope(
          child: Focus(
            onFocusChange: (isFocused) {
              if (!isFocused) {
                setState(() {
                  hasFocus = false;
                });
                ref.read(todosNotifierProvider.notifier).edit(
                    id: todo.id, description: _textEditingController.text);
              } else {
                _textEditingController
                  ..text = todo.description
                  ..selection = TextSelection.fromPosition(
                      TextPosition(offset: _textEditingController.text.length));
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
                      ref.read(todosNotifierProvider.notifier).toggle(todo.id);
                    },
                  ),
                  IconButton(
                    icon: const Icon(Icons.delete),
                    onPressed: () {
                      ref.read(todosNotifierProvider.notifier).remove(todo.id);
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
