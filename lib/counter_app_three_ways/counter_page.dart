import 'package:flutter/material.dart';
import 'package:riverpod_essentials/counter_app_three_ways/pages/counter_change_notifier_page.dart';
import 'package:riverpod_essentials/counter_app_three_ways/pages/counter_state_notifier_page.dart';
import 'package:riverpod_essentials/counter_app_three_ways/pages/counter_state_provider_page.dart';

class CounterPage extends StatelessWidget {
  const CounterPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Counter App'),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const CounterChangeNotifierPage(),
                  ),
                );
              },
              child: Text('Change Notifier'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const CounterStateNotifierPage(),
                  ),
                );
              },
              child: Text('State Notifier'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const CounterStateProviderPage(),
                  ),
                );
              },
              child: Text('State Provider'),
            ),
          ],
        ),
      ),
    );
  }
}
