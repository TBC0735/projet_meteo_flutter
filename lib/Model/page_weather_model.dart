import 'package:json_annotation/json_annotation.dart';

part 'page_weather_model.g.dart';

@JsonSerializable()
class WeatherModel {
  final double temperature;
  final String cityName;
  final String description;
  final int humidity;
  final double windSpeed;

  WeatherModel({
    required this.temperature,
    required this.cityName,
    required this.description,
    required this.humidity,
    required this.windSpeed,
  });

  // ✅ fromJson adapté au format OpenWeatherMap
  factory WeatherModel.fromJson(Map<String, dynamic> json) {
    return WeatherModel(
      temperature: (json['main']['temp'] as num).toDouble(),
      cityName: json['name'] as String,
      description: json['weather'][0]['description'] as String,
      humidity: json['main']['humidity'] as int,
      windSpeed: (json['wind']['speed'] as num).toDouble(),
    );
  }

  Map<String, dynamic> toJson() => _$WeatherModelToJson(this);
}