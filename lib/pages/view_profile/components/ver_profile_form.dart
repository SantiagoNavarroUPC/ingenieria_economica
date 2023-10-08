import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../controller/controller_perfil_firebase.dart';
import '../../../size_config.dart';

class VerProfileForm extends StatefulWidget {
  const VerProfileForm({super.key});

  @override
  _VerProfileFormState createState() => _VerProfileFormState();
}

class _VerProfileFormState extends State<VerProfileForm> {
  ControlUserPerfil controlup = Get.find();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Map<String, dynamic>>(
      future: controlup.obtenerPerfil(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (snapshot.hasError) {
          return const Center(
            child: Text('Error al obtener el perfil'),
          );
        } else if (!snapshot.hasData) {
          return const Center(
            child: Text('No se encontró el perfil'),
          );
        } else {
          final perfil = snapshot.data!;
          final foto = perfil['foto'] as String?;
          final nombre = perfil['nombre'] as String?;
          final apellido = perfil['apellido'] as String?;
          final telefono = perfil['celular'] as String?;
          final direccion = perfil['direccion'] as String?;

          return Column(
            children: [
              SizedBox(height: getProportionateScreenHeight(20)),
              CircleAvatar(
                radius: 70,
                backgroundImage: NetworkImage(foto ?? ''),
              ),
              SizedBox(height: getProportionateScreenHeight(20)),
              Text(
                nombre ?? 'Nombre',
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: getProportionateScreenHeight(5)),
              Text(
                apellido ?? 'Apellido',
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: getProportionateScreenHeight(20)),
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Color.fromARGB(255, 33, 143, 21),
                    width: 2,
                  ),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: const [
                        Icon(
                          Icons.book,
                          size: 18,
                          color: Color.fromARGB(255, 33, 143, 21),
                        ),
                        SizedBox(width: 5),
                        Text(
                          'Datos personales',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Color.fromARGB(255, 33, 143, 21),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: getProportionateScreenHeight(10)),
                    Row(
                      children: [
                        const Icon(
                          Icons.person,
                          size: 18,
                        ),
                        const SizedBox(width: 5),
                        Text(
                          'Nombre: ${nombre ?? 'Nombre'}',
                          style: const TextStyle(
                            fontSize: 18,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: getProportionateScreenHeight(10)),
                    Row(
                      children: [
                        const Icon(
                          Icons.person,
                          size: 18,
                        ),
                        const SizedBox(width: 5),
                        Text(
                          'Apellido: ${apellido ?? 'Apellido'}',
                          style: const TextStyle(
                            fontSize: 18,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: getProportionateScreenHeight(10)),
                    Row(
                      children: [
                        const Icon(
                          Icons.phone,
                          size: 18,
                        ),
                        const SizedBox(width: 5),
                        Text(
                          'Teléfono: ${telefono ?? 'Teléfono'}',
                          style: const TextStyle(
                            fontSize: 18,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: getProportionateScreenHeight(10)),
                    Row(
                      children: [
                        const Icon(
                          Icons.home,
                          size: 18,
                        ),
                        const SizedBox(width: 5),
                        Flexible(
                          // o Expanded
                          child: Text(
                            'Dirección: ${direccion ?? 'Dirección'}',
                            style: const TextStyle(
                              fontSize: 18,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          );
        }
      },
    );
  }
}
