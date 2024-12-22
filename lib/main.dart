import 'package:flutter/material.dart';
import 'package:my_app/screens/notes_home_page.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();  // Add this for database initialization
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'සටහන් පොත',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.green),
        useMaterial3: true,
      ),
      home: const NotesHomePage(),
    );
  }
}