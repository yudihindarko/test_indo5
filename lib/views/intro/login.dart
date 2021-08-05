import 'package:flutter/material.dart';
import 'package:jwt_decode/jwt_decode.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:test_indo5/api/main.dart';
import 'package:test_indo5/utils/checkJwt.dart';
import 'package:test_indo5/utils/showSnackBar.dart';
import 'package:test_indo5/widgets/intro/global_styled_text.dart';
import 'package:test_indo5/widgets/intro/bodytemplate.dart';
import 'package:test_indo5/widgets/intro/button.dart';
import 'package:test_indo5/widgets/intro/linktext.dart';
import 'package:test_indo5/widgets/intro/textfield.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  String username = '';
  String password = '';
  bool touched = false;
  String errorMessage = '';
  final storage = FlutterSecureStorage();
  UtilsJwt utilsJwt = UtilsJwt();
  GlobalKey<FormState> formkey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () async {
      var jwt = await storage.read(key: "jwt");
      print(jwt);
      if (jwt != '' && jwt != null) {
        Navigator.of(context).pushNamedAndRemoveUntil(
          '/superapp/home',
          (Route<dynamic> route) => false,
        );
      }
    });
  }

  void _doLogin(context) async {
    formkey.currentState?.save();
    hideSnackBar(context);
    try {
      showSnackBar(
        context,
        text: "Logging in...",
        backgroundColor: Colors.blue,
      );
      var respons = await APIClient().loginAndGetToken(username, password);
      hideSnackBar(context);
      if (utilsJwt.checkJwt(respons)) {
        storage.write(key: "jwt", value: respons);
        Navigator.of(context).pushNamedAndRemoveUntil(
          '/superapp/home',
          (Route<dynamic> route) => false,
        );
      }
    } catch (e) {
      hideSnackBar(context);
      showSnackBar(
        context,
        text: "Login failed, please check your username and password",
        backgroundColor: Colors.red,
      );
    }
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IntroBodyTemplate(
        children: [
          Form(
            key: formkey,
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: 30),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  GlobalStyledText(
                    'Email',
                    fontSize: 17,
                    fontWeight: FontWeight.bold,
                  ),
                  SizedBox(height: 5),
                  TextFieldIntro(
                    labelText: "Username / E-mail",
                    onSaved: (data) => username = data.toString(),
                  ),
                  SizedBox(height: 20),
                  GlobalStyledText(
                    'Password',
                    fontSize: 17,
                    fontWeight: FontWeight.bold,
                  ),
                  SizedBox(height: 5),
                  TextFieldIntro(
                    labelText: "Password",
                    type: TextFieldIntroType.password,
                    onSaved: (data) => password = data.toString(),
                  ),
                  SizedBox(height: 20),
                  ButtonIntro(
                    label: "Login",
                    onPressed: () {
                      _doLogin(context);
                    },
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              GlobalStyledText(
                "Don't have an account? ",
                color: Colors.white,
                fontSize: 16,
              ),
              LinkText(
                text: "Register Now",
                onTap: () {
                  Navigator.pushNamed(context, '/register');
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}
