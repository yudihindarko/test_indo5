import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class APIClient {
  // Static information
  String apiDomain = '';
  String apiDBName = '';
  String clientId = '';
  String clientSecret = '';
  String accessToken = '';
  String refreshToken = '';
  String login = '';
  String partnerId = '';

  APIClient._internal() {
    apiDomain = dotenv.env['API_DOMAIN'].toString();
    apiDBName = dotenv.env['API_DB_NAME'].toString();
    SharedPreferences.getInstance().then((prefs) {
      clientId = prefs.getString('clientId') ?? '';
      clientSecret = prefs.getString('clientSecret') ?? '';
      accessToken = prefs.getString('accessToken') ?? '';
      refreshToken = prefs.getString('refreshToken') ?? '';
      login = prefs.getString('login') ?? '';
      partnerId = prefs.getString('partnerId') ?? '';
    });
  }

  static final APIClient _instance = APIClient._internal();

  factory APIClient() {
    return _instance;
  }

  _doRefreshTokenIfNecessary(http.Response response, repeatCallback) async {
    if (response.statusCode != 401) {
      return response;
    }
    var uri = Uri.https(apiDomain, "/api/authentication/oauth2/token");
    var refreshResponse = await http.post(uri, body: {
      "grant_type": "refresh_token",
      "refresh_token": refreshToken,
      "client_id": clientId,
      "client_secret": clientSecret,
    });
    Map refreshResponseMap = jsonDecode(refreshResponse.body);
    accessToken = refreshResponseMap['access_token'];
    refreshToken = refreshResponseMap['refresh_token'];
    var prefs = await SharedPreferences.getInstance();
    prefs.setString('access_token', accessToken);
    prefs.setString('refresh_token', refreshToken);
    return await repeatCallback();
  }

  Future<http.Response> doGetRequest(String uriPath,
      [Map<String, dynamic>? params]) async {
    var uri = Uri.https(apiDomain, uriPath, params);

    var response = await http.get(uri, headers: {
      "Authorization": "bearer " + accessToken,
    });
    return await _doRefreshTokenIfNecessary(
      response,
      () => doGetRequest(uriPath, params),
    );
  }

  Future<http.Response> doPostRequest(String uriPath,
      [Map<String, dynamic>? params]) async {
    var uri = Uri.https(apiDomain, uriPath);

    var response = await http.post(uri, headers: {
      "Authorization": "bearer " + accessToken,
    }, body: params);
    return await _doRefreshTokenIfNecessary(
      response,
      () => doPostRequest(uriPath, params),
    );
  }

  Future<String> loginAndGetToken(String username, String password) async {
    var uriGetToken =
        Uri.https(apiDomain.toString(), "/pi/login/");
    Codec<String, String> stringToBase64 = utf8.fuse(base64);
    String encoded = stringToBase64.encode(password);
    var response = await http.post(uriGetToken, body: {
      "login": username,
      "password": encoded,
    });

    var token = jsonDecode(response.body);
    return token["token"];
  }

  Future<void> logout() async {
    var prefs = await SharedPreferences.getInstance();
    prefs.setString('clientId', '');
    prefs.setString('clientSecret', '');
    prefs.setString('accessToken', '');
    prefs.setString('refreshToken', '');
    prefs.setString('login', '');
    prefs.setString('partnerId', '');
    accessToken = '';
    refreshToken = '';
    clientId = '';
    clientSecret = '';
    login = '';
    partnerId = '';
  }
}
