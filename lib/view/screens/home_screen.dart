import 'package:apiweather_app/core/image_path.dart';
import 'package:apiweather_app/view/screens/forcast_screen.dart';
import 'package:apiweather_app/view/widgets/build_location_info.dart';
import 'package:apiweather_app/view/widgets/build_search_bar.dart';
import 'package:apiweather_app/view/widgets/build_temperature_info.dart';
import 'package:apiweather_app/view/widgets/build_weather_icon.dart';
import 'package:apiweather_app/view/widgets/build_weather_stats.dart';
import 'package:apiweather_app/viewmodel/providers/location_provider.dart';
import 'package:apiweather_app/viewmodel/providers/weather_provider.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TextEditingController _cityController = TextEditingController();

  @override
  void dispose() {
    _cityController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _initializeWeather();
  }

  Future<void> _initializeWeather() async {
    final locationProvider = Provider.of<LocationProvider>(
      context,
      listen: false,
    );
    await locationProvider.determinePosition();
    final city = locationProvider.currentLocationName?.locality;
    if (city != null) {
      Provider.of<WeatherProvider>(
        context,
        listen: false,
      ).fetchWeatherDataByCity(city);
      Provider.of<WeatherProvider>(
        context,
        listen: false,
      ).fetchForecastByCity(city);
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final weatherProvider = Provider.of<WeatherProvider>(context);
    final weatherData = weatherProvider.weatherData;

    final weatherMain = weatherData?.weather?.first.main ?? 'Clear';
    final backgroundImage = background[weatherMain] ?? 'assets/img/default.png';
    final weatherIcon = imagePath[weatherMain] ?? 'assets/img/default.png';

    final location = weatherData?.name ?? 'Unknown City';

    final temperature = weatherData?.main?.temp?.toStringAsFixed(0) ?? '--';
    final weatherCondition = weatherData?.weather?.first.description ?? '--';
    final sunrise = _formatTime(weatherData?.sys?.sunrise);
    final sunset = _formatTime(weatherData?.sys?.sunset);
    final tempMax = weatherData?.main?.tempMax?.toStringAsFixed(1) ?? '--';
    final tempMin = weatherData?.main?.tempMin?.toStringAsFixed(1) ?? '--';

    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.black,

      body: Container(
        height: size.height,
        width: size.width,
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(backgroundImage),
            fit: BoxFit.cover,
            colorFilter: const ColorFilter.mode(
              Colors.black54,
              BlendMode.darken,
            ),
          ),
        ),
        child: Stack(
          children: [
            BuildSearchBar(weatherProvider: weatherProvider),
            BuildLocationInfo(),
            if (weatherProvider.isLoading)
              const Center(
                child: CircularProgressIndicator(color: Colors.white),
              )
            else if (weatherProvider.error.isNotEmpty)
              Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(Icons.error, color: Colors.redAccent, size: 50),
                    const SizedBox(height: 10),
                    Text(
                      'Not find the weather data of the Place!',
                     // weatherProvider.error,
                      style: const TextStyle(color: Colors.white, fontSize: 18),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              )
            else if (weatherData == null)
              const Center(
                child: Text(
                  'No weather data available this City',
                  style: TextStyle(color: Colors.white, fontSize: 18),
                ),
              )
            else ...[
              BuildWeatherIcon(iconPath: weatherIcon),
              BuildTemperatureInfo(
                temperature: temperature,
                condition: weatherCondition,
                location: location,
              ),
              BuildWeatherStats(
                tempMax: tempMax,
                tempMin: tempMin,
                sunrise: sunrise,
                sunset: sunset,
              ),
              _forCastButton(context),
            ],
          ],
        ),
      ),
    );
  }

  Positioned _forCastButton(BuildContext context) {
  return Positioned(
    bottom: 15,
    left: 0,
    right: 0,
    child: Center(
      child: GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => const ForecastScreen()),
          );
        },
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
          decoration: BoxDecoration(
          color: Colors.black.withOpacity(0.4),
          borderRadius: BorderRadius.circular(24),
          border: Border.all(color: Colors.white30),
        ),
          child: const Text(
            'View 5-Day Forecast',
            style: TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.w400,
              letterSpacing: 0.5,
            ),
          ),
        ),
      ),
    ),
  );
}


  String _formatTime(int? timestamp) {
    if (timestamp == null) return '--';
    final utcTime = DateTime.fromMillisecondsSinceEpoch(
      timestamp * 1000,
      isUtc: true,
    );
    final istTime = utcTime.add(const Duration(hours: 5, minutes: 30));
    return DateFormat('hh:mm a').format(istTime);
  }
}
