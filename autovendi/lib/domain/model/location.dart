class LocationAxis {
  double x = 0;
  double y = 0;
  double z = 0;
  LocationAxis({required this.x, required this.y, required this.z});
  LocationAxis.fromJson(List<Object?> json) {
    x = json[0] as double;
    y = json[1] as double;
    z = json[2] as double;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['x'] = x;
    data['y'] = y;
    data['z'] = z;
    return data;
  }
}
