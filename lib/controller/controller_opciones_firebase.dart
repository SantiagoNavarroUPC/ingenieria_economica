import 'package:get/get.dart';
import '../data/firebase/peticiones_opciones_firebase.dart';

class ControlOpciones extends GetxController {
  Future<List<Map<String, dynamic>>> listaropciones1() async {
    final opciones = await Peticiones.listarOpciones1();
    return opciones;
  }

  Future<List<Map<String, dynamic>>> listaropciones2() async {
    final opciones = await Peticiones.listarOpciones2();
    return opciones;
  }

  Future<List<Map<String, dynamic>>> listaropciones3() async {
    final opciones = await Peticiones.listarOpciones3();
    return opciones;
  }

  Future<List<Map<String, dynamic>>> listaropciones4() async {
    final opciones = await Peticiones.listarOpciones4();
    return opciones;
  }
}
