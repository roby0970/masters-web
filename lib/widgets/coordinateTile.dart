import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/spaceGrid.dart';
import '../models/coordinates.dart';

class CoordinateTile extends StatelessWidget {
  final Coordinate coordinate;
  CoordinateTile(this.coordinate);
  final SpaceGridController spaceGridController = Get.find();
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        spaceGridController.toggleBlocked(coordinate);
      },
      child: Container(
        margin: EdgeInsets.all(2),
        color: coordinate.blocked! ? Colors.transparent : Colors.blue[200],
      ),
    );
  }
}
