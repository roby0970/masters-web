class Beacon {
  final int? id;
  final String? title;
  final int? idspace;

  Beacon({this.id, this.title, this.idspace});

  factory Beacon.fromJson(Map<String, dynamic> json) {
    return Beacon(
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
