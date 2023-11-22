import 'package:weatherapp2/model/weather_data_current.dart';
import 'package:weatherapp2/model/weather_data_hourly.dart';

class WeatherData{

  final WeatherDataCurrent? current;
  final WeatherDataHourly? hourly;

  WeatherData([this.current, this.hourly]);

  WeatherDataCurrent getCurrentWeather() => current!;
  WeatherDataHourly getHourlytWeather() => hourly!;
}