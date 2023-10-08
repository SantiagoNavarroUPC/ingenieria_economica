import 'package:flutter/material.dart';

import 'components/body.dart';

class CompleteProfile extends StatelessWidget {
  static String routeName = "/complete_profile";

  const CompleteProfile({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Registrarse'),
      ),
      body: const Body(),
    );
  }
}