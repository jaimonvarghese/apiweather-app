import 'package:apiweather_app/models/forcarst_model.dart';
import 'package:apiweather_app/models/weather_model.dart';
import 'package:apiweather_app/viewmodel/services/weather_service.dart';
import 'package:flutter/material.dart';

class WeatherProvider extends ChangeNotifier {
  final WeatherService _weatherServices = WeatherService();

  WeatherModel? _weatherData;
  ForecastModel? _forecastData;
  bool _isLoading = false;
  String _error = '';

  // Getters
  WeatherModel? get weatherData => _weatherData;
  ForecastModel? get forecastData => _forecastData;
  bool get isLoading => _isLoading;
  String get error => _error;

  void _setLoading(bool loading) {
    _isLoading = loading;
    notifyListeners();
  }

  void _setError(String error) {
    _error = error;
    notifyListeners();
  }

  // Fetch current weather data
  Future<void> fetchWeatherDataByCity(String city) async {
    _setLoading(true);
    _setError('');

    try {
      _weatherData = await _weatherServices.getWeatherDataByCity(city);
      notifyListeners();
    } catch (e) {
      _setError(e.toString());
    } finally {
      _setLoading(false);
    }
  }

  // Fetch forecast data
  Future<void> fetchForecastByCity(String city) async {
    _setLoading(true);
    _setError('');

    try {
      _forecastData = await _weatherServices.getForecastByCity(city);
      notifyListeners();
    } catch (e) {
      _setError(e.toString());
    } finally {
      _setLoading(false);
    }
  }
}
