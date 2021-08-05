import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:test_indo5/api/main.dart';
import 'package:test_indo5/model/base_feature/location.dart';
import 'package:test_indo5/model/base_feature/registration.dart';
import 'package:test_indo5/utils/showSnackBar.dart';

class APIBaseFeature {
  APIClient apiClient = APIClient();
  String publicUserEmail = '';
  String publicUserPassword = '';

  APIBaseFeature() {
    publicUserEmail = dotenv.env['PUBLIC_USER_EMAIL'].toString();
    publicUserPassword = dotenv.env['PUBLIC_USER_PASSWORD'].toString();
  }

  getPublicAccessToken() async {
    var url = Uri.https(apiClient.apiDomain, "/api/magic/access_token");
    var response = await http.post(url, body: {
      "login": publicUserEmail,
      "password": publicUserPassword,
      "db": apiClient.apiDBName,
    });

    Map tokenDetails = jsonDecode(response.body);

    if (tokenDetails['data'] == null) throw "Login failed";

    var accessToken = tokenDetails['data']['access_token'].toString();
    return accessToken;
  }

  getProvinsi(context) async {
    List<LocationModel> result = [];

    try {
      var accessToken = await this.getPublicAccessToken();
      var model = 'res.country.state';
      var domain = "[['country_id','=ilike','Indonesia']]";
      var fields = "['id', 'name']";
      var order = 'name asc';
      var url = Uri.https(apiClient.apiDomain, "/api/search_read/$model", {
        "domain": domain,
        "order": order,
        "fields": fields,
      });
      var response = await http.get(url, headers: {
        "Authorization": "bearer $accessToken",
      });

      List listProvinsi = jsonDecode(response.body);
      result = listProvinsi.map((item) => LocationModel(item)).toList();
    } catch (e) {
      showSnackBar(context, text: "Couldn't get data provinsi");
    }

    return result;
  }

  getKota(context, provinsiName) async {
    List<LocationModel> result = [];

    try {
      var accessToken = await this.getPublicAccessToken();
      var model = 'res.country.city';
      var domain = "[['state_id','=ilike','%$provinsiName%']]";
      var fields = "['id', 'name']";
      var order = 'name asc';
      var url = Uri.https(apiClient.apiDomain, "api/search_read/$model", {
        "domain": domain,
        "order": order,
        "fields": fields,
      });
      var response = await http.get(url, headers: {
        "Authorization": "bearer $accessToken",
      });

      List listKota = jsonDecode(response.body);
      result = listKota.map((item) => LocationModel(item)).toList();
    } catch (e) {
      showSnackBar(context, text: "Couldn't get data kota");
    }

    return result;
  }

  getKecamatan(context, kotaName) async {
    List<LocationModel> result = [];

    try {
      var accessToken = await this.getPublicAccessToken();
      var model = 'res.kecamatan';
      var domain = "[['kabupaten_id','=ilike','%$kotaName%']]";
      var fields = "['id', 'name']";
      var order = 'name asc';
      var url = Uri.https(apiClient.apiDomain, "api/search_read/$model", {
        // "domain": domain,
        "order": order,
        "fields": fields,
      });
      var response = await http.get(url, headers: {
        "Authorization": "bearer $accessToken",
      });

      List listKecamatan = jsonDecode(response.body);
      result = listKecamatan.map((item) => LocationModel(item)).toList();
    } catch (e) {
      showSnackBar(context, text: "Couldn't get data kecamatan");
    }

    return result;
  }

  Future<String> postRegistration(context, RegistrationModel data) async {
    try {
      var url = Uri.https(
          apiClient.apiDomain, "/pi/register/");
      var dataJson = data.toJson();
      print(url);
      var response = await http.post(url, body: {
        "args": "[$dataJson]",
      });
      print(response.body);
      var responseJson = jsonDecode(response.body);
      return responseJson["token"];
    } catch (e) {
      showSnackBar(context,
          text: "Gagal melakukan registrasi", backgroundColor: Colors.red);
      return "";
    }
  }

  Future<bool> sendForgotPasswordRequest(context, String email) async {
    bool success = false;

    try {
      var accessToken = await this.getPublicAccessToken();
      var url = Uri.https(
          apiClient.apiDomain, "/api/call/res.users/external_forgot_password");
      var response = await http.post(url, headers: {
        "Authorization": "bearer $accessToken",
      }, body: {
        "args": "['$email']",
      });
      print(response.body);
      var responseJson = jsonDecode(response.body);
      if (responseJson['email'] == null) {
        showSnackBar(
          context,
          text: "Email belum terdaftar",
          backgroundColor: Colors.red,
        );
        return false;
      }
      success = true;
    } catch (e) {
      showSnackBar(
        context,
        text: "Gagal mengirimkan forgot password request",
        backgroundColor: Colors.red,
      );
    }

    return success;
  }

  Future<int> validateResetPassword(context, tokenResetPassword) async {
    int uid = 0;

    try {
      var accessToken = await this.getPublicAccessToken();
      var url = Uri.https(apiClient.apiDomain,
          "/api/call/res.users/external_check_reset_token");
      var response = await http.post(url, headers: {
        "Authorization": "bearer $accessToken",
      }, body: {
        "args": "['$tokenResetPassword']",
      });
      // print(response.body);
      var responseJson = jsonDecode(response.body);
      if (responseJson['data']!['uid'] != null)
        uid = responseJson['data']!['uid'];
    } catch (e) {
      // showSnackBar(
      //   context,
      //   text: "Gagal memuat data",
      //   backgroundColor: Colors.red,
      // );
    }

    return uid;
  }

  Future<bool> doResetPassword(context, int uid, String newPassword) async {
    bool success = false;

    try {
      var accessToken = await this.getPublicAccessToken();
      var url = Uri.https(apiClient.apiDomain,
          "/api/call/res.users/test_indo5_direct_reset_password");
      var response = await http.post(url, headers: {
        "Authorization": "bearer $accessToken",
      }, body: {
        "args": "['$newPassword', $uid]",
      });
      // print(response.body);
      // print("status: ${response.statusCode}");
      success = response.statusCode == 200;
      // var responseJson = jsonDecode(response.body);
    } catch (e) {
      showSnackBar(
        context,
        text: "Gagal mereset password",
        backgroundColor: Colors.red,
      );
    }

    return success;
  }
}
