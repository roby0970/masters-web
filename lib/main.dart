import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:web_admin/pages/home.dart';
import 'package:web_admin/pages/spaceDetail.dart';

import 'controllers/pois.dart';
import 'controllers/spaceGrid.dart';
import 'controllers/spaces.dart';

void main() {
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
  final spaceGridController = Get.put(SpaceGridController());

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'NavINAR',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Navigate Indoors using Augmented Reality'),
    );
  }
}
