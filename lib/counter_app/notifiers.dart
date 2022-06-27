import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/*
The moment we try to manage more states, it becomes a lot more complicated to keep track of the different side effects in your aplication;
*/
class CounterChangeNotifier extends ChangeNotifier {
  // we can override the value because of the square brackets []
  CounterChangeNotifier([this.count = 0]);

  int count;

  void increment() {
    count++;
    notifyListeners(); // a function that is exposed by ChangeNotifier allowing _counterProvider to trigger an update every time the CounterChangeNotifier changes. Basically, everytime we call notifyListeners(), that will cause the _counterProvider to update & as a result, the entire build method would be called again since we ref.watch the _counterProvider
  }
}

class CounterStateNotifier extends StateNotifier<Counter> {
  CounterStateNotifier([Counter? counter]) : super(counter ?? Counter(0));

  void increment() {
    state = Counter(state.count + 1);
  }
}

class Counter {
  final int count;

  Counter(this.count);
}
