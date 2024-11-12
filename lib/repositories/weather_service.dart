import 'dart:convert';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';
import 'package:bloc_learner/models/weather_model.dart';
import 'package:http/http.dart' as http;

class WeatherService {
  static const BASE_URL = 'https://api.openweathermap.org/data/2.5/weather';
  final String apiKey;

  WeatherService(this.apiKey);

  Future<Weather> getWeatherByLatLong(Map map) async {
    final lat = map['lat'];
    final lon = map['lon'];
    final url = '$BASE_URL?lat=$lat&lon=$lon&appid=$apiKey&units=metric';
    final res = await http.get(Uri.parse(url));
    if (res.statusCode == 200) {
      return Weather.fromJson(jsonDecode(res.body));
    } else {
      throw Exception('Failed to load weather data');
    }
  }

  Future<Weather> getWeather(String city) async {
    final url = '$BASE_URL?q=$city&appid=$apiKey&units=metric';
    final res = await http.get(Uri.parse(url));
    if (res.statusCode == 200) {
      return Weather.fromJson(jsonDecode(res.body));
    } else {
      throw Exception('Failed to load weather data');
    }
  }

  Future<String> getCurrentCity() async {
    // get permission from user
    LocationPermission permission = await Geolocator.requestPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
    }

    // fetch the current location
    Position position = await Geolocator.getCurrentPosition(
        locationSettings:
            const LocationSettings(accuracy: LocationAccuracy.high));

    // convert the location into a list of placemarks objects
    List<Placemark> placemarks =
        await placemarkFromCoordinates(position.latitude, position.longitude);

    // extract the city name from the placemarks list
    return placemarks[0].locality ?? 'Unknown';
  }

  Future<Map<String, String>> getCurentLatLong() async {
    // get permission from user
    LocationPermission permission = await Geolocator.requestPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
    }

    // fetch the current location
    Position position = await Geolocator.getCurrentPosition(
        locationSettings:
            const LocationSettings(accuracy: LocationAccuracy.high));

    return {
      'lat': position.latitude.toString(),
      'lon': position.longitude.toString(),
    };
  }
}
