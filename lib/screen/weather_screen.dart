import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather/bloc/weather_bloc.dart';
import 'package:weather/bloc/weather_event.dart';
import 'package:weather/bloc/weather_state.dart';


class WeatherScreen extends StatefulWidget {
  const WeatherScreen({super.key});

  @override
  _WeatherScreenState createState() => _WeatherScreenState();
}

class _WeatherScreenState extends State<WeatherScreen> {
  @override
  void initState() {
    super.initState();
    BlocProvider.of<WeatherBloc>(context).add(FetchWeather());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Weather'),
      ),
      body: Center(
        child: BlocBuilder<WeatherBloc, WeatherState>(
          builder: (context, state) {
            if (state is WeatherLoading) {
              return const CircularProgressIndicator();
            } else if (state is WeatherLoaded) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Temperature: ${state.weather.currentWeather?.temperature}°C'),
                  Text('Windspeed: ${state.weather.currentWeather?.windspeed} km/h'),
                  Text('Humidity: ${state.weather.hourly?.relativehumidity2M?.first}%'),
                ],
              );
            } else if (state is WeatherError) {
              return Text(state.message);
            }
            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }
}
