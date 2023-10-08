import 'package:flutter/material.dart';
import 'components/body.dart';

class VerProfile extends StatelessWidget {
  static String routeName = "/ver_profile";

  const VerProfile({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Mi perfil'),
      ),
      body: const Body(),
    );
  }
}
