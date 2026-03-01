import 'package:dio/dio.dart';
import 'package:untitled/models/weather_model.dart';

class WeatherService {
  final Dio _dio = Dio();
  final String _apiKey = '57f02a136c29f2b7eeb1ddddb384b047'; // ← mets ta clé OpenWeather ici

  Future<WeatherModel> getWeather(String cityName) async {
    final response = await _dio.get(
      'https://api.openweathermap.org/data/2.5/weather',
      queryParameters: {
        'q': cityName,
        'appid': _apiKey,
        'units': 'metric',
      },
    );
    return WeatherModel(
      temperature: response.data['main']['temp'].toDouble(),
      cityName: cityName,
    );
  }
}