import 'package:apiweather_app/view/widgets/app_text.dart';
import 'package:flutter/material.dart';

class WeatherStatTile extends StatelessWidget {
  const WeatherStatTile({
    super.key,
    required this.title,
    required this.value,
    required this.iconPath,
  });
  final String title;
  final String value;
  final String iconPath;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Image.asset(iconPath, height: 40),
        const SizedBox(width: 10),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AppText(
              data: title,
              color: Colors.white,
              size: 14,
              fw: FontWeight.w500,
            ),
            AppText(
              data: value,
              color: Colors.white,
              size: 16,
              fw: FontWeight.bold,
            ),
          ],
        ),
      ],
    );
  }
}
