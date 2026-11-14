import 'package:flutter/material.dart';

class WeatherCard extends StatelessWidget {
  final String city;
  final String date;
  final int temperature;
  final bool isNight;
  final List<Map<String, dynamic>> forecast;

  const WeatherCard({
    super.key,
    required this.city,
    required this.date,
    required this.temperature,
    required this.isNight,
    required this.forecast,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 340,
      padding: const EdgeInsets.fromLTRB(20, 18, 20, 16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        gradient: const LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [Color(0xFF0B5ED7), Color(0xFF0B3F9D)],
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.blue.withValues(alpha: 0.25),
            blurRadius: 22,
            offset: const Offset(0, 18),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const SizedBox(width: 1),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    city,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Thứ Hai, $date',
                    style: const TextStyle(color: Colors.white70, fontSize: 12),
                  ),
                ],
              ),
              Icon(
                isNight ? Icons.nightlight_round : Icons.wb_sunny_rounded,
                color: Colors.white,
                size: 30,
              ),
            ],
          ),
          const SizedBox(height: 14),
          Align(
            alignment: Alignment.centerLeft,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  '$temperature°',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 70,
                    fontWeight: FontWeight.w700,
                    height: 1,
                  ),
                ),
                const SizedBox(width: 8),
                Transform.translate(
                  offset: const Offset(0, -14),
                  child: const Icon(
                    Icons.wb_sunny_rounded,
                    color: Colors.white,
                    size: 24,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Nắng nhẹ',
                style: TextStyle(color: Colors.white70, fontSize: 14),
              ),
              Text(
                'Cảm giác như ${temperature + 1}°',
                style: const TextStyle(color: Colors.white70, fontSize: 14),
              ),
            ],
          ),
          const SizedBox(height: 18),
          const Divider(color: Colors.white24, thickness: 1),
          const SizedBox(height: 10),

          // Dự báo 4 ngày
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: forecast.map((day) {
              final isSelected = day['selected'] as bool? ?? false;
              final IconData dayIcon =
                  day['icon'] as IconData? ?? Icons.wb_sunny_rounded;
              return Column(
                children: [
                  Text(
                    day['label'],
                    style: const TextStyle(color: Colors.white70, fontSize: 12),
                  ),
                  const SizedBox(height: 8),
                  Container(
                    width: 42,
                    height: 42,
                    decoration: BoxDecoration(
                      color: isSelected
                          ? Colors.white.withValues(alpha: 0.18)
                          : Colors.white.withValues(alpha: 0.08),
                      shape: BoxShape.circle,
                    ),
                    child: Center(
                      child: Center(
                        child: Icon(dayIcon, color: Colors.white, size: 20),
                      ),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    '${day['temp']}°',
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w700,
                      fontSize: 13,
                    ),
                  ),
                ],
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}
