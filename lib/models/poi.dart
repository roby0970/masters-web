import 'dart:math';

import 'package:flutter/material.dart';

final List<Color> colors = [
  Colors.red.shade300,
  Colors.green.shade300,
  Colors.blue.shade300,
  Colors.yellow.shade300,
  Colors.purple.shade300,
  Colors.orange.shade300,
  Colors.brown.shade300,
  Colors.teal.shade300,
  Colors.amber.shade300,
];

class Poi {
  final int? id;
  final String? title;
  final int? idspace;
  final Color? color;
  Poi({this.id, this.title, this.idspace, this.color});

  factory Poi.fromJson(Map<String, dynamic> json) {
    Color c = colors[Random().nextInt(9)];
    return Poi(
      id: json['id'],
      title: json['title'],
      idspace: json['idspace'],
      color: c,
    );
  }

  Map<String, dynamic> toJson() => {
        'title': title,
        'idspace': idspace,
      };
}
