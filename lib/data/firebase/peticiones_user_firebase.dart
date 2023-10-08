import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class Peticioneslogin {
  static final FirebaseAuth auth = FirebaseAuth.instance;

//Registro usando correo electronico y contraseña
  static Future<dynamic> crearRegistroEmail(dynamic email, dynamic pass) async {
    try {
      UserCredential usuario = await auth.createUserWithEmailAndPassword(
          email: email, password: pass);
      print("funcion " + usuario.toString());
      return usuario;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print('Contraseña Debil');
        return '1';
      } else if (e.code == 'email-already-in-use') {
        print('Correo ya existe');
        return '2';
      }
    } catch (e) {
      print(e);
    }
  }

  static Future<dynamic> ingresarEmail(dynamic email, dynamic pass) async {
    try {
      UserCredential usuario =
          await auth.signInWithEmailAndPassword(email: email, password: pass);
      return usuario;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print('Correo no encontrado');
        return '1';
      } else if (e.code == 'wrong-password') {
        print('Contraseña incorrecta');
        return '2';
      }
    }
  }

  static Future<dynamic> signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await GoogleSignIn(
        scopes: [
          'email',
          'profile',
          GoogleAuthProvider.PROVIDER_ID,
        ],
      ).signIn();

      final GoogleSignInAuthentication googleAuth =
          await googleUser!.authentication;

      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      UserCredential usuario =
          await FirebaseAuth.instance.signInWithCredential(credential);

      // Get the email of the authenticated Google user
      final userEmail = googleUser.email;

      return usuario;
    } on FirebaseAuthException catch (e) {
      print(e);
      return null;
    }
  }
}
