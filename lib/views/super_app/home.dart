import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:test_indo5/utils/checkJwt.dart';
import 'package:test_indo5/widgets/super_app/appbar.dart';

class SuperAppHomeScreen extends StatefulWidget {
  const SuperAppHomeScreen({Key? key}) : super(key: key);

  @override
  _SuperAppHomeScreenState createState() => _SuperAppHomeScreenState();
}

class _SuperAppHomeScreenState extends State<SuperAppHomeScreen> {

  UtilsJwt utilsJwt = UtilsJwt();
  final storage = FlutterSecureStorage();
  String name = "";

  @override
  void initState() {
    super.initState();

    Future.delayed(Duration.zero, () async {
      var jwt = await storage.read(key: "jwt");
      setState(() {
        name = utilsJwt.getValueJwt(jwt)["username"];
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        appBar: SuperAppAppBar(),
        body: Container(
          color: Colors.black,
          height: double.infinity,
          child: Container(
            decoration: BoxDecoration(
              color: Colors.black,
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment(0.5, -0.4),
                stops: [0.0, 00],
                colors: [
                  Colors.orange.shade400,
                  Colors.orange.shade400,
                ],
                tileMode: TileMode.decal,
              ),
            ),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    "Selamat Datang ${name}!",
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.black
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
