import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'dart:math';

import 'package:flutter/material.dart';

class TasaInteresRetorno extends StatefulWidget {
  static String routeName = "/amortizacion";

  @override
  _TasaInteresRetornoState createState() => _TasaInteresRetornoState();
}

class _TasaInteresRetornoState extends State<TasaInteresRetorno> {
  TextEditingController _inversionController = TextEditingController();
  TextEditingController _tirController = TextEditingController();
  TextEditingController _vanController = TextEditingController();
  late String resultado;
  int selectedValue = 1;
  List<TextEditingController> flujosControllers =
      List.generate(5, (index) => TextEditingController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Calculadora de TIR'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              TextField(
                controller: _inversionController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(labelText: 'Inversión Inicial'),
              ),
              Row(
                children: [
                  Text('  Cantidad de Pagos de flujo: '), // Etiqueta
                  DropdownButton<int>(
                    value: selectedValue,
                    items: List<DropdownMenuItem<int>>.generate(
                      5,
                      (int index) {
                        return DropdownMenuItem<int>(
                          value: index + 1,
                          child: Text('${index + 1}'),
                        );
                      },
                    ),
                    onChanged: (int? newValue) {
                      if (newValue != null) {
                        setState(() {
                          selectedValue = newValue;
                        });
                      }
                    },
                  ),
                ],
              ), // Moverlo aquí
              Column(
                children: List<Widget>.generate(
                  selectedValue,
                  (int index) {
                    int campoNumero = index + 1;
                    return Column(
                      children: [
                        TextField(
                          controller: flujosControllers[index],
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                              labelText: 'Pago de flujo $campoNumero'),
                        ),
                        SizedBox(height: 10), // Espacio vertical de 5 píxeles
                      ],
                    );
                  },
                ),
              ),
              SizedBox(height: 10),
              TextField(
                controller: _tirController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(labelText: 'TIR %'),
              ),
              SizedBox(height: 10),
              TextField(
                controller: _vanController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(labelText: 'VAN'),
              ),
              SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton.icon(
                    onPressed: _calcular,
                    style: ElevatedButton.styleFrom(
                      primary: Color.fromARGB(255, 33, 143, 21),
                    ),
                    icon: Icon(Icons.calculate),
                    label: Text('Calcular', style: TextStyle(fontSize: 18)),
                  ),
                  ElevatedButton.icon(
                    onPressed: _limpiarCampos,
                    style: ElevatedButton.styleFrom(
                      primary: Colors.grey,
                    ),
                    icon: Icon(Icons.clear),
                    label: Text('Limpiar', style: TextStyle(fontSize: 18)),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  _calcular() {
    if (_tirController.text.isEmpty) {
      _calcularTIR();
      _calcularVAN();
    } else if (_vanController.text.isEmpty) {
      _calcularVAN();
    }
  }

  _calcularVAN() {
    double tir = double.tryParse(_tirController.text) ?? 0.0;
    double inversion = double.tryParse(_inversionController.text) ?? 0;

    List<double> flujos = List.generate(selectedValue, (index) {
      return double.parse(flujosControllers[index].text);
    });
    tir = tir / 100;
    double van = -inversion; // Inicializa el VAN con la inversión inicial.

    for (int i = 0; i < flujos.length; i++) {
      van += flujos[i] / pow(1 + tir, i + 1);
    }
    _vanController.text = van.toStringAsFixed(4);
    resultado = analizarResultadoTIR(van);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(resultado),
        backgroundColor: Color.fromARGB(255, 33, 143, 21),
      ),
    );
  }

  String analizarResultadoTIR(double tir) {
    if (tir > 0) {
      return "El proyecto es aceptable. VAN > 0";
    } else if (tir < 0) {
      return "El proyecto se rechaza. VAN < 0";
    } else {
      return "El proyecto es indiferente. VAN = 0";
    }
  }

  _calcularTIR() {
    double inversion = double.parse(_inversionController.text);
    double aumento = 0;
    List<double> flujos = List.generate(selectedValue, (index) {
      return double.parse(flujosControllers[index].text);
    });
    double tir = _calcularTIRMetodoNewton(inversion, aumento, flujos);
    tir = tir * 100;
    _tirController.text = tir.toStringAsFixed(4);
  }

  double _calcularTIRMetodoNewton(
      double inversion, double aumento, List<double> flujos) {
    double tirGuess = 0.1; // Suposición inicial de la TIR
    double tolerance = 0.0001; // Tolerancia para la convergencia
    int maxIterations = 1000; // Número máximo de iteraciones

    for (int i = 0; i < maxIterations; i++) {
      double van = _calcularVANConTIR(inversion, aumento, flujos, tirGuess);
      double vanDerivative =
          _calcularVANDerivadaConTIR(inversion, aumento, flujos, tirGuess);

      tirGuess = tirGuess - van / vanDerivative;

      if (van.abs() < tolerance) {
        return tirGuess;
      }
    }

    return 0; // No se encontró una solución
  }

  double _calcularVANConTIR(
      double inversion, double aumento, List<double> flujos, double tir) {
    double van = -inversion; // Inicializa el VAN con la inversión inicial

    for (int i = 0; i < flujos.length; i++) {
      van += flujos[i] / pow(1 + tir, i + 1);
    }

    return van;
  }

  double _calcularVANDerivadaConTIR(
      double inversion, double aumento, List<double> flujos, double tir) {
    double vanDerivative = 0.0;

    for (int i = 0; i < flujos.length; i++) {
      vanDerivative += -(i + 1) * flujos[i] / pow(1 + tir, i + 2);
    }

    return vanDerivative;
  }

  void _limpiarCampos() {
    for (var controller in flujosControllers) {
      controller.clear();
    }

    setState(() {
      selectedValue = 1;
    });
    _inversionController.clear();
    _tirController.clear();
    _vanController.clear();
  }
}
