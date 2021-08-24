import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:web_admin/controllers/pois.dart';
import 'package:web_admin/controllers/spaceGrid.dart';
import 'package:web_admin/controllers/spaces.dart';
import 'package:web_admin/widgets/poiAdd.dart';

class PoisList extends StatefulWidget {
  const PoisList({Key? key}) : super(key: key);

  @override
  _PoisListState createState() => _PoisListState();
}

class _PoisListState extends State<PoisList> {
  final PoisController poisController = Get.find();
  final SpacesController spacesController = Get.find();
  final SpaceGridController spaceGridController = Get.find();
  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return ListView(
        shrinkWrap: true,
        children: [
          ...poisController.pois
              .map(
                (e) => ListTile(
                  selected: poisController.selected.value == e ? true : false,
                  title: Container(
                    decoration: BoxDecoration(
                        border: Border(
                            left: BorderSide(color: e.color!, width: 20))),
                    padding: EdgeInsets.only(
                        left: poisController.selected.value == e ? 0 : 32),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Text(e.title!,
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 20,
                              fontWeight: poisController.selected.value == e
                                  ? FontWeight.bold
                                  : FontWeight.normal)),
                    ),
                  ),
                  onTap: () {
                    poisController.selectPoi(e);
                  },
                  trailing: IconButton(
                      icon: Icon(Icons.delete),
                      onPressed: () {
                        Get.defaultDialog(
                            title: "Delete POI",
                            content: Column(
                              children: [
                                SizedBox(
                                  height: 20,
                                ),
                                Text(
                                    "Are you sure you want to delete ${e.title} POI? POI coordinates will revert to default."),
                                SizedBox(
                                  height: 20,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    TextButton(
                                        onPressed: () {
                                          Get.back();
                                        },
                                        child: Text("Cancel")),
                                    ElevatedButton(
                                        onPressed: () async {
                                          await spaceGridController
                                              .unregisterAllPOICoordinates(e);
                                          await poisController.deletePoi(e.id);
                                          Get.back();
                                        },
                                        child: Text("Delete")),
                                  ],
                                )
                              ],
                            ));
                      }),
                ),
              )
              .toList(),
          PoiAdd(),
        ],
      );
    });
  }
}
