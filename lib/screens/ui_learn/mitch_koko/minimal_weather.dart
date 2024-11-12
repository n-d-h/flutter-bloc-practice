import 'package:bloc_learner/common/assets.dart';
import 'package:bloc_learner/models/weather_model.dart';
import 'package:bloc_learner/repositories/weather_service.dart';
import 'package:bloc_learner/utils/color_utils.dart';
import 'package:bloc_learner/utils/dark_mode_utils.dart';
import 'package:bloc_learner/widgets/custom_animations/loading/loading_box.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:lottie/lottie.dart';

class MinimalWeather extends StatefulWidget {
  const MinimalWeather({super.key});

  @override
  State<MinimalWeather> createState() => _MinimalWeatherState();
}

class _MinimalWeatherState extends State<MinimalWeather> {
  // api key
  final _weatherService = WeatherService(dotenv.env['WEATHER_API_KEY']!);
  Weather? _weather;

  // fetch weather data
  void _fetchWeatherByCity() async {
    String city = await _weatherService.getCurrentCity();
    try {
      debugPrint('city: $city');
      final weather = await _weatherService.getWeather(city);
      setState(() {
        _weather = weather;
      });
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  void _fetchWeatherByLatLong() async {
    var map = await _weatherService.getCurentLatLong();
    try {
      debugPrint('lat: ${map['lat']}, lon: ${map['lon']}');
      final weather = await _weatherService.getWeatherByLatLong(map);
      setState(() {
        _weather = weather;
      });
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  @override
  void initState() {
    _fetchWeatherByLatLong();
    super.initState();
  }

  String getWeatherIcon(String? condition) {
    condition ??= '';
    switch (condition.toLowerCase()) {
      case 'clouds':
      case 'mist':
      case 'smoke':
      case 'haze':
      case 'dust':
      case 'fog':
      case 'snow':
        return Assets.cloudJson;
      case 'rain':
      case 'drizzle':
      case 'shower rain':
        return Assets.rainJson;
      case 'thunderstorm':
        return Assets.thunderJson;
      case 'clear':
      default:
        if (DateTime.now().hour > 18 || DateTime.now().hour < 6) {
          return Assets.nightJson;
        }
        return Assets.sunnyJson;
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (_weather != null)
              SizedBox(
                height: size.height,
                child: Column(
                  children: [
                    SizedBox(height: size.height * 0.1),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 8),
                      child: Icon(
                        Icons.location_on,
                        size: 35,
                        color: Colors.grey[400],
                        shadows: [
                          BoxShadow(
                            color: DarkMode.getForegroundColor(context)
                                .withOpacity(0.2),
                            blurRadius: 2,
                            offset: const Offset(2, 3),
                          ),
                        ],
                      ),
                    ),
                    Text(
                      _weather?.cityName ?? 'locating...',
                      overflow: TextOverflow.clip,
                      style: const TextStyle(
                        fontSize: 33,
                        fontWeight: FontWeight.w500,
                        fontFamily: 'SF Pro Display',
                      ),
                    ),
                    const Spacer(),
                    Container(
                      margin: const EdgeInsets.symmetric(vertical: 16),
                      child: Lottie.asset(
                        getWeatherIcon(_weather?.mainCondition),
                        width: size.width * 0.6,
                      ),
                    ),
                    const Spacer(),
                    Text(
                      '${_weather?.temperature.round() ?? 0}°C',
                      style: const TextStyle(
                        fontSize: 60,
                        fontWeight: FontWeight.w500,
                        fontFamily: 'SF Pro Display',
                      ),
                    ),
                    Text(
                      _weather?.mainCondition ?? 'loading...',
                      style: TextStyle(
                        fontSize: 22,
                        color: Colors.grey[400],
                        fontWeight: FontWeight.w500,
                        fontFamily: 'SF Pro Display',
                      ),
                    ),
                    SizedBox(height: size.height * 0.1),
                  ],
                ),
              ),
            if (_weather == null) LoadingBox.waveDots(),
          ],
        ),
      ),
    );
  }
}
