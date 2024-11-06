import 'dart:convert';

WeatherModel weatherModelFromJson(String str) =>
    WeatherModel.fromJson(json.decode(str));

String weatherModelToJson(WeatherModel data) => json.encode(data.toJson());

class WeatherModel {
  double? latitude;
  double? longitude;
  double? generationtimeMs;
  int? utcOffsetSeconds;
  String? timezone;
  String? timezoneAbbreviation;
  double? elevation;
  CurrentWeatherUnits? currentWeatherUnits;
  CurrentWeather? currentWeather;
  HourlyUnits? hourlyUnits;
  Hourly? hourly;

  WeatherModel({
    this.latitude,
    this.longitude,
    this.generationtimeMs,
    this.utcOffsetSeconds,
    this.timezone,
    this.timezoneAbbreviation,
    this.elevation,
    this.currentWeatherUnits,
    this.currentWeather,
    this.hourlyUnits,
    this.hourly,
  });

  factory WeatherModel.fromJson(Map<String, dynamic> json) => WeatherModel(
        latitude: json["latitude"],
        longitude: json["longitude"],
        generationtimeMs: json["generationtime_ms"],
        utcOffsetSeconds: json["utc_offset_seconds"],
        timezone: json["timezone"],
        timezoneAbbreviation: json["timezone_abbreviation"],
        elevation: json["elevation"],
        currentWeatherUnits:
            CurrentWeatherUnits.fromJson(json["current_weather_units"]),
        currentWeather: CurrentWeather.fromJson(json["current_weather"]),
        hourlyUnits: HourlyUnits.fromJson(json["hourly_units"]),
        hourly: Hourly.fromJson(json["hourly"]),
      );

  Map<String, dynamic> toJson() => {
        "latitude": latitude,
        "longitude": longitude,
        "generationtime_ms": generationtimeMs,
        "utc_offset_seconds": utcOffsetSeconds,
        "timezone": timezone,
        "timezone_abbreviation": timezoneAbbreviation,
        "elevation": elevation,
        "current_weather_units": currentWeatherUnits?.toJson(),
        "current_weather": currentWeather?.toJson(),
        "hourly_units": hourlyUnits?.toJson(),
        "hourly": hourly?.toJson(),
      };
}

class CurrentWeather {
  String? time;
  int? interval;
  double? temperature;
  double? windspeed;
  int? winddirection;
  int? isDay;
  int? weathercode;

  CurrentWeather({
    this.time,
    this.interval,
    this.temperature,
    this.windspeed,
    this.winddirection,
    this.isDay,
    this.weathercode,
  });

  factory CurrentWeather.fromJson(Map<String, dynamic> json) => CurrentWeather(
        time: json["time"],
        interval: json["interval"],
        temperature: json["temperature"].toDouble(),
        windspeed: json["windspeed"].toDouble(),
        winddirection: json["winddirection"],
        isDay: json["is_day"],
        weathercode: json["weathercode"],
      );

  Map<String, dynamic> toJson() => {
        "time": time,
        "interval": interval,
        "temperature": temperature,
        "windspeed": windspeed,
        "winddirection": winddirection,
        "is_day": isDay,
        "weathercode": weathercode,
      };
}

class CurrentWeatherUnits {
  String? time;
  String? interval;
  String? temperature;
  String? windspeed;
  String? winddirection;
  String? isDay;
  String? weathercode;

  CurrentWeatherUnits({
    this.time,
    this.interval,
    this.temperature,
    this.windspeed,
    this.winddirection,
    this.isDay,
    this.weathercode,
  });

  factory CurrentWeatherUnits.fromJson(Map<String, dynamic> json) =>
      CurrentWeatherUnits(
        time: json["time"],
        interval: json["interval"],
        temperature: json["temperature"],
        windspeed: json["windspeed"],
        winddirection: json["winddirection"],
        isDay: json["is_day"],
        weathercode: json["weathercode"],
      );

  Map<String, dynamic> toJson() => {
        "time": time,
        "interval": interval,
        "temperature": temperature,
        "windspeed": windspeed,
        "winddirection": winddirection,
        "is_day": isDay,
        "weathercode": weathercode,
      };
}

class Hourly {
  List<String>? time;
  List<double>? temperature2M;
  List<int>? relativehumidity2M;
  List<double>? windspeed10M;

  Hourly({
    this.time,
    this.temperature2M,
    this.relativehumidity2M,
    this.windspeed10M,
  });

  factory Hourly.fromJson(Map<String, dynamic> json) => Hourly(
        time: List<String>.from(json["time"].map((x) => x)),
        temperature2M:
            List<double>.from(json["temperature_2m"].map((x) => x.toDouble())),
        relativehumidity2M:
            List<int>.from(json["relativehumidity_2m"].map((x) => x)),
        windspeed10M:
            List<double>.from(json["windspeed_10m"].map((x) => x.toDouble())),
      );

  Map<String, dynamic> toJson() => {
        "time": List<dynamic>.from(time!.map((x) => x)),
        "temperature_2m": List<dynamic>.from(temperature2M!.map((x) => x)),
        "relativehumidity_2m":
            List<dynamic>.from(relativehumidity2M!.map((x) => x)),
        "windspeed_10m": List<dynamic>.from(windspeed10M!.map((x) => x)),
      };
}

class HourlyUnits {
  String? time;
  String? temperature2M;
  String? relativehumidity2M;
  String? windspeed10M;

  HourlyUnits({
    this.time,
    this.temperature2M,
    this.relativehumidity2M,
    this.windspeed10M,
  });

  factory HourlyUnits.fromJson(Map<String, dynamic> json) => HourlyUnits(
        time: json["time"],
        temperature2M: json["temperature_2m"],
        relativehumidity2M: json["relativehumidity_2m"],
        windspeed10M: json["windspeed_10m"],
      );

  Map<String, dynamic> toJson() => {
        "time": time,
        "temperature_2m": temperature2M,
        "relativehumidity_2m": relativehumidity2M,
        "windspeed_10m": windspeed10M,
      };
}
