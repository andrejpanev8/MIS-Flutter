import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';

import 'data/services/notification_service.dart';
import 'presentation/screens/home_joke_types_screen.dart';
import 'presentation/screens/jokes_screen.dart';
import 'providers/jokes_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  final notificationService = NotificationService();
  await notificationService.initialize();

  runApp(
    MultiProvider(
      providers: [
        Provider(create: (_) => notificationService),
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
      title: 'Lab2xLab3',
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
