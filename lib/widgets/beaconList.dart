import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart';
import 'package:web_admin/controllers/beacons.dart';

class BeaconsList extends StatefulWidget {
  BeaconsList({Key? key}) : super(key: key);

  @override
  _BeaconsListState createState() => _BeaconsListState();
}

class _BeaconsListState extends State<BeaconsList> {
  final BeaconsController beaconsController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Wrap(
        children: [
          ...beaconsController.beacons
              .map((e) => Stack(
                    children: [
                      Container(
                        padding:
                            EdgeInsets.symmetric(horizontal: 4, vertical: 8),
                        child: Chip(
                          label: Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: 4, vertical: 8),
                            child: Text(
                              e.title!,
                              style: TextStyle(fontSize: 20),
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                          top: -10,
                          right: -10,
                          child: IconButton(
                            splashRadius: 20,
                            icon: Icon(
                              Icons.highlight_remove,
                              color: Colors.red[300],
                            ),
                            onPressed: () {
                              beaconsController.deleteBeacon(e.id);
                            },
                          )),
                    ],
                  ))
              .toList(),
        ],
      );
    });
  }
}
