import 'package:flutter/material.dart';

import 'components/body.dart';

class Profile extends StatefulWidget {
  static String routeName = "/profile";

  const Profile({Key? key}) : super(key: key);

  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Perfil"),
      ),
      body: Body(refreshIndicatorKey: UniqueKey()),
    );
  }
}
