import 'package:flutter/material.dart';
import 'browser_shell.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const NeonRetroApp());
}

class NeonRetroApp extends StatelessWidget {
  const NeonRetroApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Neon Retro',
      theme: ThemeData.dark(useMaterial3: true).copyWith(
        scaffoldBackgroundColor: const Color(0xFF05040A),
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFFFF40C6),
          brightness: Brightness.dark,
        ),
      ),
      home: const BrowserShell(),
    );
  }
}
