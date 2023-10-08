import 'package:flutter/material.dart';

import 'components/body.dart';

class ForgotPassword extends StatelessWidget {
  static String routeName = "/forgot_password";

  const ForgotPassword({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Olvidé la contraseña"),
      ),
      body: const Body(),
    );
  }
}