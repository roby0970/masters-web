import 'dart:html';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:web_admin/controllers/location.dart';
import 'package:web_admin/widgets/poiAdd.dart';
import '../controllers/pois.dart';
import '../controllers/spaceGrid.dart';

import '../controllers/spaces.dart';
import '../widgets/spaceGrid.dart';
import '../widgets/poiList.dart';

class SpaceDetail extends StatelessWidget {
  SpaceDetail({Key? key}) : super(key: key);

  final SpacesController spacesController = Get.find();
  final SpaceGridController spaceGridController = Get.find();
  final PoisController poisController = Get.find();
  final LocationController locationController = Get.find();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        shadowColor: Colors.transparent,
        elevation: 0,
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.black,
        title: Text(
          spacesController.currentSpace.value.title!,
          style: TextStyle(
              color: Colors.black, fontWeight: FontWeight.bold, fontSize: 40),
        ),
      ),
      body: Container(
        width: double.infinity,
        margin: EdgeInsets.symmetric(horizontal: context.width * 0.05),
        child: Column(
          children: [
            SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Flexible(
                  flex: 3,
                  child: Obx(() => !spaceGridController.loading.value
                      ? SpaceGrid()
                      : CircularProgressIndicator()),
                ),
                SizedBox(
                  width: 20,
                ),
                Flexible(
                  flex: 3,
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        Text(
                          "POIs",
                          style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 26),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        PoisList(),
                      ],
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          int x = Random().nextInt(14);
          int y = Random().nextInt(14);
          if (locationController.webSocket != null &&
              locationController.webSocket.readyState == WebSocket.OPEN) {
            locationController.webSocket.send(
                "{\"mac\": \"12:34:56:78\",\"desc\": \"Robertt S\",\"x\": $x,\"y\": $y}");
          } else {
            print('WebSocket not connected, message not sent');
          }
        },
        tooltip: 'Send message',
        child: const Icon(Icons.send),
      ),
    );
  }
}
