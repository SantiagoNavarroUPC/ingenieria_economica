import 'package:flutter/material.dart';
import 'package:ingenieria_economica/pages/notebook/page_amortizacion.dart';
import '../../../controller/controller_opciones_firebase.dart';
import '../../../size_config.dart';

class Banner3 extends StatelessWidget {
  const Banner3({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, TasaInteresRetorno.routeName);
      },
      child: Container(
        width: double.infinity,
        margin: EdgeInsets.all(getProportionateScreenWidth(20)),
        padding: EdgeInsets.symmetric(
          horizontal: getProportionateScreenWidth(15),
          vertical: getProportionateScreenWidth(15),
        ),
        decoration: BoxDecoration(
          color: const Color(0xFFA61C5C),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: getProportionateScreenHeight(10)),
            FutureBuilder<List<Map<String, dynamic>>>(
              future: ControlOpciones().listaropciones3(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }
                if (snapshot.hasError) {
                  return const Center(child: Text('Error al cargar'));
                }
                final opciones = snapshot.data ?? [];

                if (opciones.isEmpty) {
                  return const Center(
                      child: Text('No hay informacion disponibles'));
                }

                final opcion = opciones[0];

                return Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (opcion.containsKey('foto'))
                      ClipRRect(
                        borderRadius: BorderRadius.circular(15),
                        child: Image.network(
                          opcion['foto'],
                          width: getProportionateScreenWidth(80),
                          height: getProportionateScreenWidth(80),
                          fit: BoxFit.cover,
                        ),
                      ),
                    SizedBox(width: getProportionateScreenWidth(10)),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            opcion['nombre'],
                            style: TextStyle(
                              fontFamily: 'Inter',
                              fontWeight: FontWeight.w700,
                              color: Colors.white,
                              fontSize: getProportionateScreenWidth(18),
                            ),
                          ),
                          SizedBox(height: getProportionateScreenHeight(5)),
                          Text(
                            opcion['descripcion'],
                            style: TextStyle(
                              fontFamily: 'Inter',
                              fontWeight: FontWeight.w400,
                              color: Colors.white,
                              fontSize: getProportionateScreenWidth(14),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
