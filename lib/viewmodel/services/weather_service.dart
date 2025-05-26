import 'dart:convert';
import 'dart:developer';
import 'package:apiweather_app/core/api_constants.dart';
import 'package:apiweather_app/models/forcarst_model.dart';
import 'package:apiweather_app/models/weather_model.dart';
import 'package:http/http.dart' as http;

class WeatherService {
  final String baseUrl = ApiConstants.basuUrl;

  // Current weather
  Future<WeatherModel> getWeatherDataByCity(String city) async {
    final url = Uri.parse(
      '$baseUrl/weather?q=$city&appid=${ApiConstants.apiKey}${ApiConstants.unitEndpoint}',
    );

    final response = await http.get(url);

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      log("Current Weather Data: $data");
      return WeatherModel.fromJson(data);
    } else {
      throw Exception('Failed to load current weather data!');
    }
  }

  // Forecast weather
  Future<ForecastModel> getForecastByCity(String city) async {
    final url = Uri.parse(
      '$baseUrl/forecast?q=$city&appid=${ApiConstants.apiKey}${ApiConstants.unitEndpoint}',
    );

    final response = await http.get(url);

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      log("Forecast Weather Data: $data");
      return ForecastModel.fromJson(data);
    } else {
      throw Exception('Failed to load forecast data!');
    }
  }
}
