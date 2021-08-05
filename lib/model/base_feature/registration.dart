import 'dart:convert';

import 'package:test_indo5/model/base_feature/location.dart';

enum RegisterFields {
  nama,
  alamat,
  kota,
  provinsi,
  kecamatan,
  kodepos,
  email,
  phoneNumber,
  password,
  confirmPassword,
}

class RegistrationModel {
  String nama = '';
  String email = '';
  String phoneNumber = '';
  String alamat = '';
  LocationModel provinsi = LocationModel({});
  LocationModel kota = LocationModel({});
  LocationModel kecamatan = LocationModel({});
  String kodepos = '';
  String password = '';
  String confirmPassword = '';

  String toJson() {
    Map data = {
      "login": email,
      "name": nama,
      "password": password,
      "contact": {
        "street": alamat,
        "phone": phoneNumber,
        "zip": kodepos,
        "city_id": kota.id,
        "state_id": provinsi.id,
      }
    };
    String json = jsonEncode(data);
    return json;
  }
}
