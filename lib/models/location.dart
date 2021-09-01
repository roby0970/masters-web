class Location {
  final int? x;
  final int? y;
  final String? name;

  Location({this.x, this.y, this.name});

  factory Location.fromJson(Map<String, dynamic> json) {
    return Location(
      x: json['x'],
      y: json['y'],
      name: json['name'],
    );
  }

  Map<String, dynamic> toJson() => {
        'x': x,
        'y': y,
        'name': name,
      };
}
