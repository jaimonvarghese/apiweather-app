import 'package:apiweather_app/view/widgets/app_text.dart';
import 'package:apiweather_app/viewmodel/providers/location_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BuildLocationInfo extends StatelessWidget {
  const BuildLocationInfo({super.key});

  String _getGreeting() {
    final hour = DateTime.now().hour;
    if (hour >= 5 && hour < 12) {
      return 'Good Morning';
    } else if (hour >= 12 && hour < 17) {
      return 'Good Afternoon';
    } else if (hour >= 17 && hour < 20) {
      return 'Good Evening';
    } else {
      return 'Good Night';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 100,
      left: 0,
      right: 0,
      child: Consumer<LocationProvider>(
        builder: (context, locationProvider, _) {
          final city =
              locationProvider.currentLocationName?.locality ?? 'Unknown City';
          return Row(
            children: [
              const Icon(Icons.location_on, color: Colors.red, size: 30),
              const SizedBox(width: 10),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AppText(
                    data: city,
                    color: Colors.white,
                    fw: FontWeight.bold,
                    size: 20,
                  ),
                  AppText(
                    data: _getGreeting(),
                    color: Colors.white70,
                    size: 16,
                  ),
                ],
              ),
            ],
          );
        },
      ),
    );
  }
}
