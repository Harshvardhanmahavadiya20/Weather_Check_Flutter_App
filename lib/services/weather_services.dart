// ignore_for_file: constant_identifier_names

import 'dart:convert';

import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import 'package:weatherapp/pages/weather_model.dart';

class WeatherServices {
  static const String BASE_URL =
      'http://api.openweathermap.org/data/2.5/weather';
  final String apiKey;

  WeatherServices(this.apiKey);

  Future<Weather> getWeather(String cityName) async {
    final Uri uri =
        Uri.parse('$BASE_URL?q=$cityName&appid=$apiKey&units=metric');
    final http.Response response = await http.get(uri);

    if (response.statusCode == 200) {
      return Weather.fromJson(
          jsonDecode(response.body)); // Corrected method name to fromJson
    } else {
      throw Exception('Failed to load weather data');
    }
  }

  Future<String> getCurrentCity() async {
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
    }

    // Fetch the current location
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);

    // Convert location into a list of placemark objects
    List<Placemark> placemarks =
        await placemarkFromCoordinates(position.latitude, position.longitude);

    // Extract the city name from the first placemark
    String? city = placemarks.isNotEmpty ? placemarks[0].locality : null;
    return city ?? ""; // Returning an empty string if city is null
  }
}
