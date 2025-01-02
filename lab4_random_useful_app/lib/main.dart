import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'presentation/screens/home_screen.dart';
import 'presentation/widgets/custom_app_bar.dart';
import 'providers/event_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => EventProvider()),
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
      },
    );
  }
}

class AppStructure extends StatefulWidget {
  AppStructure({super.key});

  @override
  State<AppStructure> createState() => _AppStructureState();
}

class _AppStructureState extends State<AppStructure> {
  int currentPageIndex = 0;
  DateTime? selectedDate;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(
        context: context,
        appBarText: 'Random Useful App',
      ),
      body: [
        HomeScreen(),
      ][currentPageIndex],
    );
  }
}
