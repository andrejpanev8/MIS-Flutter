import 'package:flutter/material.dart';
import 'package:lab2/data/services/api_service.dart';
import 'package:lab2/presentation/screens/favorites_screen.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';

import 'data/models/joke_model.dart';
import 'data/services/notification_service.dart';
import 'presentation/screens/home_joke_types_screen.dart';
import 'presentation/screens/jokes_screen.dart';
import 'presentation/widgets/custom_app_bar.dart';
import 'presentation/widgets/joke_details.dart';
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
        "/": (context) => AppStructure(),
        "/jokes": (context) => JokesScreen(),
        "/favorites": (context) => FavoritesScreen()
      },
    );
  }
}

class AppStructure extends StatefulWidget {
  AppStructure({super.key});
  final jokes = ApiService.getJokeTypesFromAPI();

  @override
  State<AppStructure> createState() => _AppStructureState();
}

class _AppStructureState extends State<AppStructure> {
  int currentPageIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(
        context: context,
        leadingButtonText: "Joke of the day",
        onTap: () {
          displayJokeDetails(context);
        },
      ),
      bottomNavigationBar: NavigationBar(
        onDestinationSelected: (index) {
          setState(() {
            currentPageIndex = index;
          });
        },
        destinations: [
          const NavigationDestination(
              icon: Icon(Icons.home), label: 'JokeTypes'),
          NavigationDestination(
              icon: Badge(
                child: const Icon(Icons.favorite),
              ),
              label: 'Favorites'),
        ],
        selectedIndex: currentPageIndex,
      ),
      body: [
        const HomeJokeTypes(),
        const FavoritesScreen(),
      ][currentPageIndex],
    );
  }
}

Future displayJokeDetails(BuildContext context) async {
  try {
    await context.read<JokesProvider>().fetchJokeOfTheDay();
    showJokeDetails(
        context, context.read<JokesProvider>().jokeOfTheDay as Joke);
  } catch (e) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("Error fetching joke of the day!")),
    );
  }
}
