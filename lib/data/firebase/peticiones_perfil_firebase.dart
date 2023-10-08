import 'dart:async';
import 'dart:io';
import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart' as fs;
import 'package:firebase_auth/firebase_auth.dart' as auth;

class PeticionesP {
  static final fs.FirebaseStorage storage = fs.FirebaseStorage.instance;
  static final FirebaseFirestore _db = FirebaseFirestore.instance;
  static final auth.FirebaseAuth _auth = auth.FirebaseAuth.instance;

  static Future<void> crearperfil(Map<String, dynamic> perfil) async {
    final user = _auth.currentUser;
    if (user == null) {
      throw Exception('Usuario no autenticado');
    }
    final uid = user.uid;
    final perfilRef = _db.collection('perfiles').doc(uid);
    final perfilSnapshot = await perfilRef.get();
    if (!perfilSnapshot.exists) {
      await perfilRef.set(perfil);
    } else {
      await perfilRef.update(perfil);
    }
  }

  static Future<String> subirImagen(File imagen, String nombre) async {
    final referencia = storage.ref().child(nombre);
    final subida = referencia.putFile(imagen);
    final snapshot = await subida.whenComplete(() {});
    final rutaImagen = await snapshot.ref.getDownloadURL();
    return rutaImagen;
  }

  static Future<void> crearcatalogo(
      Map<String, dynamic> catalogo, File imagen) async {
    final user = _auth.currentUser;
    if (user == null) {
      throw Exception('Usuario no autenticado');
    }
    final uid = user.uid;
    final perfilRef = _db.collection('perfiles').doc(uid);
    final perfilSnapshot = await perfilRef.get();
    final random = Random();
    final nombre = 'perfil_${random.nextInt(100000000)}';

    if (!perfilSnapshot.exists) {
      catalogo['foto'] = await subirImagen(imagen, nombre);
      await perfilRef.set(catalogo);
    } else {
      final perfilData = perfilSnapshot.data() as Map<String, dynamic>;
      final fotoAnterior = perfilData['foto'] ?? '';
      if (fotoAnterior.isNotEmpty) {
        // Eliminar la imagen anterior del storage (opcional)
        final referenciaAnterior = storage.refFromURL(fotoAnterior);
        await referenciaAnterior.delete();
      }
      final Map<String, dynamic> nuevoPerfil = {
        ...perfilData,
        'foto': await subirImagen(imagen, nombre),
      };
      await perfilRef.set(nuevoPerfil);
    }
  }

  static Future<Map<String, dynamic>> obtenerPerfil() async {
    final user = _auth.currentUser;
    if (user == null) {
      throw Exception('Usuario no autenticado');
    }
    final uid = user.uid;
    final perfilRef = _db.collection('perfiles').doc(uid);
    final perfilSnapshot = await perfilRef.get();
    if (perfilSnapshot.exists) {
      final perfilData = perfilSnapshot.data();
      return perfilData as Map<String, dynamic>;
    } else {
      throw Exception('No se encontró el perfil del usuario');
    }
  }

  static Future<String> obtenerFoto() async {
    final user = _auth.currentUser;
    if (user == null) {
      throw Exception('Usuario no autenticado');
    }
    final uid = user.uid;
    final perfilesRef = _db.collection('perfiles').doc(uid);
    final perfilSnapshot = await perfilesRef.get();
    if (perfilSnapshot.exists) {
      final perfilData = perfilSnapshot.data();
      final fotoperfil = perfilData!['foto'];
      return fotoperfil;
    } else {
      throw Exception('No se encontró el perfil del usuario');
    }
  }
}
