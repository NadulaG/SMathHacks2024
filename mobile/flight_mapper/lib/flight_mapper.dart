import 'package:flutter/material.dart';

class FlightMapper extends StatelessWidget {
  const FlightMapper({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Row(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Flexible(
          flex: 1,
          child: Container(
            // height: double.infinity,
            color: Theme.of(context).colorScheme.background,
          ),
        ),
        Flexible(
          flex: 2,
          child: Container(
              foregroundDecoration: const BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage("assets/landscape.png"),
                      fit: BoxFit.fill))),
        )
      ],
    ));
  }
}

class FlightData {
  String image;
  Duration duration;
  double batteryLoss;

  FlightData(
      {required this.image, required this.duration, required this.batteryLoss});
}
