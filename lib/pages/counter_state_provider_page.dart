import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final _counterProvider = StateProvider<int>((ref) => 0);

class CounterStateProviderPage extends ConsumerWidget {
  const CounterStateProviderPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final counter = ref.watch(_counterProvider);
    return Scaffold(
      appBar: AppBar(
        title: Text('State Provider Page'),
      ),
      body: Center(
        child: Text('Count: ${counter}'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          ref.read(_counterProvider.notifier).state++;
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
