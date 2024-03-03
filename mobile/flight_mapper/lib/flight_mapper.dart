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

  late GoogleMapController _mapController;
  late Future _centerFuture;
  LatLng _center = const LatLng(45.521563, -122.677433);

  @override
  void initState() {
    _centerFuture = _getCurrentLocation();
    super.initState();
  }

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
    setState(() {
      _center = LatLng(curPos.latitude, curPos.longitude);
    });
    return curPos;
  }

  void _onMapCreated(
      GoogleMapController controller, BuildContext buildContext) async {}

  @override
  Widget build(BuildContext context) {
    final colorTheme = Theme.of(context).colorScheme;
    _centerFuture = _getCurrentLocation();
    double screenWidth = MediaQuery.of(context).size.width *
        MediaQuery.of(context).devicePixelRatio;
    double screenHeight = MediaQuery.of(context).size.height *
        MediaQuery.of(context).devicePixelRatio;
    print("Screen dimensions: $screenWidth, $screenHeight");
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
        FutureBuilder(
            future: _centerFuture,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return Flexible(
                  flex: 3,
                  child: Container(
                      color: colorTheme.onBackground,
                      width: double.infinity,
                      height: double.infinity,
                      child: () {
                        return Center(
                          child: GoogleMap(
                            onMapCreated:
                                (GoogleMapController controller) async {
                              _mapController = controller;
                              double screenWidth =
                                  MediaQuery.of(context).size.width *
                                      MediaQuery.of(context).devicePixelRatio;
                              double screenHeight =
                                  MediaQuery.of(context).size.height *
                                      MediaQuery.of(context).devicePixelRatio;

                              print(
                                  "Screen dimensions: $screenWidth, $screenHeight");

                              ScreenCoordinate bottomRight = ScreenCoordinate(
                                  x: screenWidth.round() - 1,
                                  y: screenHeight.round() - 1);

                              LatLng bottomRightLatLng =
                                  await controller.getLatLng(bottomRight);

                              LatLng topLeftLatLng = await controller
                                  .getLatLng(ScreenCoordinate(x: 0, y: 0));
                              print(
                                  "Bottom right latitude: ${bottomRightLatLng.latitude}, ${bottomRightLatLng.longitude}");
                              print(
                                  "Top left latitude: ${topLeftLatLng.latitude}, ${topLeftLatLng.longitude}");
                            },
                            initialCameraPosition: CameraPosition(
                              target: _center,
                              zoom: 15.0,
                            ),
                            markers: {
                              Marker(
                                  markerId: MarkerId("marker1"),
                                  position: LatLng(
                                      35.756746599609976, -81.69471345841885),
                                  draggable: true,
                                  infoWindow: InfoWindow(
                                      title: "Coordinates",
                                      snippet:
                                          "${_center.latitude}, ${_center.longitude}")),
                              Marker(
                                  markerId: MarkerId("marker1"),
                                  position: LatLng(
                                      35.74325282002251, -81.65547676384449),
                                  draggable: true,
                                  infoWindow: InfoWindow(
                                      title: "Coordinates",
                                      snippet:
                                          "${_center.latitude}, ${_center.longitude}")),
                            },
                          ),
                        );
                      }()),
                );
              } else {
                return const Flexible(
                    flex: 3,
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Padding(
                            padding: EdgeInsets.only(bottom: 15.0),
                            child: Text(
                              "Loading Google Maps data...",
                              style:
                                  TextStyle(color: Colors.white, fontSize: 25),
                            ),
                          ),
                          CircularProgressIndicator(),
                        ],
                      ),
                    ));
              }
            })
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
