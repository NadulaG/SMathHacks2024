import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';

class FlightMapper extends StatefulWidget {
  const FlightMapper({super.key});

  @override
  State<StatefulWidget> createState() => _FlightMapperState();
}

class _FlightMapperState extends State<FlightMapper> {
  FlightData data = FlightData(
      // image: const Image(image: AssetImage("assets/landscape.png")),
      duration: const Duration(minutes: 24),
      batteryLoss: 58.0);
  List<PathNode> pathNodes = [];
  List<Widget> pathWidgets = [];

  _handleImageTapUp(BuildContext context, TapDownDetails details) {
    setState(() {
      RenderBox box = context.findRenderObject() as RenderBox;
      PathNode newNode =
          PathNode(x: details.localPosition.dx, y: details.localPosition.dy);
      if (pathNodes.isNotEmpty) {
        pathNodes.last.child = newNode;
      }
      pathNodes.add(newNode);

      pathWidgets.add(Positioned(
          top: details.localPosition.dy,
          left: details.localPosition.dx,
          child: Container(
            width: 20,
            height: 20,
            child: Center(
              child: Text(
                "${pathNodes.length}",
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.white),
              ),
            ),
            decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.background,
                borderRadius: BorderRadius.all(Radius.circular(50.0))),
          )));
    });
  }

  @override
  Widget build(BuildContext context) {
    final colorTheme = Theme.of(context).colorScheme;
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
                if (data.image != null) {
                  return Stack(children: <Widget>[
                    GestureDetector(
                      child: Center(child: data.image as Widget),
                      onTapDown: (details) {
                        _handleImageTapUp(context, details);
                      },
                    ),
                    for (var widget in pathWidgets) widget,
                    Align(
                      alignment: Alignment.bottomRight,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: FloatingActionButton(
                          onPressed: () {
                            setState(() {
                              data.deleteImage();
                            });
                          },
                          backgroundColor: colorTheme.background,
                          child: Icon(
                            Icons.delete,
                            color: colorTheme.onPrimary,
                          ),
                        ),
                      ),
                    )
                  ]);
                } else {
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        "Looks like you need to upload an image.",
                        textAlign: TextAlign.center,
                        style: TextStyle(color: Colors.white, fontSize: 30),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 20),
                        child: SizedBox(
                          height: 80,
                          width: 200,
                          child: TextButton(
                            style: TextButton.styleFrom(
                                backgroundColor: colorTheme.primary,
                                foregroundColor: colorTheme.onPrimary,
                                shape: const RoundedRectangleBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(8)))),
                            onPressed: () async {
                              var result =
                                  await FilePicker.platform.pickFiles();
                              if (result != null) {
                                File file = File(result.files.single.path!);
                                setState(() {
                                  data.image = Image.file(file);
                                });
                              }
                            },
                            child: const Text(
                              "Upload image",
                              style: TextStyle(fontSize: 20),
                            ),
                          ),
                        ),
                      ),
                    ],
                  );
                }
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
  Image? image;
  Duration duration;
  WeatherData? weather;
  double batteryLoss;

  void updateImage(Image image) {
    this.image = image;
  }

  void deleteImage() {
    image = null;
  }

  FlightData(
      {this.image,
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
