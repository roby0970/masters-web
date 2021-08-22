class Coordinate {
  final int? id;
  final int? x;
  final int? y;
  final int? idspace;
  final int? idpoi;
  final bool? blocked;

  Coordinate({this.id, this.x, this.y, this.idspace, this.idpoi, this.blocked});

  factory Coordinate.fromJson(Map<String, dynamic> json) {
    return Coordinate(
      id: json['id'],
      x: json['x'],
      y: json['y'],
      idspace: json['idspace'],
      idpoi: json['idpoi'],
      blocked: json['blocked'],
    );
  }

  Map<String, dynamic> toJson() => {
        'x': x,
        'y': y,
        'idspace': idspace,
        'idpoi': idpoi,
        'blocked': blocked,
      };
}
