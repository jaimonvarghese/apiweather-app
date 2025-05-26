import 'package:flutter/material.dart';

class BuildWeatherIcon extends StatelessWidget {
  const BuildWeatherIcon({super.key, required this.iconPath});
  final String iconPath;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: const Alignment(0, -0.5),
      child: Image.asset(iconPath, height: 120),
    );
  }
}