import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'presentation/screens/home_joke_types_screen.dart';
import 'presentation/screens/jokes_screen.dart';
import 'providers/jokes_provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => JokeTypesProvider()),
        ChangeNotifierProvider(create: (_) => JokesProvider()),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Lab2',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
            seedColor: const Color.fromARGB(255, 128, 196, 228)),
        useMaterial3: true,
      ),
      initialRoute: "/",
      routes: {
        "/": (context) => HomeJokeTypes(),
        "/jokes": (context) => JokesScreen()
      },
    );
  }
}
