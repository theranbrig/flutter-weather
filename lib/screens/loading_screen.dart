import 'package:clima/screens/location_screen.dart';
import 'package:flutter/material.dart';
import 'package:clima/services/location.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:clima/services/networking.dart';

class LoadingScreen extends StatefulWidget {
  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

const apiKey = '2ce9c27bad816b51eb6943db06f0383f';

class _LoadingScreenState extends State<LoadingScreen> {
  void initState() {
    super.initState();
    getLocationData();
  }

  void getLocationData() async {
    Location location = Location();
    await location.getCurrentLocation();
    NetworkHelper networkHelper = NetworkHelper(
        'http://api.openweathermap.org/data/2.5/weather?lat=${location.latitude}&lon=${location.longitude}&appid=$apiKey&units=metric');
    var weatherData = await networkHelper.getData();
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) =>
                LocationScreen(locationWeather: weatherData)));
    print(weatherData);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: SpinKitDoubleBounce(color: Colors.white, size: 100)),
    );
  }
}
