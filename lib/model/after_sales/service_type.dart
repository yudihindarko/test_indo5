class ServiceTypeModel {
  String label = '';
  String value = '';
  ServiceTypeModel(jsonData) {
    value = jsonData[0];
    label = jsonData[1];
  }
}
