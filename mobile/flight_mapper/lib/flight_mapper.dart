import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'dart:async';

class FlightMapper extends StatefulWidget {
  const FlightMapper({super.key});

  @override
  State<StatefulWidget> createState() => _FlightMapperState();
}

class _FlightMapperState extends State<FlightMapper> {
  FlightData data = FlightData(
      image: const Image(image: AssetImage("assets/landscape.png")),
      duration: const Duration(minutes: 24),
      batteryLoss: 58.0);

  _handleImageTapUp(BuildContext context, TapDownDetails details) {}

  Future<Position> _getCurrentLocation() async {
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error("Location services are disabled.");
    }

    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await (Geolocator.requestPermission());
      if (permission == LocationPermission.denied) {
        return Future.error("Location permissions are denied");
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error("Location permissions are permanently denied");
    }

    var curPos = await Geolocator.getCurrentPosition();
    print(curPos);
    return curPos;
  }

  late GoogleMapController mapController;
  LatLng _center = const LatLng(45.521563, -122.677433);
  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  @override
  Widget build(BuildContext context) {
    final colorTheme = Theme.of(context).colorScheme;
    _getCurrentLocation().then((value) {
      setState(() {
        _center = LatLng(value.latitude, value.longitude);
      });
    });
    return Scaffold(
        body: Row(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Flexible(
          flex: 1,
          child: Container(
            color: colorTheme.background,
            width: double.infinity,
            child: Padding(
              padding: const EdgeInsets.only(left: 20, top: 30, right: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 5.0),
                    child: Text("Flight Mapper",
                        style: TextStyle(
                            fontSize: 25,
                            fontWeight: FontWeight.bold,
                            color: colorTheme.onPrimary)),
                  ),
                  RichText(
                      text: TextSpan(
                          text: "Est. Time: ",
                          style: TextStyle(
                              fontSize: 18,
                              color: colorTheme.onPrimary,
                              fontWeight: FontWeight.w500),
                          children: <TextSpan>[
                        TextSpan(
                            text:
                                "${data.duration.inMinutes.toString()} minutes",
                            style: TextStyle(color: colorTheme.primary))
                      ])),
                  RichText(
                      text: TextSpan(
                          text: "Est. Battery Loss: ",
                          style: TextStyle(
                              fontSize: 18,
                              color: colorTheme.onPrimary,
                              fontWeight: FontWeight.w500),
                          children: <TextSpan>[
                        TextSpan(
                            text: "${data.batteryLoss}%",
                            style: const TextStyle(color: Colors.red))
                      ])),
                  const Spacer(),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0.0, 20.0, 0.0, 20.0),
                    child: SizedBox(
                      width: double.infinity,
                      height: 70,
                      child: TextButton(
                        style: TextButton.styleFrom(
                            backgroundColor: colorTheme.primary,
                            foregroundColor: colorTheme.onPrimary,
                            shape: const RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(8)))),
                        onPressed: () {},
                        child: const Text(
                          "Launch Drone",
                          style: TextStyle(fontSize: 20),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        Flexible(
          flex: 3,
          child: Container(
              color: colorTheme.onBackground,
              width: double.infinity,
              height: double.infinity,
              child: () {
                return Center(
                  child: GoogleMap(
                    initialCameraPosition: CameraPosition(
                      target: _center,
                      zoom: 11.0,
                    ),
                    markers: {
                      Marker(
                          markerId: MarkerId("Cheese"),
                          position: _center,
                          infoWindow: InfoWindow(
                              title: "Portland", snippet: "Above a cool state"))
                    },
                  ),
                );
              }()),
        )
      ],
    ));
  }
}

class PathNode {
  double x;
  double y;
  PathNode? child;

  PathNode({required this.x, required this.y});
}

class FlightData {
  Image image;
  Duration duration;
  WeatherData? weather;
  double batteryLoss;

  void updateImage(Image image) {
    this.image = image;
  }

  FlightData(
      {required this.image,
      this.weather,
      required this.duration,
      required this.batteryLoss});
}

class WeatherData {
  double fahrenheit;
  WeatherType type;
  double windSpeed;
  WindDirection windDirection;

  WeatherData(
      {required this.fahrenheit,
      required this.type,
      required this.windSpeed,
      required this.windDirection});
}

// Add more of these
enum WeatherType { sunny, cloudy, rainy }

enum WindDirection {
  topLeft,
  topCenter,
  topRight,
  centerLeft,
  center,
  centerRight,
  bottomLeft,
  bottomCenter,
  bottomRight
}
