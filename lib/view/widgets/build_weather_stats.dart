import 'package:apiweather_app/view/widgets/custom_divider.dart';
import 'package:apiweather_app/view/widgets/weather_stat_tile.dart';
import 'package:flutter/material.dart';

class BuildWeatherStats extends StatelessWidget {
  const BuildWeatherStats({
    super.key,
    required this.tempMax,
    required this.tempMin,
    required this.sunrise,
    required this.sunset,
  });

  final String tempMax;
  final String tempMin;
  final String sunrise;
  final String sunset;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: const Alignment(0, 0.75),
      child: Container(
        padding: const EdgeInsets.all(16),
        height: 190,
        decoration: BoxDecoration(
          color: Colors.black.withOpacity(0.4),
          borderRadius: BorderRadius.circular(24),
          border: Border.all(color: Colors.white30),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                WeatherStatTile(
                  title: 'Temp Max',
                  value: '$tempMax°C',
                  iconPath: 'assets/img/temperature-high.png',
                ),
                WeatherStatTile(
                  title: 'Temp Min',
                  value: '$tempMin°C',
                  iconPath: 'assets/img/temperature-low.png',
                ),
              ],
            ),
            CustomDivider(
              startIndent: 10,
              endIndent: 10,
              color: Colors.white30,
              thickness: 1.5,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                WeatherStatTile(
                  title: 'Sunrise',
                  value: sunrise,
                  iconPath: 'assets/img/sun.png',
                ),
                WeatherStatTile(
                  title: 'Sunset',
                  value: sunset,
                  iconPath: 'assets/img/moon.png',
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
