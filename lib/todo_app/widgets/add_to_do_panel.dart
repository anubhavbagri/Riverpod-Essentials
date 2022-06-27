import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_essentials/todo_app/state.dart';

class AddTodoPanel extends ConsumerStatefulWidget {
  const AddTodoPanel({Key? key}) : super(key: key);

  @override
  _AddTodoPanelState createState() => _AddTodoPanelState();
}

class _AddTodoPanelState extends ConsumerState<AddTodoPanel> {
  TextEditingController _textEditingController = TextEditingController();

  void _submit([String? value]) {
    // Method 3
    ref.read(todosProvider.notifier).add(_textEditingController.value.text);
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
              decoration: InputDecoration(hintText: 'New todo'),
              onSubmitted: _submit,
            ),
          ),
          IconButton(
            icon: Icon(Icons.check),
            onPressed: _submit,
          ),
        ],
      ),
    );
  }
}
