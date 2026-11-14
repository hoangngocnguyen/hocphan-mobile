import 'package:flutter/material.dart';
import 'package:shop_easy/features/weather/widgets/weather_card.dart';

class WeatherScreen extends StatelessWidget {
  const WeatherScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final forecast = [
      {'label': 'T3', 'temp': 28, 'icon': Icons.wb_sunny_rounded, 'selected': true},
      {'label': 'T4', 'temp': 28, 'icon': Icons.wb_sunny_rounded, 'selected': false},
      {'label': 'T5', 'temp': 28, 'icon': Icons.wb_sunny_rounded, 'selected': false},
      {'label': 'T6', 'temp': 28, 'icon': Icons.wb_sunny_rounded, 'selected': false},
    ];

    return Scaffold(
      backgroundColor: const Color(0xFFF4F6FB),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(Icons.arrow_back_ios_new_rounded, color: Colors.black87),
        ),
        title: const Text(
          'Thời tiết',
          style: TextStyle(
            color: Colors.black87,
            fontWeight: FontWeight.w800,
            fontSize: 22,
          ),
        ),
      ),
      body: Center(
        child: WeatherCard(
          city: 'Thành phố Huế',
          date: '28/09',
          temperature: 32,
          isNight: false,
          forecast: forecast,
        ),
      ),
    );
  }
}
