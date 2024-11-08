
import 'package:weather/model/wheather_model.dart';

abstract class WeatherState {}

class WeatherInitial extends WeatherState {}

class WeatherLoading extends WeatherState {}

class WeatherLoaded extends WeatherState {
  final WeatherModel weather;
  final String locationName;

  WeatherLoaded(this.weather, {required this.locationName});
}


class WeatherError extends WeatherState {
  final String message;
  WeatherError(this.message);
}
