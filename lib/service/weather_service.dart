import 'dart:convert';
import 'dart:developer';

import 'package:flutter_first_app/config/constants.dart';
import 'package:flutter_first_app/models/weather_models.dart';
import 'package:http/http.dart' as http;

class WeatherService {
  static Future<WeatherModel> fetchWeatherData({required double lat, required double long}) async {
    try {
      final pathUrl = "$baseUrl/forecast?latitude=$lat&longitude=$long&current=temperature_2m,wind_speed_10m";

      final response = await http.get(Uri.parse(pathUrl));

      if (response.statusCode == 200 || response.statusCode == 201) {
        log(response.body);
        final WeatherModel data = WeatherModel.fromJson(jsonDecode(response.body));
        return data;
      } else {
        log("Error: failed to load weather data ${response.statusCode}");
        throw Exception("Error: Failed to load weather data (${response.statusCode})");
      }
    } catch (e) {
      log("Error: $e");
      throw Exception("Error : $e");
    }
  }
}
