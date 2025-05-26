import 'package:apiweather_app/viewmodel/providers/weather_provider.dart';
import 'package:flutter/material.dart';

class BuildSearchBar extends StatelessWidget {
  const BuildSearchBar({super.key, required this.weatherProvider});
  final WeatherProvider weatherProvider;

  @override
  Widget build(BuildContext context) {
    TextEditingController _cityController = TextEditingController();
    return Positioned(
      top: 30,
      left: 0,
      right: 0,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.2),
          borderRadius: BorderRadius.circular(30),
        ),
        child: TextFormField(
          controller: _cityController,
          style: const TextStyle(color: Colors.white),
          decoration: InputDecoration(
            border: InputBorder.none,
            hintText: 'Search city...',
            hintStyle: TextStyle(color: Colors.white70),
            suffixIcon: IconButton(
              icon: Icon(Icons.search, color: Colors.white),
              onPressed: () {
                weatherProvider.fetchWeatherDataByCity(_cityController.text);
              },
            ),
            contentPadding: const EdgeInsets.symmetric(
              vertical: 12,
              horizontal: 16,
            ),
          ),
        ),
      ),
    );
  }
}
