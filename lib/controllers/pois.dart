import 'package:get/get.dart';
import '../models/poi.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class PoisController extends GetxController {
  RxList<Poi> pois = List<Poi>.empty().obs;

  late Rx<Poi> selected;
  Future<void> getPois() async {
    final response = await http.get(Uri.parse("http://localhost:8000/pois"),
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
      selected = pois.first.obs;
    }
  }

  Future<void> deletePoi(int? id) async {
    final response = await http
        .delete(Uri.parse("http://localhost:8000/pois/$id"), headers: {
      "Accept": "application/json",
      "Access-Control-Allow-Origin": "*"
    });
    print(response.statusCode);
    if (response.statusCode == 200) {
      pois.removeWhere((element) => element.id == id);
    }
  }

  void selectPoi(Poi p) {
    selected.value = p;
    selected.refresh();
  }
}
