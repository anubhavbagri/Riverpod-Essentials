import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_essentials/notifiers.dart';

final _counterProvider = ChangeNotifierProvider<CounterChangeNotifier>((ref) {
  return CounterChangeNotifier();
});

class CounterChangeNotifierPage extends ConsumerWidget {
  const CounterChangeNotifierPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final counter = ref.watch(_counterProvider);
    return Scaffold(
      appBar: AppBar(
        title: Text('Change Notifier Page'),
      ),
      body: Center(
        child: Text('Count : ${counter.count}'),
      ),
      floatingActionButton: myFloatingButton(),
    );
  }
}

class myFloatingButton extends ConsumerWidget {
  const myFloatingButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return FloatingActionButton(
      onPressed: () {
        ref.read(_counterProvider).increment();
        // counter.increment();
      },
      child: Icon(Icons.add),
    );
  }
}
