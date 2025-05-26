import 'package:apiweather_app/view/screens/home_screen.dart';
import 'package:apiweather_app/viewmodel/providers/location_provider.dart';
import 'package:apiweather_app/viewmodel/providers/weather_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => LocationProvider()),
        ChangeNotifierProvider(create: (_) => WeatherProvider()),
      ],
      child: MaterialApp(home: HomePage(), debugShowCheckedModeBanner: false),
    );
  }
}
