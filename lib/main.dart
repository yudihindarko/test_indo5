// @dart=2.9
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:test_indo5/api/main.dart';
import 'package:test_indo5/config/routes/main.dart';
import 'package:provider/provider.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:uni_links/uni_links.dart';

Future main() async {
  await dotenv.load(fileName: ".env");
  APIClient(); // Initialize singleton API for the first time
  runApp(
    MyApp(),
  );
}

class MyApp extends StatefulWidget {
  // This widget is the root of your application.
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final GlobalKey<NavigatorState> navigatorKey =
      new GlobalKey<NavigatorState>();

  @override
  void initState() {
    super.initState();
    initializeAppLink();
  }

  initializeAppLink() async {
    Uri initialUri = await getInitialUri();
    print("initial link: $initialUri");

    if (initialUri != null) handleAppLinkCall(initialUri);

    uriLinkStream.listen((Uri uri) {
      print("got link: $uri");
      handleAppLinkCall(uri);
    }, onError: (err) {
      print('got err: $err');
    });
  }

  handleAppLinkCall(Uri uri) {
    String path = uri.path;
    Map parameters = uri.queryParameters;

    switch (path) {
      case "/web/reset_password":
        navigatorKey.currentState
            .pushNamed('/resetpassword', arguments: parameters);
        break;
      default:
    }
  }

  @override
  Widget build(BuildContext context) {
    return GlobalLoaderOverlay(
      overlayColor: Colors.black,
      overlayOpacity: 0.8,
      child: MaterialApp(
        title: 'test_indo5',
        initialRoute: '/',
        routes: mainRoutes,
        navigatorKey: navigatorKey,
      ),
    );
  }
}
