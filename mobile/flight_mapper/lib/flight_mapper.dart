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

  late Future _centerFuture;
  LatLng _center = const LatLng(45.521563, -122.677433); // Default position
  final Region region = Region();
  bool droneLaunched = false;

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
    region.updateControlPoint1(_center);
    region.updateControlPoint2(
        LatLng(_center.latitude - 0.01, _center.longitude + 0.01));
    return curPos;
  }

  @override
  Widget build(BuildContext context) {
    final colorTheme = Theme.of(context).colorScheme;
    _centerFuture = _getCurrentLocation();
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
                              backgroundColor: () {
                                if (!droneLaunched) {
                                  return colorTheme.primary;
                                } else {
                                  return Colors.red;
                                }
                              }(),
                              foregroundColor: colorTheme.onPrimary,
                              shape: const RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(8)))),
                          onPressed: () {
                            setState(() {
                              droneLaunched = true;
                            });
                          },
                          child: () {
                            if (!droneLaunched) {
                              return const Text(
                                "Launch Drone",
                                style: TextStyle(fontSize: 20),
                              );
                            } else {
                              return const Text(
                                "Drone Launched",
                                style: TextStyle(fontSize: 20),
                              );
                            }
                          }()),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        PathPreview(
            centerFuture: _centerFuture, cameraFocus: _center, region: region),
      ],
    ));
  }
}

class PathPreview extends StatefulWidget {
  Future centerFuture;
  LatLng cameraFocus;
  Region region;

  PathPreview(
      {super.key,
      required this.centerFuture,
      required this.cameraFocus,
      required this.region});

  @override
  createState() => _PathPreviewState();
}

class _PathPreviewState extends State<PathPreview> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: widget.centerFuture,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Flexible(
              flex: 3,
              child: Container(
                  color: Theme.of(context).colorScheme.onBackground,
                  width: double.infinity,
                  height: double.infinity,
                  child: () {
                    return Center(
                      child: GoogleMap(
                        initialCameraPosition: CameraPosition(
                          target: widget.cameraFocus,
                          zoom: 15.0,
                        ),
                        polygons: widget.region.polygons,
                        markers: {
                          Marker(
                              markerId: const MarkerId("1"),
                              position: widget.region.controlPoint1!,
                              draggable: true,
                              onDrag: (position) {
                                setState(() {
                                  widget.region.updateControlPoint1(position);
                                });
                              },
                              onDragEnd: (position) {
                                setState(() {
                                  widget.region.updateControlPoint1(position);
                                });
                              },
                              infoWindow: InfoWindow(
                                  title: "Coordinates",
                                  snippet:
                                      "ID: 1, ${widget.cameraFocus.latitude}, ${widget.cameraFocus.longitude}")),
                          Marker(
                              markerId: const MarkerId("2"),
                              position: widget.region.controlPoint2!,
                              draggable: true,
                              onDrag: (position) {
                                setState(() {
                                  widget.region.updateControlPoint2(position);
                                });
                              },
                              onDragEnd: (position) {
                                setState(() {
                                  widget.region.updateControlPoint2(position);
                                });
                              },
                              infoWindow: InfoWindow(
                                  title: "Coordinates",
                                  snippet:
                                      "ID: 2, ${widget.cameraFocus.latitude}, ${widget.cameraFocus.longitude}")),
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
                          style: TextStyle(color: Colors.white, fontSize: 25),
                        ),
                      ),
                      CircularProgressIndicator(),
                    ],
                  ),
                ));
          }
        });
  }
}

class Region {
  LatLng? controlPoint1;
  LatLng? controlPoint2;
  Set<Polygon> polygons = <Polygon>{};

  void updateControlPoint1(LatLng polygon) {
    controlPoint1 = polygon;
    updateRegion();
  }

  void updateControlPoint2(LatLng polygon) {
    controlPoint2 = polygon;
    updateRegion();
  }

  void updateRegion() {
    if (controlPoint1 != null && controlPoint2 != null) {
      polygons = <Polygon>{
        Polygon(
            polygonId: const PolygonId('1'),
            points: [
              controlPoint1!,
              LatLng(controlPoint1!.latitude, controlPoint2!.longitude),
              controlPoint2!,
              LatLng(controlPoint2!.latitude, controlPoint1!.longitude),
            ],
            fillColor: Colors.red.withOpacity(0.6),
            strokeColor: Colors.red,
            strokeWidth: 5)
      };
    }
  }
}

class FlightData {
  Image image;
  Duration duration;
  double batteryLoss;

  void updateImage(Image image) {
    this.image = image;
  }

  FlightData(
      {required this.image, required this.duration, required this.batteryLoss});
}
