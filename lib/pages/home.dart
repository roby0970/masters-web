import 'dart:html';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:web_admin/controllers/location.dart';
import 'package:web_admin/widgets/spacesList.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, this.title = "Default title"}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          shadowColor: Colors.transparent,
          title: Center(
              child: Text(
            widget.title,
            style: TextStyle(
                color: Colors.black, fontWeight: FontWeight.bold, fontSize: 40),
          )),
        ),
        body: Container(
          width: double.infinity,
          margin: EdgeInsets.symmetric(horizontal: context.width * 0.15),
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 50,
                ),
                Text(
                  "My spaces",
                  style: TextStyle(
                    fontSize: 32,
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
                Expanded(
                  child: Row(
                    children: [
                      Expanded(
                        child: SpacesList(),
                      )
                    ],
                  ),
                ),
                Center(child: Text("Robert Sudec - 2021"))
              ],
            ),
          ),
        ));
  }
}
