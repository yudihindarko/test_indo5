class LocationModel {
  int id = 0;
  String name = '';

  LocationModel(jsonMap) {
    id = jsonMap['id'] ?? 0;
    name = jsonMap['name'] ?? '';
  }
}
