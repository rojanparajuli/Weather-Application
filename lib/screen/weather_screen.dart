import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:weather/bloc/weather_bloc.dart';
import 'package:weather/bloc/weather_event.dart';
import 'package:weather/bloc/weather_state.dart';

class WeatherScreen extends StatefulWidget {
  const WeatherScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _WeatherScreenState createState() => _WeatherScreenState();
}

class _WeatherScreenState extends State<WeatherScreen> {
  @override
  void initState() {
    super.initState();
    BlocProvider.of<WeatherBloc>(context).add(FetchWeather());
  }

  String _getBackgroundImage({required bool isDay, required double windSpeed}) {
    if (!isDay) {
      if (windSpeed <= 10) return 'assets/night.gif';
      if (windSpeed <= 30) return 'assets/cloudy.gif';
      return 'assets/raining.gif';
    } else {
      if (windSpeed <= 10) return 'assets/sunny.gif';
      if (windSpeed <= 30) return 'assets/cloudy.gif';
      return 'assets/raining.gif';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: BlocBuilder<WeatherBloc, WeatherState>(
          builder: (context, state) {
            if (state is WeatherLoading) {
              return Center(
                child: SizedBox(
                  height: 200,
                  width: 200,
                  child: Lottie.asset('assets/loading.json'),
                ),
              );
            } else if (state is WeatherLoaded) {
              final weather = state.weather.currentWeather;
              final windSpeed = weather?.windspeed ?? 0;
              final isDay = weather?.isDay == 1;

              final backgroundImage =
                  _getBackgroundImage(isDay: isDay, windSpeed: windSpeed);

              return Scaffold(
                appBar: AppBar(
                  title: const Text('Weather App'),
                  backgroundColor: isDay ? Colors.white : Colors.black,
                  foregroundColor: isDay ? Colors.black : Colors.white,
                  centerTitle: true,
                ),
                body: Stack(
                  children: [
                    Opacity(
                      opacity: 0.4,
                      child: Container(
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage(backgroundImage),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                    SingleChildScrollView(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              color: Colors.white,
                            ),
                            child: Row(
                              children: [
                                const Icon(Icons.location_on ),
                                const SizedBox(width: 10,),
                                Text(
                                  state.locationName,
                                  style: const TextStyle(
                                    fontSize: 24,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 30),
                          const Text(
                            'Weather Details',
                            style: TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          const Divider(),
                          const Text(
                            'Current Weather',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                              'Temperature: ${weather?.temperature ?? 'N/A'}°C'),
                          Text(
                              'Windspeed: ${weather?.windspeed ?? 'N/A'} km/h'),
                          Text(
                              'Wind Direction: ${weather?.winddirection ?? 'N/A'}°'),
                          Text('Is Day: ${isDay ? 'Yes' : 'No'}'),
                          Text(
                              'Weather Code: ${weather?.weathercode ?? 'N/A'}'),
                          const Divider(),
                          // Display current weather units
                          if (state.weather.currentWeatherUnits != null) ...[
                            const Text(
                              'Current Weather Units',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            const SizedBox(height: 8),
                            Text(
                                'Temperature Unit: ${state.weather.currentWeatherUnits?.temperature ?? 'N/A'}'),
                            Text(
                                'Windspeed Unit: ${state.weather.currentWeatherUnits?.windspeed ?? 'N/A'}'),
                            Text(
                                'Wind Direction Unit: ${state.weather.currentWeatherUnits?.winddirection ?? 'N/A'}'),
                            Text(
                                'Is Day Unit: ${state.weather.currentWeatherUnits?.isDay ?? 'N/A'}'),
                            Text(
                                'Weather Code Unit: ${state.weather.currentWeatherUnits?.weathercode ?? 'N/A'}'),
                          ],
                          const Divider(),
                          // Display hourly data units
                          if (state.weather.hourlyUnits != null) ...[
                            const Text(
                              'Hourly Data Units',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            const SizedBox(height: 8),
                            Text(
                                'Time Unit: ${state.weather.hourlyUnits?.time ?? 'N/A'}'),
                            Text(
                                'Temperature 2m Unit: ${state.weather.hourlyUnits?.temperature2M ?? 'N/A'}'),
                            Text(
                                'Relative Humidity 2m Unit: ${state.weather.hourlyUnits?.relativehumidity2M ?? 'N/A'}'),
                            Text(
                                'Windspeed 10m Unit: ${state.weather.hourlyUnits?.windspeed10M ?? 'N/A'}'),
                          ],
                        ],
                      ),
                    ),
                  ],
                ),
              );
            } else if (state is WeatherError) {
              return Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      state.message,
                      style: const TextStyle(color: Colors.red, fontSize: 18),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: () => BlocProvider.of<WeatherBloc>(context)
                          .add(FetchWeather()),
                      child: const Text('Retry'),
                    ),
                  ],
                ),
              );
            }
            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }
}
