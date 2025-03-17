import 'package:http/http.dart' as http;
import 'package:weather/components/api.dart';
import 'package:weather/model/wheather_model.dart';

class WeatherService {
  Future<WeatherModel> fetchWeather(double latitude, double longitude) async {
    final url = Uri.parse(
      '${Api.baseUrl}latitude=$latitude&longitude=$longitude&current_weather=true&hourly=temperature_2m,relativehumidity_2m,windspeed_10m',
    );

    // try {
      final response = await http.get(url);
      print("Response: ${response.body}");
      print("Error: ${response.statusCode}");

      if (response.statusCode == 200) {
        print("Response: ${response.body}");
        return weatherModelFromJson(response.body);
      } else {
        print("Error: ${response.statusCode}");
        throw Exception('Failed to load weather data');
      }
    // } catch (e) {
    //   print("Exception caught: $e");
    //   throw Exception('Network error');
    // }
  }
}
