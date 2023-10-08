import 'package:flutter/material.dart';

import 'components/body.dart';

class SignUp extends StatelessWidget {
  static String routeName = "/sign_up";

  const SignUp({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Registrarse"),
      ),
      body: const Body(),
    );
  }
}