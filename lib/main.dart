import 'package:firebase_app_check/firebase_app_check.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:workshopnew/screen/mainFeedPage.dart';
import 'package:workshopnew/screen/menu.dart';
import 'auth/authenticationService.dart';
import 'firebase_options.dart';
import 'screen/homePage.dart';
import 'package:provider/provider.dart'; // Import the provider package


void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize Firebase
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await FirebaseAppCheck.instance.activate(
    androidProvider: AndroidProvider.playIntegrity,
  );

  runApp(
    ChangeNotifierProvider(
      create: (_) => AuthenticationService(FirebaseAuth.instance),
      child: MyApp(),
    ),
  );
}
class MyApp extends StatelessWidget {
  MyApp({super.key});

  static GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
  Widget getScreenId() {
    return StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (BuildContext context, snapshot) {
          if (snapshot.hasData) {
            return MainFeedPage (currentUserId: snapshot.data!.uid);
          } else {
            return HomePage();
          }
        });
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      navigatorKey: navigatorKey,
      title: 'Flutter Demo',
      theme: ThemeData(
        useMaterial3: true,
      ),
      home: getScreenId(),
    );
  }
}