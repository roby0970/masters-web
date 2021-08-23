import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:web_admin/controllers/spaces.dart';
import '../controllers/pois.dart';
import '../controllers/spaceGrid.dart';
import '../models/coordinates.dart';

class CoordinateTile extends StatelessWidget {
  final Coordinate coordinate;
  CoordinateTile(this.coordinate);
  final SpaceGridController spaceGridController = Get.find();
  final PoisController poisController = Get.find();
  final SpacesController spacesController = Get.find();
  @override
  Widget build(BuildContext context) {
    return Obx(() {
      Color c = Colors.transparent;
      if (coordinate.idpoi == poisController.selected.value.id &&
          coordinate.blocked == false) {
        c = Colors.red.shade300;
      } else if (!coordinate.blocked!) {
        c = Colors.blue.shade300;
      }
      return GestureDetector(
        onTap: () {
          if (poisController.selected.value.title ==
              spacesController.currentSpace.value.title)
            spaceGridController.toggleBlocked(coordinate);
          else if (coordinate.idpoi != poisController.selected.value.id)
            spaceGridController.registerCoordinateToPoi(
                coordinate, poisController.selected.value);
          else {
            spaceGridController.unregisterCoordinateToPoi(coordinate,
                poisController.getBasePoi(spacesController.currentSpace.value));
          }
        },
        child: Container(
          margin: EdgeInsets.all(2),
          color: c,
          child: spaceGridController.loadingToggle.contains(coordinate.id)
              ? SizedBox(
                  child: CircularProgressIndicator(
                  color: Colors.white30,
                ))
              : null,
        ),
      );
    });
  }
}
