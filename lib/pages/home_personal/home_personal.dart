import 'package:flutter/material.dart';
import '../home_personal/components/body.dart';
import '../profile/profile.dart';

class HomePersonal extends StatelessWidget {
  static String routeName = "/home_personal";

  const HomePersonal({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "Temario de ejercicios",
        ),
        //actions: [
        //IconButton(
        //icon: Icon(Icons.menu), // Ícono de hamburguesa
        //onPressed: () {
        //Navigator.pushNamed(context, Profile.routeName);
        //},
        //),
        //],
      ),
      body: Center(
        child: Body(),
      ),
    );
  }
}
