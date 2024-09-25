import 'package:flutter/material.dart';
import 'package:weather_application/ui/screens/home_screen.dart';
import 'package:weather_application/ui/screens/splash_screen.dart';

class WeatherApp extends StatelessWidget {
  const WeatherApp({super.key});

  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          appBarTheme: const AppBarTheme(
              backgroundColor: Colors.white24,
              foregroundColor: Colors.white
          )
      ),
      home: const SplashScreen(),
    );
  }
}
