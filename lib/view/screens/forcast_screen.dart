import 'package:apiweather_app/core/image_path.dart';
import 'package:apiweather_app/viewmodel/providers/weather_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';

class ForecastScreen extends StatelessWidget {
  const ForecastScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<WeatherProvider>(context);
    final forecast = provider.forecastData;

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        foregroundColor: Colors.white,
        centerTitle: true,
        title: const Text(
          "5-Day's Forecast List",
          style: TextStyle(color: Colors.white),
        ),
        elevation: 0,
        backgroundColor: Colors.black.withOpacity(0.4),
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(
              background[provider.weatherData?.weather?.first.main] ??
                  'assets/img/default.png',
            ),
            fit: BoxFit.cover,
            colorFilter: const ColorFilter.mode(
              Colors.black54,
              BlendMode.darken,
            ),
          ),
        ),
        child:
            provider.isLoading
                ? const Center(
                  child: CircularProgressIndicator(color: Colors.white),
                )
                : provider.error.isNotEmpty
                ? Center(
                  child: Text(
                    provider.error,
                    style: const TextStyle(color: Colors.white, fontSize: 16),
                    textAlign: TextAlign.center,
                  ),
                )
                : forecast == null
                ? const Center(
                  child: Text(
                    "No forecast data available",
                    style: TextStyle(color: Colors.white),
                  ),
                )
                : ListView.builder(
                  padding: const EdgeInsets.symmetric(
                    vertical: 10,
                    horizontal: 14,
                  ),
                  itemCount: forecast.list.length,
                  itemBuilder: (context, index) {
                    final item = forecast.list[index];
                    final date = DateFormat(
                      'EEE, MMM d • h:mm a',
                    ).format(DateTime.parse(item.dtTxt));
                    final main = item.weather[0].main;
                    final iconUrl = imagePath[main] ?? 'assets/img/default.png';

                    final temp = "${item.main.temp.toStringAsFixed(1)}°C";
                    final description = item.weather[0].description;

                    return Container(
                      margin: const EdgeInsets.symmetric(vertical: 6),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.05),
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(color: Colors.white12),
                      ),
                      child: ListTile(
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 8,
                        ),
                        leading: Image.asset(iconUrl, width: 48, height: 48),
                        title: Text(
                          date,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        subtitle: Text(
                          description,
                          style: const TextStyle(
                            color: Colors.white70,
                            fontSize: 13,
                          ),
                        ),
                        trailing: Text(
                          temp,
                          style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                      ),
                    );
                  },
                ),
      ),
    );
  }
}
