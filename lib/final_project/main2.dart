
import 'package:flutter/material.dart';
import 'screens/home_screen.dart';

void main() {
  runApp(const EdemApp());
}

class EdemApp extends StatelessWidget {
  const EdemApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'EDEM Furniture',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        scaffoldBackgroundColor: const Color(0xFFFAF8F5),
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF77543C),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFF77543C),
            foregroundColor: Colors.white,
            padding: const EdgeInsets.symmetric(
              vertical: 15,
            ),
          ),
        ),
      ),
      builder: (context, child) {
        return Container(
          color: const Color(0xFFE8E2DB),
          alignment: Alignment.center,
          child: ConstrainedBox(
            constraints: const BoxConstraints(
              maxWidth: 460,
            ),
            child: child ?? const SizedBox(),
          ),
        );
      },
      home: const HomeScreen(),
    );
  }
}
