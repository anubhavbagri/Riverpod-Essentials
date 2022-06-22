import 'package:flutter/foundation.dart';

class CounterChangeNotifier extends ChangeNotifier {
  // we can override the value because of the square brackets []
  CounterChangeNotifier([this.count = 0]);

  int count;

  void increment() {
    count++;
    notifyListeners(); // a function that is exposed by ChangeNotifier allowing _counterProvider to trigger an update every time the CounterChangeNotifier changes. Basically, everytime we call notifyListeners(), that will cause the _counterProvider to update & as a result, the entire build method would be called again since we ref.watch the _counterProvider
  }
}
