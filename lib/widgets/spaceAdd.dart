import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:web_admin/controllers/pois.dart';
import 'package:web_admin/controllers/spaces.dart';

class SpaceAdd extends StatelessWidget {
  SpaceAdd({Key? key}) : super(key: key);
  final SpacesController spacesController = Get.find();
  final PoisController poisController = Get.find();
  TextEditingController titleController = TextEditingController();
  TextEditingController areaController = TextEditingController();
  TextEditingController longitudeController = TextEditingController();
  TextEditingController latitudeController = TextEditingController();
  TextEditingController compassController = TextEditingController();
  TextEditingController datasetController = TextEditingController();

  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8),
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(10)),
      child: Material(
        borderRadius: BorderRadius.circular(10),
        child: ListTile(
          hoverColor: Colors.blue.shade100,
          onTap: () {
            Get.defaultDialog(
                title: "Add new Space",
                content: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      SizedBox(
                        height: 20,
                      ),
                      TextFormField(
                        controller: titleController,
                        decoration: InputDecoration(labelText: "Title"),
                        validator: (val) {
                          if (val == null || val.isEmpty)
                            return 'Enter valid title value';
                          return null;
                        },
                      ),
                      TextFormField(
                        controller: areaController,
                        decoration: InputDecoration(
                          labelText: "Border length",
                        ),
                        onChanged: (va) {
                          print(int.tryParse(va));
                        },
                        validator: (val) {
                          if (val == null ||
                              val.isEmpty ||
                              int.tryParse(val) == null)
                            return 'Enter valid length value (integer)';
                          return null;
                        },
                      ),
                      TextFormField(
                        controller: longitudeController,
                        decoration: InputDecoration(labelText: "Longitude"),
                        validator: (val) {
                          if (val == null ||
                              val.isEmpty ||
                              double.tryParse(val) == null)
                            return 'Enter valid longitude value (decimal)';
                          return null;
                        },
                      ),
                      TextFormField(
                        controller: latitudeController,
                        decoration: InputDecoration(labelText: "Latitude"),
                        validator: (val) {
                          if (val == null ||
                              val.isEmpty ||
                              double.tryParse(val) == null)
                            return 'Enter valid latitude value (decimal)';
                          return null;
                        },
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      TextFormField(
                          controller: compassController,
                          decoration: InputDecoration(
                              labelText: "Orientation (compass)"),
                          validator: (val) {
                            if (val == null ||
                                val.isEmpty ||
                                double.tryParse(val) == null)
                              return 'Enter valid compass value (decimal)';
                            return null;
                          }),
                      SizedBox(
                        height: 20,
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: TextFormField(
                                controller: datasetController,
                                enabled: false,
                                decoration:
                                    InputDecoration(labelText: "Dataset file"),
                                validator: (val) {
                                  if (val == null || val.isEmpty)
                                    return 'Enter valid dataset file';
                                  return null;
                                }),
                          ),
                          Obx(() {
                            if (spacesController.uploading.value) {
                              return CircularProgressIndicator();
                            } else {
                              return IconButton(
                                icon: Icon(Icons.file_upload),
                                onPressed: () async {
                                  await spacesController.uploadFile();
                                  datasetController.text =
                                      spacesController.selectedFile.value;
                                },
                              );
                            }
                          })
                        ],
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
                                if (_formKey.currentState!.validate()) {
                                  String title = titleController.text;
                                  int area = int.parse(areaController.text);
                                  double longitude =
                                      double.parse(longitudeController.text);
                                  double latitude =
                                      double.parse(latitudeController.text);
                                  double compass =
                                      double.parse(compassController.text);
                                  String dataset = datasetController.text;
                                  await spacesController.postSpace(title, area,
                                      longitude, latitude, compass, dataset);
                                  Get.back();
                                }
                              },
                              child: Text("Add")),
                        ],
                      )
                    ],
                  ),
                ));
          },
          title:
              Center(child: Text("New Space", style: TextStyle(fontSize: 24))),
          subtitle: Center(child: Text("Describe new space")),
        ),
      ),
    );
  }
}
