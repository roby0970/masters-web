class Location {
  final String? mac;
  final String? desc;
  final int? x;
  final int? y;

  Location({this.mac, this.desc, this.x, this.y});

  factory Location.fromJson(Map<String, dynamic> json) {
    return Location(
      mac: json['mac'],
      desc: json['desc'],
      x: json['x'],
      y: json['y'],
    );
  }

  Map<String, dynamic> toJson() => {
        'mac': mac,
        'desc': desc,
        'x': x,
        'y': y,
      };
}
