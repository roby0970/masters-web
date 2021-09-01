import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'package:web_admin/controllers/spaces.dart';
import 'package:web_admin/models/beacons.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class BeaconsController extends GetxController {
  RxList<Beacon> beacons = List<Beacon>.empty().obs;

  @override
  void onInit() {
    // called immediately after the widget is allocated memory
    getBeacons();

    super.onInit();
  }

  Future<void> getBeacons() async {
    SpacesController spacesController = Get.find();

    final response = await http.get(
        Uri.parse(
            "http://${dotenv.env['IP_ADDR']}:${dotenv.env['PORT']}/bles_space/${spacesController.currentSpace.value.id}"),
        headers: {
          "Accept": "application/json",
          "Access-Control-Allow-Origin": "*"
        });
    print(response.body);
    final items = json.decode(response.body).cast<Map<String, dynamic>>();
    List<Beacon> newBeacons = items.map<Beacon>((json) {
      return Beacon.fromJson(json);
    }).toList();

    beacons.clear();
    beacons.addAll(newBeacons);
  }

  Future<void> postBeacon(String title) async {
    SpacesController spacesController = Get.find();

    final response = await http.post(
        Uri.parse("http://${dotenv.env['IP_ADDR']}:${dotenv.env['PORT']}/bles"),
        headers: {
          "Content-Type": "application/json",
          "Accept": "application/json",
          "Access-Control-Allow-Origin": "*"
        },
        body: jsonEncode({
          "title": title,
          "idspace": spacesController.currentSpace.value.id,
        }));
    print(response.body);
    final item = json.decode(response.body);
    Beacon newBeacon = Beacon.fromJson(item);

    beacons.add(newBeacon);
  }

  Future<void> deleteBeacon(int? id) async {
    final response = await http.delete(
        Uri.parse(
            "http://${dotenv.env['IP_ADDR']}:${dotenv.env['PORT']}/bles/$id"),
        headers: {
          "Accept": "application/json",
          "Access-Control-Allow-Origin": "*"
        });

    if (response.statusCode == 200) {
      beacons.removeWhere((element) => element.id == id);
    }
  }
}
