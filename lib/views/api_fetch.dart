import 'package:flutter/material.dart';
import 'package:flutter_first_app/models/weather_models.dart';
import 'package:flutter_first_app/service/weather_service.dart';

class ApiFetchScreen extends StatefulWidget {
  const ApiFetchScreen({super.key});

  @override
  State<ApiFetchScreen> createState() => _ApiFetchScreenState();
}

class _ApiFetchScreenState extends State<ApiFetchScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Api Fetch"),
      ),
      body: Center(
        child: FutureBuilder<WeatherModel>(
          future: WeatherService.fetchWeatherData(lat: 45.33, long: 12.419998),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return CircularProgressIndicator();

              ///loading indicator
            } else if (snapshot.hasError) {
              return Text(snapshot.error.toString());
            } else if (snapshot.hasData) {
              final data = snapshot.data;

              final latitude = data?.latitude;
              final longitude = data?.longitude;
              final timezone = data?.timezone;
              final unit = data?.currentUnits?.temperature2M;
              final temperature = data?.current?.temperature2M;
              return ListTile(
                leading: CircleAvatar(
                  child: Text(
                    timezone ?? "",
                    style: TextStyle(fontSize: 12),
                  ),
                ),
                title: Text("${temperature.toString()} $unit"),
                subtitle: Text("Latitude: ${latitude.toString()} Longitude: ${longitude.toString()}"),
              );
            }
            return Text("No data available");
          },
        ),
      ),
    );
  }
}
