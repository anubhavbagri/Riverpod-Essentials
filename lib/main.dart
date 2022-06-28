import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:riverpod_essentials/async_value/services/fake_todo_repository.dart';
import 'package:riverpod_essentials/async_value/todo_async_page.dart';
import 'package:riverpod_essentials/async_value/todo_state.dart';
import 'package:riverpod_essentials/counter_app_three_ways/counter_page.dart';
import 'package:riverpod_essentials/reading_providers/todo_page.dart';

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
      // Overriding for testing
      overrides: [
        todoRepositoryProvider.overrideWithValue(FakeTodoRepository())
      ],
      child: MaterialApp(
        title: 'Flutter Riverpod',
        initialRoute: '/',
        debugShowCheckedModeBanner: false,
        routes: {
          '/': (context) => Home(),
        },
        theme: ThemeData(
          primarySwatch: Colors.blue,
          fontFamily: GoogleFonts.inter().fontFamily,
        ),
      ),
    );
  }
}

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: ListView(
          children: [
            DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Riverpod Essentials',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  FlutterLogo(
                    size: 50,
                  )
                ],
              ),
            ),
            ListTile(
              title: const Text(
                '1. Counter App',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const CounterPage(),
                  ),
                );
              },
            ),
            ListTile(
              title: const Text(
                '2. To-do App',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const TodoPage(),
                  ),
                );
              },
            ),
            ListTile(
              title: const Text(
                '3. Async Value Todo App',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const TodoAsyncPage(),
                  ),
                );
              },
            )
          ],
        ),
      ),
    );
  }
}
