import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:web_admin/controllers/spaces.dart';
import 'package:web_admin/controllers/spaceGrid.dart';
import 'package:web_admin/widgets/coordinateTile.dart';

class SpaceGrid extends StatelessWidget {
  SpaceGrid({Key? key}) : super(key: key);

  final SpacesController spacesController = Get.find();
  final SpaceGridController spaceGridController = Get.find();
  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Container(
        height: context.height * 0.85,
        width: context.height * 0.85,
        color: spaceGridController.coordinates.isEmpty
            ? Colors.grey[200]
            : Colors.black,
        child: GridView.builder(
            reverse: true,
            shrinkWrap: true,
            itemCount: spacesController.currentSpace.value.area! *
                spacesController.currentSpace.value.area!,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: spacesController.currentSpace.value.area!,
            ),
            itemBuilder: (_, i) {
              return CoordinateTile(spaceGridController.find(i));
            }),
      );
    });
  }
}
