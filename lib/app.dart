import 'package:coinglance/features/rates/rates_screen.dart';
import 'package:flutter/material.dart';

class CoinGlanceApp extends StatelessWidget {
  const CoinGlanceApp({super.key});

  @override
  Widget build(BuildContext context) {
    const seed = Color(0xFF6366F1);
    return MaterialApp(
      title: 'CoinGlance',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        brightness: Brightness.dark,
        colorScheme: ColorScheme.fromSeed(
          seedColor: seed,
          brightness: Brightness.dark,
        ),
        scaffoldBackgroundColor: const Color(0xFF0B0F14),
        appBarTheme: const AppBarTheme(
          centerTitle: false,
          elevation: 0,
          scrolledUnderElevation: 0,
        ),
      ),
      home: const RatesScreen(),
    );
  }
}
