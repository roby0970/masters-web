import 'package:get/get.dart';
import 'package:web_admin/controllers/spaces.dart';
import '../models/spaces.dart';
import '../models/poi.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class PoisController extends GetxController {
  RxList<Poi> pois = List<Poi>.empty().obs;

  @override
  void onInit() {
    // called immediately after the widget is allocated memory
    getPois();

    super.onInit();
  }

  late Rx<Poi> selected;

  Poi getBasePoi(Space s) {
    return pois.firstWhere((element) => element.title == s.title);
  }

  Future<void> getPois() async {
    SpacesController spacesController = Get.find();

    final response = await http.get(
        Uri.parse(
            "http://localhost:8000/pois_space/${spacesController.currentSpace.value.id}"),
        headers: {
          "Accept": "application/json",
          "Access-Control-Allow-Origin": "*"
        });

    final items = json.decode(response.body).cast<Map<String, dynamic>>();
    List<Poi> newPois = items.map<Poi>((json) {
      return Poi.fromJson(json);
    }).toList();

    pois.clear();
    pois.addAll(newPois);

    if (pois.isNotEmpty) {
      selected = pois[0].obs;
    }
  }

  Future<void> postPoi(String title, int color) async {
    SpacesController spacesController = Get.find();

    final response = await http.post(Uri.parse("http://localhost:8000/pois"),
        headers: {
          "Content-Type": "application/json",
          "Accept": "application/json",
          "Access-Control-Allow-Origin": "*"
        },
        body: jsonEncode({
          "title": title,
          "idspace": spacesController.currentSpace.value.id,
          "color": color,
        }));
    print(response.body);
    final item = json.decode(response.body);
    Poi newPoi = Poi.fromJson(item);

    pois.add(newPoi);
  }

  Future<void> deletePoi(int? id) async {
    final response = await http
        .delete(Uri.parse("http://localhost:8000/pois/$id"), headers: {
      "Accept": "application/json",
      "Access-Control-Allow-Origin": "*"
    });

    if (response.statusCode == 200) {
      pois.removeWhere((element) => element.id == id);
    }
  }

  void selectPoi(Poi p) {
    selected.value = p;
    selected.refresh();
  }
}
