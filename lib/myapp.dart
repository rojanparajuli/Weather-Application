import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather/bloc/splash/splash_screen_bloc.dart';
import 'package:weather/bloc/splash/splash_screen_event.dart';
import 'package:weather/bloc/weather_bloc.dart';
import 'package:weather/screen/splash_screen.dart';
import 'package:weather/service/weather_service.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => WeatherBloc(WeatherService())),
        BlocProvider(
          create: (context) => SplashBloc()..add(CheckInternetEvent()),
        ),
      ],
      child: const MaterialApp(
        debugShowCheckedModeBanner: false,
        home: SplashScreen(),
      ),
    );
  }
}
