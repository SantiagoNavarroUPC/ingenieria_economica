import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart' as fs;
import 'package:firebase_auth/firebase_auth.dart' as auth;

class Peticiones {
  static final fs.FirebaseStorage storage = fs.FirebaseStorage.instance;
  static final FirebaseFirestore _db = FirebaseFirestore.instance;
  static final auth.FirebaseAuth _auth = auth.FirebaseAuth.instance;

  static Future<List<Map<String, dynamic>>> listarOpciones1() async {
    final user = _auth.currentUser;
    if (user == null) {
      throw Exception('Usuario no autenticado');
    }
    final promoRef = _db.collection('opcion1');
    final querySnapshot = await promoRef.get();
    final opciones = querySnapshot.docs.map((doc) => doc.data()).toList();
    return opciones;
  }

  static Future<List<Map<String, dynamic>>> listarOpciones2() async {
    final user = _auth.currentUser;
    if (user == null) {
      throw Exception('Usuario no autenticado');
    }
    final promoRef = _db.collection('opcion2');
    final querySnapshot = await promoRef.get();
    final opciones = querySnapshot.docs.map((doc) => doc.data()).toList();
    return opciones;
  }

  static Future<List<Map<String, dynamic>>> listarOpciones3() async {
    final user = _auth.currentUser;
    if (user == null) {
      throw Exception('Usuario no autenticado');
    }
    final promoRef = _db.collection('opcion3');
    final querySnapshot = await promoRef.get();
    final opciones = querySnapshot.docs.map((doc) => doc.data()).toList();
    return opciones;
  }

  static Future<List<Map<String, dynamic>>> listarOpciones4() async {
    final user = _auth.currentUser;
    if (user == null) {
      throw Exception('Usuario no autenticado');
    }
    final promoRef = _db.collection('opcion4');
    final querySnapshot = await promoRef.get();
    final opciones = querySnapshot.docs.map((doc) => doc.data()).toList();
    return opciones;
  }
}
