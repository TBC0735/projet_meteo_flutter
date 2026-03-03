import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import '../Model/page_weather_model.dart';

part 'page_weather_service.g.dart';

@RestApi(baseUrl: 'https://api.openweathermap.org/data/2.5/')
abstract class WeatherService {
  factory WeatherService(Dio dio, {String baseUrl}) = _WeatherService;

  @GET('weather')
  Future<WeatherModel> getWeather(
      @Query('q') String cityName,
      @Query('appid') String apiKey,
      @Query('units') String units,
      @Query('lang') String lang,
      );
}