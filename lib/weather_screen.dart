import 'dart:convert';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:weather_app/hourly_forcast_item.dart';
import 'package:weather_app/secrets.dart';
import 'additional_info_item.dart';
import 'package:http/http.dart' as http;

class WeatherScreen extends StatefulWidget {
  const WeatherScreen({super.key});

  @override
  State<WeatherScreen> createState() => _WeatherScreenState();
}

class _WeatherScreenState extends State<WeatherScreen> {
  @override
  void initState() {
    super.initState();
    getCurrencyWeather();
  }

  Future getCurrencyWeather() async {
    try {
      String cityName = 'London';
      final res = await http.get(
        Uri.parse(
          'https://api.openweathermap.org/data/2.5/forecast?q=$cityName,uk&APPID=$openWeatherApiKey',
        ),
      );
      final data = jsonDecode(res.body);

      if (data['cod'] != '200') {
        throw 'An unexpected error';
      }

      print(data['list'][0]['main']['temp']);
    } catch (e) {
      throw e.toString();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Weather App',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.refresh),
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // main Card
            SizedBox(
              width: double.infinity,
              child: Card(
                elevation: 10,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(16),
                  child: BackdropFilter(
                    filter: ImageFilter.blur(
                      sigmaX: 10,
                      sigmaY: 10,
                    ),
                    child: const Padding(
                      padding: EdgeInsets.all(16),
                      child: Column(
                        children: [
                          Text(
                            '300°F',
                            style: TextStyle(
                              fontSize: 32,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 16),
                          Icon(
                            Icons.cloud,
                            size: 64,
                          ),
                          SizedBox(height: 16),
                          Text(
                            'Rain',
                            style: TextStyle(
                              fontSize: 20,
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              'Weather Forecast',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            const SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  HourlyForcastItem(
                    time: '03:00',
                    temp: '300.12',
                    icon: Icons.cloud,
                  ),
                  HourlyForcastItem(
                    time: '06:00',
                    temp: '330.12',
                    icon: Icons.sunny,
                  ),
                  HourlyForcastItem(
                    time: '09:00',
                    temp: '300.12',
                    icon: Icons.cloud,
                  ),
                  HourlyForcastItem(
                    time: '12:00',
                    temp: '350.00',
                    icon: Icons.sunny,
                  ),
                  HourlyForcastItem(
                    time: '03:00',
                    temp: '290.00',
                    icon: Icons.cloud,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              'Additional Information',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            const Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                AdditionalInfoItem(
                  icon: Icons.water_drop,
                  label: 'Humidity',
                  value: '91',
                ),
                AdditionalInfoItem(
                  icon: Icons.air,
                  label: 'Windspeed',
                  value: '7.5',
                ),
                AdditionalInfoItem(
                  icon: Icons.timer,
                  label: 'Pressure',
                  value: '1000',
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
