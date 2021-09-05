import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:web_admin/controllers/beacons.dart';
import 'package:web_admin/controllers/pois.dart';
import 'package:web_admin/controllers/spaceGrid.dart';
import 'package:web_admin/controllers/spaces.dart';
import 'package:web_admin/pages/spaceDetail.dart';
import 'package:web_admin/widgets/spaceAdd.dart';

class SpacesList extends StatelessWidget {
  final SpacesController controller = Get.find();
  final PoisController poiController = Get.find();
  final SpaceGridController spaceGridController = Get.find();
  final BeaconsController beaconsController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        child: Obx(() {
          return ListView(
            children: [
              ...controller.spaces
                  .map(
                    (e) => Container(
                      margin: const EdgeInsets.symmetric(vertical: 8),
                      child: Material(
                        borderRadius: BorderRadius.circular(10),
                        elevation: 15,
                        child: ListTile(
                            title: Text(
                              e.title!,
                              style: TextStyle(fontSize: 24),
                            ),
                            subtitle: Text("${e.longitude},  ${e.latitude}"),
                            onTap: () {
                              controller.currentSpace(e);
                              poiController.getPois();
                              beaconsController.getBeacons();
                              spaceGridController.getCoordinates(
                                  loadIndicator: true);
                              Get.to(SpaceDetail());
                            },
                            trailing: Text(
                                "${e.area} x ${e.area} [${e.coordSize}m]",
                                style: TextStyle(fontSize: 24))),
                      ),
                    ),
                  )
                  .toList(),
              SpaceAdd(),
            ],
          );
        }),
      ),
    );
  }
}
