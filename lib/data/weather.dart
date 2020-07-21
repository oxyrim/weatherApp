import 'package:weather_task/data/location.dart';
import 'package:weather_task/data/networking.dart';

class WeatherModel {
  double latitude;
  double longitude;

  Future<dynamic> searchLocation(String locationName) async {
    Network url = Network(
        'https://api.openweathermap.org/data/2.5/weather?q=$locationName&appid=cebedba9bc31aaafbc85cb67a45d6f2b&units=metric');
    var getWeatherData = await url.getData();
    return getWeatherData;
  }

  Future<dynamic> getLocationWeather() async {
    Locations location = Locations();
    await location.getLocations();
    latitude = location.latitude;
    longitude = location.longitude;

    Network url = Network(
        'https://api.openweathermap.org/data/2.5/weather?lat=$latitude&lon=$longitude&appid=cebedba9bc31aaafbc85cb67a45d6f2b&units=metric');

    var getWeatherData = await url.getData();
    return getWeatherData;
  }

  String getWeatherIcon(int condition) {
    if (condition < 300) {
      return '🌩';
    } else if (condition < 400) {
      return '🌧';
    } else if (condition < 600) {
      return '☔️';
    } else if (condition < 700) {
      return '☃️';
    } else if (condition < 800) {
      return '🌫';
    } else if (condition == 800) {
      return '☀️';
    } else if (condition <= 804) {
      return '☁️';
    } else {
      return '🤷‍';
    }
  }

  String getMessage(int temperature) {
    if (temperature > 25) {
      return 'It\'s time for \n🏊 in';
    } else if (temperature > 20) {
      return 'Nice Weather \n😎 in';
    } else if (temperature < 10) {
      return 'You\'ll need \n🧦 and 🧤 in';
    } else {
      return 'wear 🧥';         //if the temperature is between 10 - 20
    }
  }
}
