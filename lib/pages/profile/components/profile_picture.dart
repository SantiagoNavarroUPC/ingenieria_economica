import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import '../../../controller/controller_perfil_firebase.dart';

class ProfilePicture extends StatefulWidget {
  const ProfilePicture({
    Key? key,
    required Future<String> Function() refreshProfile,
  }) : super(key: key);

  @override
  _ProfilePictureState createState() => _ProfilePictureState();
}

class _ProfilePictureState extends State<ProfilePicture> {
  File? _imagenSeleccionada;
  bool subiendoImagen = false;
  ControlUserPerfil controlup = Get.find();

  Future<void> _seleccionarImagen() async {
    final imagenSeleccionada =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (imagenSeleccionada != null) {
      setState(() {
        _imagenSeleccionada = File(imagenSeleccionada.path);
      });
      _subirImagen();
    }
  }

  void _refreshProfileItems() {
    setState(() {
      actualizarFotoPerfil();
    });
  }

  Future<void> _subirImagen() async {
    if (_imagenSeleccionada != null && !subiendoImagen) {
      setState(() {
        subiendoImagen = true;
      });
      final controlador = Get.find<ControlUserPerfil>();
      final catalogo = {'foto': ''};
      catalogo['foto'] = _imagenSeleccionada!.path;

      try {
        await controlador.crearcatalogo(catalogo, _imagenSeleccionada!);
      } finally {
        setState(() {
          subiendoImagen = false;
        });
      }
    }
    _refreshProfileItems();
  }

  String _fotoPerfil = 'https://via.placeholder.com/150';

  void actualizarFotoPerfil() async {
    String urlImagen = await controlup.obtenerFotoCatalogo();
    setState(() {
      _fotoPerfil = urlImagen;
    });
  }

  @override
  void initState() {
    super.initState();
    actualizarFotoPerfil();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 115,
      width: 115,
      child: Stack(
        fit: StackFit.expand,
        clipBehavior: Clip.none,
        children: [
          CircleAvatar(
            backgroundImage: NetworkImage(_fotoPerfil),
          ),
          if (subiendoImagen)
            Positioned.fill(
              child: Container(
                color: Colors.black54,
                child: const Center(
                  child: CircularProgressIndicator(),
                ),
              ),
            ),
          Positioned(
            right: -16,
            bottom: 0,
            child: SizedBox(
              height: 46,
              width: 46,
              child: TextButton(
                style: TextButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(50),
                    side: const BorderSide(color: Colors.white),
                  ),
                  backgroundColor: const Color(0xFFF5F6F9),
                ),
                onPressed: () {
                  _opcionCamara(context);
                },
                child: SvgPicture.asset("assets/icons/Camera Icon.svg"),
              ),
            ),
          )
        ],
      ),
    );
  }

  void _opcionCamara(context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext bc) {
        return SafeArea(
          child: Wrap(
            children: <Widget>[
              ListTile(
                leading: const Icon(Icons.photo_library),
                title: const Text('Imagen de galería'),
                onTap: () {
                  _seleccionarImagen();
                  Navigator.of(context).pop();
                },
              ),
              ListTile(
                leading: const Icon(Icons.camera_alt),
                title: const Text('Tomar una foto'),
                onTap: () {
                  _tomarFoto();
                  Navigator.of(context).pop();
                },
              ),
            ],
          ),
        );
      },
    );
  }

  void _tomarFoto() async {
    final imagenSeleccionada =
        await ImagePicker().pickImage(source: ImageSource.camera);
    if (imagenSeleccionada != null) {
      setState(() {
        _imagenSeleccionada = File(imagenSeleccionada.path);
      });
      _subirImagen();
    }
  }
}
