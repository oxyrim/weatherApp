import 'package:flutter/material.dart';
import 'package:weather_task/data/weather.dart';
import 'package:weather_task/screens/search_screen.dart';

class WeatherDisplay extends StatefulWidget {
  WeatherDisplay({this.weatherLocation});
  final weatherLocation;

  @override
  _WeatherDisplayState createState() => _WeatherDisplayState();
}

class _WeatherDisplayState extends State<WeatherDisplay> {
  WeatherModel weather = WeatherModel();

  int temperature;
  String weatherIcon;
  String cityName;
  String description;
  int pressure;
  int humidity;
  double windSpeed;

  @override
  void initState() {
    super.initState();
    newUI(widget.weatherLocation);
  }

  void newUI(var weatherData) {
    setState(() {
      if (weatherData == null) {
        //if the weather data is not fetched
        temperature = 0;
        weatherIcon = 'Error';
        cityName = ' ';
        pressure = 0;
        humidity = 0;
        windSpeed = 0;
        description = 'Data not available';
        return;
      }
      double temp = weatherData['main']['temp'];
      temperature = temp.toInt();
      cityName = weatherData['name'];
      //description = weatherData['weather'][0]['description'];
      description = weather.getMessage(temperature);
      var condition = weatherData['weather'][0]['id'];
      weatherIcon = weather.getWeatherIcon(condition);
      print(condition);
      pressure = weatherData['main']['pressure'];
      humidity = weatherData['main']['humidity'];
      windSpeed = weatherData['wind']['speed'];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('images/displayBg.JPG'),
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(
                Colors.white.withOpacity(0.8), BlendMode.dstATop),
          ),
        ),
        constraints: BoxConstraints.expand(),
        child: SafeArea(
          child: Column(
            //mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //crossAxisAlignment: CrossAxisAlignment.end,
                children: <Widget>[
                  FlatButton(
                    onPressed: () async {
                      //requesting for new weather information with new location
                      var weatherData = await weather.getLocationWeather();
                      //update information shown on screen
                      newUI(weatherData);
                    },
                    child: Icon(
                      Icons.near_me,
                      size: 50.0,
                    ),
                  ),
                  FlatButton(
                    onPressed: () async {
                      var locationSearch = await Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) {
                            return SearchLocation();
                          },
                        ),
                      );
                      print(locationSearch);
                      if (locationSearch != null) {
                        var weatherData =
                            await weather.searchLocation(locationSearch);
                        newUI(weatherData);
                      }
                    },
                    child: Icon(
                      Icons.location_city,
                      size: 50.0,
                    ),
                  ),
                ],
              ),
              Padding(
                padding: EdgeInsets.only(top: 80.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      '$temperature°',
                      style: TextStyle(
                        //fontFamily: 'Pacifico',
                        fontSize: 60.0,
                      ),
                    ),
                    Text(
                      weatherIcon,
                      style: TextStyle(
                        fontSize: 60.0,
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(right: 15.0),
                child: Center(
                  child: Text(
                    '$description \n$cityName!',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      //fontFamily: 'Pacifico',
                      fontSize: 30.0,
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 30.0),
                child: Container(
                  height: 20.0,
                  color: Colors.white,
                ),
              ),
              Container(
                decoration: new BoxDecoration(
                  color: Colors.red,
                ),
                child: ListTile(
                  leading: Icon(
                    Icons.local_parking,
                  ),
                  title: Text('$pressure'),
                  subtitle: Text('Pressure'),
                ),
              ),
              Container(
                decoration: new BoxDecoration(
                  color: Colors.amber,
                ),
                child: ListTile(
                  leading: Icon(
                    Icons.wb_cloudy,
                  ),
                  title: Text('$humidity'),
                  subtitle: Text('Humidity'),
                ),
              ),
              Container(
                decoration: new BoxDecoration(color: Colors.teal),
                child: ListTile(
                  leading: Icon(
                    Icons.view_headline,
                  ),
                  title: Text('$windSpeed'),
                  subtitle: Text('Wind Speed'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
