import 'package:flutter/material.dart';

import 'components/body.dart';

class SignIn extends StatelessWidget {
  static String routeName = "/sign_in";

  const SignIn({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          "Iniciar sesión",
        ),
      ),
      body: const Body(),
    );
  }
}
