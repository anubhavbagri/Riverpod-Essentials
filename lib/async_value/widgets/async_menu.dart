import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_essentials/async_value/models/settings.dart';
import 'package:riverpod_essentials/async_value/todo_state.dart';

enum _MenuOptions { deleteOnComplete }

class AsyncMenu extends ConsumerWidget {
  const AsyncMenu({Key? key}) : super(key: key);

  Future<void> onSelected(WidgetRef ref, _MenuOptions result) async {
    if (result == _MenuOptions.deleteOnComplete) {
      final currentSetting = ref.read(settingsProvider).deleteOnComplete;
      ref.read(settingsProvider.notifier).state =
          Settings(deleteOnComplete: !currentSetting);
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isChecked = ref.watch(settingsProvider).deleteOnComplete;
    return PopupMenuButton<_MenuOptions>(
      onSelected: (result) {
        onSelected(ref, result);
      },
      icon: const Icon(
        Icons.menu,
      ),
      itemBuilder: (BuildContext context) => <PopupMenuEntry<_MenuOptions>>[
        PopupMenuItem<_MenuOptions>(
          value: _MenuOptions.deleteOnComplete,
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text('Delete on complete'),
              Checkbox(
                value: isChecked,
                onChanged: null,
              )
            ],
          ),
        ),
      ],
    );
  }
}
