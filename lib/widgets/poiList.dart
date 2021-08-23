import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:web_admin/controllers/pois.dart';
import 'package:web_admin/controllers/spaces.dart';

class PoisList extends StatefulWidget {
  const PoisList({Key? key}) : super(key: key);

  @override
  _PoisListState createState() => _PoisListState();
}

class _PoisListState extends State<PoisList> {
  final PoisController controller = Get.find();
  final SpacesController spacesController = Get.find();
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        height: 400,
        child: Obx(() {
          return ListView(
            children: [
              ...controller.pois
                  .map(
                    (e) => ListTile(
                      selected: controller.selected.value == e ? true : false,
                      title: Text(e.title!),
                      onTap: () {
                        controller.selectPoi(e);
                      },
                      trailing: IconButton(
                        icon: Icon(Icons.delete),
                        onPressed: () => controller.deletePoi(e.id),
                      ),
                    ),
                  )
                  .toList(),
            ],
          );
        }),
      ),
    );
  }
}
