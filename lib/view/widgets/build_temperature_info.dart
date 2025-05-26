import 'package:apiweather_app/view/widgets/app_text.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class BuildTemperatureInfo extends StatelessWidget {
  const BuildTemperatureInfo({super.key, required this.temperature, required this.condition, required this.location});
  final String temperature;
  final String condition;
  final String location;

  String _capitalize(String text) {
    if (text.isEmpty) return text;
    return "${text[0].toUpperCase()}${text.substring(1)}";
  }

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: const Alignment(0, 0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          AppText(
            data: "$temperature °C",
            color: Colors.white,
            fw: FontWeight.bold,
            size: 52,
          ),
          const SizedBox(height: 5),
          AppText(
            data: location,
            color: Colors.white,
            fw: FontWeight.bold,
            size: 30,
          ),
          const SizedBox(height: 5),
          AppText(
            data: _capitalize(condition),
            color: Colors.white70,
            fw: FontWeight.w600,
            size: 20,
          ),
          const SizedBox(height: 5),
          AppText(
            data: DateFormat('hh:mm a').format(DateTime.now()),
            color: Colors.white60,
            size: 16,
          ),
        ],
      ),
    );
  }
}
