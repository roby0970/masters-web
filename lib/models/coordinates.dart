class Coordinate {
  final int? id;
  final int? x;
  final int? y;
  final int? idspace;
  final int? idpoi;
  final bool? wallup;
  final bool? wallright;
  final bool? walldown;
  final bool? wallleft;
  final bool? blocked;

  Coordinate(
      {this.id,
      this.x,
      this.y,
      this.idspace,
      this.idpoi,
      this.blocked,
      this.wallup,
      this.wallright,
      this.walldown,
      this.wallleft});

  factory Coordinate.fromJson(Map<String, dynamic> json) {
    return Coordinate(
      id: json['id'],
      x: json['x'],
      y: json['y'],
      wallup: json['wallup'],
      wallright: json['wallright'],
      walldown: json['walldown'],
      wallleft: json['wallleft'],
      blocked: json['blocked'],
      idspace: json['idspace'],
      idpoi: json['idpoi'],
    );
  }

  Map<String, dynamic> toJson() => {
        'x': x,
        'y': y,
        'wallup': wallup,
        'wallright': wallright,
        'walldown': walldown,
        'wallleft': wallleft,
        'blocked': blocked,
        'idspace': idspace,
        'idpoi': idpoi,
      };
}
