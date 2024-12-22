import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'screens/notes_home_page.dart';
import 'providers/app_settings_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  runApp(
    ChangeNotifierProvider(
      create: (_) => AppSettingsProvider(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<AppSettingsProvider>(
      builder: (context, settings, _) {
        return MaterialApp(
          title: settings.localizations.get('appName'),
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.green),
            useMaterial3: true,
          ),
          darkTheme: ThemeData.dark(useMaterial3: true),
          themeMode: settings.isDarkMode ? ThemeMode.dark : ThemeMode.light,
          home: const NotesHomePage(),
        );
      },
    );
  }
}