import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:weather_task/data/weather.dart';
import 'package:weather_task/screens/weather_display_screen.dart';

class LoadingScreen extends StatefulWidget {
  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getCurrentLocation();
  }

  void getCurrentLocation() async {
    WeatherModel weatherModel = WeatherModel();
    var getWeatherData = await weatherModel.getLocationWeather();
    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return WeatherDisplay(
        weatherLocation: getWeatherData,
      );
    }));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green,
      body: Center(
        child: SpinKitFadingCube(
          color: Colors.white,
          size: 50.0,
        ),
      ),
    );
  }
}
