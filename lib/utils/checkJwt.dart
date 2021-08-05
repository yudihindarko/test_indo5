import 'package:jwt_decode/jwt_decode.dart';

class UtilsJwt {
  checkJwt(token) {
    Map<String, dynamic> payload = Jwt.parseJwt(token);
    print(payload);
    DateTime? expiryDate = Jwt.getExpiryDate(token);
    print(expiryDate);
    bool isExpired = Jwt.isExpired(token);
    print(isExpired);
    if (!isExpired) {
      return true;
    } else {
      return false;
    }
  }

  getValueJwt(token){
    Map<String, dynamic> payload = Jwt.parseJwt(token);
    return payload;
  }
}