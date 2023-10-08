import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import '../data/firebase/peticiones_user_firebase.dart';

class ControlUserAuth extends GetxController {
  final _response = Rxn();
  final _mensaje = "".obs;
  final Rxn<UserCredential> _usuario = Rxn<UserCredential>();

  Future<void> crearUser(String email, String pass) async {
    _response.value = await Peticioneslogin.crearRegistroEmail(email, pass);
    print(_response.value);
    await controlUser(_response.value);
  }

  Future<void> ingresarUser(String email, String pass) async {
    _response.value = await Peticioneslogin.ingresarEmail(email, pass);
    print(_response.value);
    await controlUser(_response.value);
  }

  Future<void> controlUser(dynamic respuesta) async {
    if (respuesta == null) {
      _mensaje.value = "No se encontro usuario";
    } else if (respuesta == "1" || respuesta == "2") {
      _mensaje.value = "Usuario o contraseña incorrecta";
    } else {
      _mensaje.value = "Proceso realizado correctamente";
      _usuario.value = respuesta;
    }
  }

  Future<void> creaUserG() async {
    _response.value = await Peticioneslogin.signInWithGoogle();
    print(_response.value);
    await controlUser(_response.value);
  }

  dynamic get estadoUser => _response.value;
  String get mensajesUser => _mensaje.value;
  UserCredential? get userValido => _usuario.value;
}
