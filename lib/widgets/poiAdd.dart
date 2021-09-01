import 'package:flex_color_picker/flex_color_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:web_admin/controllers/pois.dart';
import 'package:web_admin/controllers/spaces.dart';

class PoiAdd extends StatelessWidget {
  PoiAdd({Key? key}) : super(key: key);
  final SpacesController spacesController = Get.find();
  final PoisController poisController = Get.find();
  TextEditingController titleController = TextEditingController();
  int pickedColor = 4288585374;
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () {
        Get.defaultDialog(
            title: "Add new POI",
            content: Column(
              children: [
                SizedBox(
                  height: 20,
                ),
                Form(
                  key: _formKey,
                  child: TextFormField(
                    controller: titleController,
                    decoration: InputDecoration(labelText: "Title"),
                    validator: (val) {
                      if (val == null || val.isEmpty)
                        return 'Enter valid title value';
                      return null;
                    },
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                ColorPicker(
                  color: Color(pickedColor),
                  showColorName: true,
                  onColorChanged: (c) {
                    pickedColor = c.value;
                  },
                  pickersEnabled: const <ColorPickerType, bool>{
                    ColorPickerType.primary: false,
                    ColorPickerType.accent: false,
                    ColorPickerType.wheel: true,
                  },
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
                            await poisController.postPoi(
                                titleController.text, pickedColor);
                            print(
                                "new poi ${spacesController.currentSpace.value.id} -> ${titleController.text}");
                            Get.back();
                          }
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
