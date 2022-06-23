import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_essentials/pages/counter_change_notifier_page.dart';
import 'package:riverpod_essentials/pages/counter_state_notifier_page.dart';
import 'package:riverpod_essentials/pages/counter_state_provider_page.dart';

const changeNotifierRoute = 'changeNotifier';
const stateNotifierRoute = 'stateNotifier';
const stateProviderRoute = 'stateProvider';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    // ProviderScope is essentially a configuration widget for riverpod that just adds the providers to the scope of your application. It also allows us to create overrides & set observers.
    return ProviderScope(
      child: MaterialApp(
        title: 'Flutter Riverpod',
        initialRoute: '/',
        debugShowCheckedModeBanner: false,
        routes: {
          '/': (context) => Home(),
          changeNotifierRoute: (context) => CounterChangeNotifierPage(),
          stateNotifierRoute: (context) => CounterStateNotifierPage(),
          stateProviderRoute: (context) => CounterStateProviderPage(),
        },
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
      ),
    );
  }
}

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, changeNotifierRoute);
              },
              child: Text('Change Notifier'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, stateNotifierRoute);
              },
              child: Text('State Notifier'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, stateProviderRoute);
              },
              child: Text('State Provider'),
            ),
          ],
        ),
      ),
    );
  }
}
