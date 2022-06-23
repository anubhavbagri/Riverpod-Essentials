import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final _counterProvider = StateProvider<int>((ref) => 0);

final _isEvenProvider = Provider<bool>((ref) {
  final counter = ref.watch(_counterProvider);
  return (counter % 2 == 0);
});

final _evenCounter = Provider<int>((ref) {
  ref.listen<bool>(_isEvenProvider, (value, val) {
    if (val) {
      ref.state++;
    }
  });
  return 0;
});

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
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Count: ${counter}'),
            CounterIsEven(),
            EvenCounter(),
          ],
        ),
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

class CounterIsEven extends ConsumerWidget {
  const CounterIsEven({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // print('Building');
    final isEven = ref.watch(_isEvenProvider);
    return Text(isEven ? 'Is Even' : 'Not even');
  }
}

class EvenCounter extends ConsumerWidget {
  const EvenCounter({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final evenCount = ref.watch(_evenCounter);
    return Text('$evenCount');
  }
}
