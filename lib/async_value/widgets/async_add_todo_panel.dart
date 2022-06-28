import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_essentials/async_value/todo_state.dart';

class AsyncAddTodoPanel extends ConsumerStatefulWidget {
  const AsyncAddTodoPanel({Key? key}) : super(key: key);

  @override
  _AsyncAddTodoPanelState createState() => _AsyncAddTodoPanelState();
}

class _AsyncAddTodoPanelState extends ConsumerState<AsyncAddTodoPanel> {
  final _textEditingController = TextEditingController();

  void _submit([String? value]) {
    ref
        .read(todosNotifierProvider.notifier)
        .add(_textEditingController.value.text);
    _textEditingController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: _textEditingController,
              decoration: const InputDecoration(hintText: 'New todo'),
              onSubmitted: _submit,
            ),
          ),
          IconButton(
            icon: const Icon(Icons.check),
            onPressed: _submit,
          ),
        ],
      ),
    );
  }
}
