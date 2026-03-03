// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'page_weather_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

WeatherModel _$WeatherModelFromJson(Map<String, dynamic> json) => WeatherModel(
      temperature: (json['temperature'] as num).toDouble(),
      cityName: json['cityName'] as String,
      description: json['description'] as String,
      humidity: (json['humidity'] as num).toInt(),
      windSpeed: (json['windSpeed'] as num).toDouble(),
    );

Map<String, dynamic> _$WeatherModelToJson(WeatherModel instance) =>
    <String, dynamic>{
      'temperature': instance.temperature,
      'cityName': instance.cityName,
      'description': instance.description,
      'humidity': instance.humidity,
      'windSpeed': instance.windSpeed,
    };
