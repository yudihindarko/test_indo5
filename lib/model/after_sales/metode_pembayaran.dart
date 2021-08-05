class MetodePembayaranModel {
  int fee = 0;
  String key = "";
  String name = "";

  MetodePembayaranModel(jsonMap) {
    this.fee = jsonMap['fee']?.toInt() ?? jsonMap['fee'];
    this.key = jsonMap['key'];
    this.name = jsonMap['name'];
  }
}
