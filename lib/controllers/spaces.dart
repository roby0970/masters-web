import 'package:file_picker/file_picker.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'package:web_admin/models/spaces.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class SpacesController extends GetxController {
  RxList<Space> spaces = List<Space>.empty().obs;
  Rx<Space> currentSpace =
      Space(id: 0, area: 0, latitude: 0, longitude: 0, title: "No information")
          .obs;
  RxString selectedFile = "".obs;
  RxBool uploading = false.obs;
  var showAdd = true.obs;
  int id = 1;

  void pressAdd() => showAdd.toggle();

  Future<void> getSpaces() async {
    final response = await http.get(
        Uri.parse(
            "http://${dotenv.env['IP_ADDR']}:${dotenv.env['PORT']}/spaces"),
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
    final response = await http.delete(
        Uri.parse(
            "http://${dotenv.env['IP_ADDR']}:${dotenv.env['PORT']}/spaces/$id"),
        headers: {
          "Accept": "application/json",
          "Access-Control-Allow-Origin": "*"
        });
    print(response.statusCode);
    if (response.statusCode == 200) {
      spaces.removeWhere((element) => element.id == id);
    }
  }

  Future<void> postSpace(String title, int area, double longitude,
      double latitude, double compass, String dataset) async {
    print(compass);
    print(dataset);

    final response = await http.post(
        Uri.parse(
            "http://${dotenv.env['IP_ADDR']}:${dotenv.env['PORT']}/spaces"),
        headers: {
          "Content-Type": "application/json",
          "Accept": "application/json",
          "Access-Control-Allow-Origin": "*"
        },
        body: jsonEncode({
          "title": title,
          "area": area,
          "longitude": longitude,
          "latitude": latitude,
          "compass": compass,
          "dataset": dataset,
        }));
    print(response.body);
    final item = json.decode(response.body);
    Space newSpace = Space.fromJson(item);

    spaces.add(newSpace);
  }

  Future<void> uploadFile() async {
    var result = await FilePicker.platform.pickFiles(
      withReadStream: true,
    );

    var obj = result!.files.single;

    var postUri = Uri.parse(
        "http://${dotenv.env['IP_ADDR']}:${dotenv.env['PORT']}/upload");
    var request = new http.MultipartRequest("POST", postUri);
    request.fields['file'] = 'blah';
    request.files.add(new http.MultipartFile('file', obj.readStream!, obj.size,
        filename: obj.name));
    uploading(true);
    var respo = await request.send();
    uploading(false);
    if (respo.statusCode == 200) {
      selectedFile(obj.name);
    }
  }
}
