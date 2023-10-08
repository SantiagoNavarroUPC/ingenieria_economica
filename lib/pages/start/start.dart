import 'package:flutter/material.dart';
import 'package:ingenieria_economica/pages/start/components/body.dart';
import '../../size_config.dart';

class StartApp extends StatelessWidget {
  static String routeName = "/inicio";

  const StartApp({super.key});

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return const Scaffold(
      body: Body(),
      backgroundColor: Color.fromARGB(255, 255, 255, 255),
    );
  }
}
