import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:ingenieria_economica/pages/start/start.dart';
import 'package:ingenieria_economica/routes.dart';
import 'package:ingenieria_economica/theme.dart';
import 'controller/controller_opciones_firebase.dart';
import 'controller/controller_perfil_firebase.dart';
import 'controller/controller_user_firebase.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  GetPlatform.isWeb
      ? await Firebase.initializeApp(
          options: const FirebaseOptions(
              apiKey: "AIzaSyDgWzOM8s0-a_k_YYcgv9Y8u1ThLsxmG3U",
              authDomain: "ingenieriaeconomica-44b06.firebaseapp.com",
              projectId: "ingenieriaeconomica-44b06",
              storageBucket: "ingenieriaeconomica-44b06.appspot.com",
              messagingSenderId: "217285942840",
              appId: "1:217285942840:android:a1ba272e1784ccfa03d0cd"))
      : await Firebase.initializeApp();
  Get.put(ControlOpciones());
  Get.put(ControlUserAuth());
  Get.put(ControlUserPerfil());
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'APP IC LOS TC',
      theme: theme(),
      initialRoute: StartApp.routeName,
      routes: routes,
    );
  }
}
