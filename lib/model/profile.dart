import 'dart:convert';
import 'package:test_indo5/model/base.dart';

class ProfileModel extends BaseModel {
  String name = "";
  String email = "";
  String phoneNumber = "";
  String picture = ""; // base64
  AddressModel address = AddressModel({});
  String locale = "en_US";
  String zoneinfo = "";
  int maintenanceCredit = 0;

  ProfileModel(jsonMap) {
    this.name = verify(jsonMap['name']) ?? "";
    this.email = jsonMap['email'] ?? "";
    this.phoneNumber = verify(jsonMap['phone_number']) ?? "";
    this.picture = verify(jsonMap['picture']) ?? ""; // base64
    this.locale = verify(jsonMap['locale']) ?? "";
    this.zoneinfo = verify(jsonMap['zoneinfo']) ?? "";
    this.address = AddressModel(jsonMap['address'] ?? {});
    this.maintenanceCredit = jsonMap['maintenance_credit'] ?? 0;
  }

  String stringifyForUpdateProfile() {
    Map data = {
      "name": name,
      "email": email,
      "phone": phoneNumber,
    };
    var result = jsonEncode(data);
    return result;
  }
}

class AddressModel extends BaseModel {
  String country = "";
  String formatted = "";
  String locality = "";
  String postalCode = "";
  String region = "";
  String streetAddress = "";

  AddressModel(jsonMap) {
    this.country = verify(jsonMap['country']) ?? "";
    this.formatted = verify(jsonMap['formatted']) ?? "";
    this.locality = verify(jsonMap['locality']) ?? "";
    this.postalCode = verify(jsonMap['postal_code']) ?? "";
    this.region = verify(jsonMap['region']) ?? "";
    this.streetAddress = verify(jsonMap['street_address']) ?? "";
  }
}
