import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';
import 'package:weather/service/weather_service.dart';
import 'weather_event.dart';
import 'weather_state.dart';

class WeatherBloc extends Bloc<WeatherEvent, WeatherState> {
  final WeatherService weatherService;

  WeatherBloc(this.weatherService) : super(WeatherInitial()) {
    on<FetchWeather>(_onFetchWeather);
  }

  Future<void> _onFetchWeather(FetchWeather event, Emitter<WeatherState> emit) async {
    emit(WeatherLoading());

    try {
      bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        emit(WeatherError("Location services are disabled."));
        return;
      }

      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          emit(WeatherError("Location permissions are denied."));
          return;
        }
      }

      if (permission == LocationPermission.deniedForever) {
        emit(WeatherError("Location permissions are permanently denied. Please enable them in settings."));
        return;
      }

      Position position = await Geolocator.getCurrentPosition(
        // ignore: deprecated_member_use
        desiredAccuracy: LocationAccuracy.high,
      );

      final weather = await weatherService.fetchWeather(
        position.latitude,
        position.longitude,
      );

      emit(WeatherLoaded(weather, locationName: await _fetchLocationName(position)));
    } catch (e) {
      emit(WeatherError("Could not fetch weather data: $e"));
    }
  }

Future<String> _fetchLocationName(Position position) async {
  try {
    List<Placemark> placemarks = await placemarkFromCoordinates(
        position.latitude, position.longitude);
    return placemarks.first.locality ?? "Unknown Location";
  } catch (e) {
    print("Error fetching location name: $e");
    return "Location unavailable";
  }
}

}
