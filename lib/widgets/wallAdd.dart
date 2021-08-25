import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:web_admin/controllers/spaceGrid.dart';

class WallAdd extends StatelessWidget {
  WallAdd({Key? key}) : super(key: key);
  final SpaceGridController spaceGridController = Get.find();
  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Container(
        child: ListView(
          scrollDirection: Axis.horizontal,
          shrinkWrap: true,
          children: [
            Container(
              width: 100,
              height: 100,
              child: Center(
                  child: IconButton(
                onPressed: () {
                  spaceGridController.selectedWallSide(WallSide.left);
                },
                iconSize: 50,
                icon: Icon(
                  Icons.border_left_sharp,
                  color: spaceGridController.selectedWallSide.value ==
                          WallSide.left
                      ? Colors.blue.shade400
                      : null,
                ),
              )),
            ),
            Container(
              width: 100,
              height: 100,
              child: Center(
                  child: IconButton(
                onPressed: () {
                  spaceGridController.selectedWallSide(WallSide.top);
                },
                iconSize: 50,
                icon: Icon(
                  Icons.border_top_sharp,
                  color:
                      spaceGridController.selectedWallSide.value == WallSide.top
                          ? Colors.blue.shade400
                          : null,
                ),
              )),
            ),
            Container(
              width: 100,
              height: 100,
              child: Center(
                  child: IconButton(
                onPressed: () {
                  spaceGridController.selectedWallSide(WallSide.bottom);
                },
                iconSize: 50,
                icon: Icon(
                  Icons.border_bottom_sharp,
                  color: spaceGridController.selectedWallSide.value ==
                          WallSide.bottom
                      ? Colors.blue.shade400
                      : null,
                ),
              )),
            ),
            Container(
              width: 100,
              height: 100,
              child: Center(
                  child: IconButton(
                onPressed: () {
                  spaceGridController.selectedWallSide(WallSide.right);
                },
                iconSize: 50,
                icon: Icon(
                  Icons.border_right_sharp,
                  color: spaceGridController.selectedWallSide.value ==
                          WallSide.right
                      ? Colors.blue.shade400
                      : null,
                ),
              )),
            ),
          ],
        ),
      );
    });
  }
}
