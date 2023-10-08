import 'dart:io';

import 'package:get/get.dart';
import '../data/firebase/peticiones_perfil_firebase.dart';

class ControlUserPerfil extends GetxController {
  Future<void> crearperfil(Map<String, dynamic> perfil) async {
    await PeticionesP.crearperfil(perfil);
  }

  Future<void> crearcatalogo(Map<String, dynamic> catalogo, File imagen) async {
    try {
      await PeticionesP.crearcatalogo(catalogo, imagen);
    } catch (error) {
      print(error);
    }
  }

  Future<String> obtenerFotoCatalogo() async {
    final perfiles = await PeticionesP.obtenerFoto();
    update();
    return perfiles;
  }

  Future<Map<String, dynamic>> obtenerPerfil() async {
    try {
      final perfil = await PeticionesP.obtenerPerfil();
      return perfil;
    } catch (error) {
      print(error);
      rethrow;
    }
  }
}
