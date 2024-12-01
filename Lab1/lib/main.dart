import 'package:flutter/material.dart';
import 'package:labs_project/presentation/screens/product_screen.dart';

import 'presentation/screens/garments_home_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Lab Exercise',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      initialRoute: "/",
      routes: {
        "/": (context) => GarmentsHomeScreen(),
        "/details": (context) => ProductScreen()
      },
    );
  }
}
