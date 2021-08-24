import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:web_admin/controllers/pois.dart';
import 'package:web_admin/controllers/spaces.dart';
import 'package:web_admin/models/poi.dart';

class PoiAdd extends StatelessWidget {
  PoiAdd({Key? key}) : super(key: key);
  final SpacesController spacesController = Get.find();
  final PoisController poisController = Get.find();
  TextEditingController titleController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () {
        Get.defaultDialog(
            title: "Add a new POI",
            content: Column(
              children: [
                SizedBox(
                  height: 20,
                ),
                TextFormField(
                  controller: titleController,
                  decoration: InputDecoration(hintText: "Title"),
                ),
                SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    TextButton(
                        onPressed: () {
                          Get.back();
                        },
                        child: Text("Cancel")),
                    ElevatedButton(
                        onPressed: () async {
                          await poisController.postPoi(titleController.text);
                          print(
                              "new poi ${spacesController.currentSpace.value.id} -> ${titleController.text}");
                          Get.back();
                        },
                        child: Text("Add")),
                  ],
                )
              ],
            ));
      },
      title: Center(
        child: Text(
          "New POI",
          style: TextStyle(color: Colors.black, fontSize: 20),
        ),
      ),
      subtitle: Center(child: Text("Describe new points of interest")),
      hoverColor: Colors.blue.shade100,
    );
  }
}
