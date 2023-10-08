import 'package:flutter/material.dart';
import 'components/body.dart';

class UpdateProfile extends StatelessWidget {
  static String routeName = "/update_profile";

  const UpdateProfile({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Actualizar perfil'),
      ),
      body: const Body(),
    );
  }
}
