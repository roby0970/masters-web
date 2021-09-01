import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'package:web_admin/controllers/beacons.dart';
import 'package:web_admin/pages/home.dart';
import 'package:web_admin/pages/spaceDetail.dart';

import 'controllers/location.dart';
import 'controllers/pois.dart';
import 'controllers/spaceGrid.dart';
import 'controllers/spaces.dart';

void main() async {
  await dotenv.load(fileName: ".env");
  runApp(GetMaterialApp(
    initialRoute: '/home',
    getPages: [
      GetPage(name: '/home', page: () => MyApp()),
      GetPage(name: '/space', page: () => SpaceDetail()),
    ],
  ));
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.

  final spacesController = Get.put(SpacesController());
  final poisController = Get.put(PoisController());
  final beaconsController = Get.put(BeaconsController());
  final spaceGridController = Get.put(SpaceGridController());
  final locationsController = Get.put(LocationController());

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'NavINAR',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Navigate Indoors using Augmented Reality'),
    );
  }
}
