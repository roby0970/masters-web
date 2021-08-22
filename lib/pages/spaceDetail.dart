import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:web_admin/controllers/pois.dart';

import '../controllers/spaces.dart';
import '../widgets/spaceGrid.dart';
import '../widgets/poiList.dart';

class SpaceDetail extends StatelessWidget {
  SpaceDetail({Key? key}) : super(key: key);

  final SpacesController spacesController = Get.find();
  final PoisController poisController = Get.find();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Text(spacesController.currentSpace.value.title!),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [SpaceGrid(), PoisList()],
              )
            ],
          ),
        ),
      ),
    );
  }
}
