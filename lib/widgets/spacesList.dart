import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:web_admin/controllers/pois.dart';
import 'package:web_admin/controllers/spaceGrid.dart';
import 'package:web_admin/controllers/spaces.dart';
import 'package:web_admin/pages/spaceDetail.dart';

class SpacesList extends StatefulWidget {
  const SpacesList({Key? key}) : super(key: key);

  @override
  _SpacesListState createState() => _SpacesListState();
}

class _SpacesListState extends State<SpacesList> {
  final SpacesController controller = Get.find();
  final PoisController poiController = Get.find();
  final SpaceGridController spaceGridController = Get.find();
  @override
  void initState() {
    super.initState();
    controller.getSpaces();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: MediaQuery.of(context).size.width / 2,
        child: Obx(() {
          return ListView(
            children: [
              ...controller.spaces
                  .map(
                    (e) => ListTile(
                      title: Text(e.title ?? 'Title'),
                      onTap: () {
                        controller.currentSpace(e);
                        poiController.getPois();
                        spaceGridController.getCoordinates(loadIndicator: true);
                        Get.to(SpaceDetail());
                      },
                      trailing: IconButton(
                        icon: Icon(Icons.delete),
                        onPressed: () => controller.deleteSpace(e.id),
                      ),
                    ),
                  )
                  .toList(),
              ElevatedButton(
                  onPressed: () => controller.pressAdd(),
                  child: Text(controller.showAdd.toString())),
            ],
          );
        }),
      ),
    );
  }
}
