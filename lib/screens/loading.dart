import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:helloworld/data/my_location.dart';
import 'package:helloworld/data/network.dart';
import 'package:helloworld/screens/weather_screen.dart';

const apiKey = 'afcfe5483027dead8702ed9adc18a789';

class Loading extends StatefulWidget {
  @override
  _LoadingState createState() => _LoadingState();
}

class _LoadingState extends State<Loading> {
  double? latitude3;
  double? longitude3;

  @override
  void initState() {
    super.initState();
    getLocation();
  }

  void getLocation() async {
    MyLocation myLocation = MyLocation();
    await myLocation.getMyCurrentLocation();
    latitude3 = myLocation.latitude2;
    longitude3 = myLocation.longitude2;
    print(latitude3);
    print(longitude3);

    // https: //api.openweathermap.org/data/2.5/weather?lat={lat}&lon={lon}&appid={API key}

    Network network = Network(
        'https://api.openweathermap.org/data/2.5/weather?lat=$latitude3&lon=$longitude3&appid=$apiKey&units=metric',
        'https://api.openweathermap.org/data/2.5/air_pollution?lat=$latitude3&lon=$longitude3&appid=$apiKey');
    // 'http://api.openweathermap.org/data/2.5/temperature?lat={$latitude3}&lon={$longitude3}&appid={$apiKey}');
    // Network('api.openweathermap.org', '/data/2.5/weather', params);

    var weatherData = await network.getJsonData();
    print(weatherData);

    var airData = await network.getAirData();
    print(airData);

    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => WeatherScreen(
                parseWeatherData: weatherData, parseAirPollution: airData)));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.amber,
        body: Center(
          child: SpinKitDoubleBounce(
            color: Colors.white,
            size: 80.0,
          ),
        ));
  }
}
