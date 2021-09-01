import 'package:flutter/material.dart';
import 'package:web_admin/controllers/beacons.dart';

import 'package:get/get.dart';

class BeaconAdd extends StatelessWidget {
  BeaconAdd({Key? key}) : super(key: key);
  final _formKey = GlobalKey<FormState>();
  final titleController = TextEditingController();
  final BeaconsController beaconsController = Get.find();
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 300,
      child: Row(
        children: [
          Expanded(
            child: Form(
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
          ),
          ElevatedButton(
              onPressed: () async {
                if (_formKey.currentState!.validate()) {
                  await beaconsController.postBeacon(titleController.text);
                }
              },
              child: Text("Add")),
        ],
      ),
    );
  }
}
