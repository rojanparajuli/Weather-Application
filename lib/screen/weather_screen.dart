import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:weather/bloc/weather_bloc.dart';
import 'package:weather/bloc/weather_event.dart';
import 'package:weather/bloc/weather_state.dart';
import 'package:weather/components/greetings.dart';

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
                  child: Lottie.asset('assets/Animation - 1742210341196.json'),
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
                  title: Text('${getGreeting()}, User',
                      style: GoogleFonts.abel(fontSize: 20)),
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
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Icon(Icons.location_on, color: Colors.green),
                                const SizedBox(
                                  width: 10,
                                ),
                                Text(
                                  state.locationName,
                                  style: GoogleFonts.abel(
                                    fontSize: 24,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 30),
                          Text(
                            'Weather Details',
                            style: GoogleFonts.abel(
                              fontSize: 22,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          const Divider(),
                          Text(
                            'Current Weather',
                            style: GoogleFonts.abel(
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                              'Temperature: ${weather?.temperature ?? 'N/A'}°C',
                              style: GoogleFonts.abel(fontSize: 16)),
                          Text('Windspeed: ${weather?.windspeed ?? 'N/A'} km/h',
                              style: GoogleFonts.abel(fontSize: 16)),
                          Text(
                              'Wind Direction: ${weather?.winddirection ?? 'N/A'}°',
                              style: GoogleFonts.abel(fontSize: 16)),
                          Text('Is Day: ${isDay ? 'Yes' : 'No'}',
                              style: GoogleFonts.abel(fontSize: 16)),
                          Text('Weather Code: ${weather?.weathercode ?? 'N/A'}',
                              style: GoogleFonts.abel(fontSize: 16)),
                          const Divider(),
                          if (state.weather.currentWeatherUnits != null) ...[
                            Text(
                              'Current Weather Units',
                              style: GoogleFonts.abel(
                                fontSize: 18,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            const SizedBox(height: 8),
                            Text(
                                'Temperature Unit: ${state.weather.currentWeatherUnits?.temperature ?? 'N/A'}',
                                style: GoogleFonts.abel(fontSize: 16)),
                            Text(
                                'Windspeed Unit: ${state.weather.currentWeatherUnits?.windspeed ?? 'N/A'}',
                                style: GoogleFonts.abel(fontSize: 16)),
                            Text(
                                'Wind Direction Unit: ${state.weather.currentWeatherUnits?.winddirection ?? 'N/A'}',
                                style: GoogleFonts.abel(fontSize: 16)),
                            Text(
                                'Is Day Unit: ${state.weather.currentWeatherUnits?.isDay ?? 'N/A'}',
                                style: GoogleFonts.abel(fontSize: 16)),
                            Text(
                                'Weather Code Unit: ${state.weather.currentWeatherUnits?.weathercode ?? 'N/A'}',
                                style: GoogleFonts.abel(fontSize: 16)),
                          ],
                          const Divider(),
                          if (state.weather.hourlyUnits != null) ...[
                            Text(
                              'Hourly Data Units',
                              style: GoogleFonts.abel(
                                fontSize: 18,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            const SizedBox(height: 8),
                            Text(
                                'Time Unit: ${state.weather.hourlyUnits?.time ?? 'N/A'}',
                                style: GoogleFonts.abel(fontSize: 16)),
                            Text(
                                'Temperature 2m Unit: ${state.weather.hourlyUnits?.temperature2M ?? 'N/A'}',
                                style: GoogleFonts.abel(fontSize: 16)),
                            Text(
                                'Relative Humidity 2m Unit: ${state.weather.hourlyUnits?.relativehumidity2M ?? 'N/A'}',
                                style: GoogleFonts.abel(fontSize: 16)),
                            Text(
                                'Windspeed 10m Unit: ${state.weather.hourlyUnits?.windspeed10M ?? 'N/A'}',
                                style: GoogleFonts.abel(fontSize: 16)),
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
                      style: GoogleFonts.abel(color: Colors.red, fontSize: 18),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: () => BlocProvider.of<WeatherBloc>(context)
                          .add(FetchWeather()),
                      child:
                          Text('Retry', style: GoogleFonts.abel(fontSize: 18)),
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
