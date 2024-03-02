import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'flight_mapper.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.landscapeLeft])
      .then((_) {
    runApp(const MyApp());
  });
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flight Mapper',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
            seedColor: const Color(0xFF1B1B1B),
            background: const Color(0xFF1B1B1B)),
        useMaterial3: true,
      ),
      home: const FlightMapper(),
    );
  }
}
