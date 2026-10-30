import 'package:flutter/material.dart';
import 'screens/catalog_screen.dart';

void main() {
  runApp(const GlowBeautyApp());
}

class GlowBeautyApp extends StatelessWidget {
  const GlowBeautyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Glow Beauty',
      theme: ThemeData(
        useMaterial3: true,
        fontFamily: 'Roboto',
        scaffoldBackgroundColor: const Color(0xFFF8F5F1),
      ),
      home: const CatalogScreen(),
    );
  }
}