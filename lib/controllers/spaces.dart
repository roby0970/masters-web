import 'package:get/get.dart';
import 'package:web_admin/models/spaces.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class SpacesController extends GetxController {
  RxList<Space> spaces = List<Space>.empty().obs;
  Rx<Space> currentSpace =
      Space(id: 0, area: 0, latitude: 0, longitude: 0, title: "No information")
          .obs;

  var showAdd = true.obs;
  int id = 1;

  void pressAdd() => showAdd.toggle();

  Future<void> getSpaces() async {
    final response = await http.get(Uri.parse("http://localhost:8000/spaces"),
        headers: {
          "Accept": "application/json",
          "Access-Control-Allow-Origin": "*"
        });

    final items = json.decode(response.body).cast<Map<String, dynamic>>();
    List<Space> newSpaces = items.map<Space>((json) {
      return Space.fromJson(json);
    }).toList();

    spaces.clear();
    spaces.addAll(newSpaces);
  }

  Future<void> deleteSpace(int? id) async {
    final response = await http
        .delete(Uri.parse("http://localhost:8000/spaces/$id"), headers: {
      "Accept": "application/json",
      "Access-Control-Allow-Origin": "*"
    });
    print(response.statusCode);
    if (response.statusCode == 200) {
      spaces.removeWhere((element) => element.id == id);
    }
  }
}
