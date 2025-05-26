class ForecastModel {
  final List<ForecastItem> list;

  ForecastModel({required this.list});

  factory ForecastModel.fromJson(Map<String, dynamic> json) {
    return ForecastModel(
      list:
          (json['list'] as List)
              .map((item) => ForecastItem.fromJson(item))
              .toList(),
    );
  }
}

class ForecastItem {
  final MainData main;
  final List<WeatherData> weather;
  final String dtTxt;

  ForecastItem({
    required this.main,
    required this.weather,
    required this.dtTxt,
  });

  factory ForecastItem.fromJson(Map<String, dynamic> json) {
    return ForecastItem(
      main: MainData.fromJson(json['main']),
      weather:
          (json['weather'] as List)
              .map((w) => WeatherData.fromJson(w))
              .toList(),
      dtTxt: json['dt_txt'],
    );
  }
}

class MainData {
  final double temp;

  MainData({required this.temp});

  factory MainData.fromJson(Map<String, dynamic> json) {
    return MainData(temp: (json['temp'] as num).toDouble());
  }
}

class WeatherData {
  final String description;
  final String icon;
  final String main;

  WeatherData({
    required this.description,
    required this.icon,
    required this.main,
  });

  factory WeatherData.fromJson(Map<String, dynamic> json) {
    return WeatherData(
      description: json['description'],
      icon: json['icon'],
      main: json['main'],
    );
  }
}
