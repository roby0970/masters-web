import 'dart:convert';
import 'dart:html';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'package:web_admin/models/coordinates.dart';
import 'package:web_socket_channel/web_socket_channel.dart';
import '../models/location.dart';

class LocationController extends GetxController {
  RxList<Location> locations = List<Location>.empty().obs;

  var webSocket =
      new WebSocket('ws://${dotenv.env['IP_ADDR']}:${dotenv.env['PORT']}/ws/');

  String text = '';
  late WebSocketChannel ws;
  @override
  void onInit() {
    webSocket.onMessage.listen((MessageEvent e) {
      print(e.data);

      locations.clear();
      locations.add(Location.fromJson(jsonDecode(e.data)));
    });
    super.onInit();
  }

  @override
  void onClose() {
    super.onClose();
  }

  bool isLocationLive(Coordinate c) {
    bool live = false;
    locations.forEach((element) {
      if (element.x == c.x && element.y == c.y) {
        live = true;
        return;
      }
    });

    return live;
  }
}
