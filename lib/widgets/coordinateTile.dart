import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:web_admin/controllers/location.dart';
import 'package:web_admin/controllers/spaces.dart';
import 'package:web_admin/models/location.dart';
import '../controllers/pois.dart';
import '../controllers/spaceGrid.dart';
import '../models/coordinates.dart';

class CoordinateTile extends StatelessWidget {
  final Coordinate coordinate;
  CoordinateTile(this.coordinate);
  final SpaceGridController spaceGridController = Get.find();
  final PoisController poisController = Get.find();
  final SpacesController spacesController = Get.find();
  final LocationController locationController = Get.find();
  @override
  Widget build(BuildContext context) {
    return Obx(() {
      Color c = Colors.transparent;
      if (coordinate.blocked == false) {
        c = Color(poisController.pois
            .firstWhere((p) => p.id == coordinate.idpoi)
            .color!);
      } else if (!coordinate.blocked!) {
        c = Colors.blue.shade300;
      }
      if (coordinate.idpoi != poisController.selected.value.id) {
        c = c.withAlpha(128);
      }
      return GestureDetector(
        onTap: () {
          if (spaceGridController.selectedWallSide.value == WallSide.none) {
            if (poisController.selected.value.title ==
                spacesController.currentSpace.value.title)
              spaceGridController.toggleBlocked(coordinate);
            else if (coordinate.idpoi != poisController.selected.value.id)
              spaceGridController.registerCoordinateToPoi(
                  coordinate, poisController.selected.value);
            else {
              spaceGridController.unregisterCoordinateToPoi(
                  coordinate,
                  poisController
                      .getBasePoi(spacesController.currentSpace.value));
            }
          } else {
            spaceGridController.toggleBorder(coordinate);
          }
        },
        child: Container(
            margin: EdgeInsets.all(1),
            decoration: BoxDecoration(
              color: c,
              border: Border(
                left: BorderSide(
                  color: Colors.black,
                  width: coordinate.wallleft! ? 4 : 0,
                ),
                top: BorderSide(
                  color: Colors.black,
                  width: coordinate.wallup! ? 4 : 0,
                ),
                right: BorderSide(
                  color: Colors.black,
                  width: coordinate.wallright! ? 4 : 0,
                ),
                bottom: BorderSide(
                  color: Colors.black,
                  width: coordinate.walldown! ? 4 : 0,
                ),
              ),
            ),
            child: spaceGridController.loadingToggle.contains(coordinate.id)
                ? SizedBox(
                    child: CircularProgressIndicator(
                    color: Colors.white30,
                  ))
                : locationController.isLocationLive(coordinate)
                    ? Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: Colors.yellow),
                      )
                    : null),
      );
    });
  }
}
