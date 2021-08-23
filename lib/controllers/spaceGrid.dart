import 'package:get/get.dart';
import 'package:web_admin/controllers/spaces.dart';
import 'package:web_admin/models/poi.dart';
import 'package:web_admin/models/spaces.dart';
import '../models/coordinates.dart';

import 'package:http/http.dart' as http;
import 'dart:convert';

class SpaceGridController extends GetxController {
  @override
  void onInit() {
    // called immediately after the widget is allocated memory

    super.onInit();
  }

  RxBool loading = false.obs;
  RxList<int> loadingToggle = List<int>.empty().obs;
  RxList<Coordinate> coordinates = List<Coordinate>.empty().obs;

  RxList<Coordinate> blockedCoordinates = List<Coordinate>.empty().obs;

  Future<void> getCoordinates({bool loadIndicator = false}) async {
    if (loadIndicator) loading(true);
    SpacesController spacesController = Get.find();
    final response = await http.get(
        Uri.parse(
            "http://localhost:8000/coordinates_space/${spacesController.currentSpace.value.id}"),
        headers: {
          "Accept": "application/json",
          "Access-Control-Allow-Origin": "*"
        });

    final items = json.decode(response.body).cast<Map<String, dynamic>>();
    List<Coordinate> newCoordinates = items.map<Coordinate>((json) {
      return Coordinate.fromJson(json);
    }).toList();

    coordinates(
        newCoordinates.where((element) => element.blocked == false).toList());
    blockedCoordinates(
        newCoordinates.where((element) => element.blocked == true).toList());
    if (loadIndicator) loading(false);
  }

  Future<void> updateCoordinate(Coordinate oldC, Coordinate newC) async {
    loadingToggle.add(oldC.id!);
    print("updajtema");
    final response = await http.put(
        Uri.parse("http://localhost:8000/coordinates/${oldC.id}"),
        headers: {
          "Content-Type": "application/json",
          "Accept": "application/json",
          "Access-Control-Allow-Origin": "*"
        },
        body: jsonEncode(newC.toJson()));
    print(response.body);
    await getCoordinates();
    loadingToggle.remove(oldC.id);
  }

  bool isBlocked(int i) {
    Map<String, int> coords = indexToCoords(i);
    bool blocked = false;
    blockedCoordinates.forEach((element) {
      if (element.x == coords["x"] && element.y == coords["y"]) {
        blocked = true;
        return;
      }
    });
    return blocked;
  }

  Coordinate find(int i) {
    Map<String, int> coords = indexToCoords(i);
    return blockedCoordinates.firstWhere(
        (element) => element.x == coords["x"] && element.y == coords["y"],
        orElse: () {
      return coordinates.firstWhere(
          (element) => element.x == coords["x"] && element.y == coords["y"]);
    });
  }

  void toggleBlocked(Coordinate c) async {
    print(c.toJson());
    await updateCoordinate(
        c,
        Coordinate(
            id: c.id,
            x: c.x,
            y: c.y,
            idpoi: c.idpoi,
            idspace: c.idspace,
            blocked: !c.blocked!));

    blockedCoordinates.remove(c);
    blockedCoordinates.refresh();
    coordinates.add(c);
    coordinates.refresh();
  }

  Map<String, int> indexToCoords(int i) {
    SpacesController spacesController = Get.find();
    return {
      "x": (i / spacesController.currentSpace.value.area!).floor(),
      "y": i % spacesController.currentSpace.value.area!
    };
  }

  void registerCoordinateToPoi(Coordinate c, Poi p) async {
    Coordinate updated = Coordinate(
        id: c.id,
        x: c.x,
        y: c.y,
        idpoi: p.id,
        idspace: p.idspace,
        blocked: c.blocked);
    await updateCoordinate(c, updated);
  }

  void unregisterCoordinateToPoi(Coordinate c, Poi base) async {
    Coordinate updated = Coordinate(
        id: c.id,
        x: c.x,
        y: c.y,
        idpoi: base.id,
        idspace: c.idspace,
        blocked: c.blocked);
    await updateCoordinate(c, updated);
  }
}
