class Poi {
  final int? id;
  final String? title;
  final int? idspace;

  Poi({this.id, this.title, this.idspace});

  factory Poi.fromJson(Map<String, dynamic> json) {
    return Poi(
      id: json['id'],
      title: json['title'],
      idspace: json['idspace'],
    );
  }

  Map<String, dynamic> toJson() => {
        'title': title,
        'idspace': idspace,
      };
}
