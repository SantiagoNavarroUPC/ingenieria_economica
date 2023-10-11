import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'dart:math';

enum TiempoUnit { meses, anos }

class Gradiente extends StatefulWidget {
  static String routeName = "/interes_compuesto";

  @override
  _GradienteState createState() => _GradienteState();
}

class _GradienteState extends State<Gradiente> {
  TextEditingController _ingresosController = TextEditingController();
  TextEditingController _aumentoController = TextEditingController();
  TextEditingController _tasaController = TextEditingController();
  TextEditingController _cuotasController = TextEditingController();
  TextEditingController _valorPresenteController = TextEditingController();
  TextEditingController _valorFuturoController = TextEditingController();
  String selectedRateType = 'Meses';
  String selectedType = 'Aritmetico';

  List<String> typeGradiente = [
    'Aritmetico',
    'Geometrico',
  ];

  List<String> rateTypes = [
    'Dias',
    'Meses',
    'Trimestres',
    'Cuatrimestres',
    'Semestres',
    'Años',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Calculadora de Gradientes'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                children: [
                  Text('Tipo de Gradiente: '), // Etiqueta
                  DropdownButton<String>(
                    value: selectedType,
                    onChanged: (String? newValue) {
                      setState(() {
                        selectedType = newValue!;
                      });
                    },
                    items: typeGradiente
                        .map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                  ),
                ],
              ),
              TextField(
                controller: _ingresosController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(labelText: 'Ingreso'),
              ),
              SizedBox(height: 10),
              TextField(
                controller: _aumentoController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(labelText: 'Aumento'),
              ),
              SizedBox(height: 10),
              TextField(
                controller: _tasaController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(labelText: 'Tasa de interés (%)'),
              ),
              SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Flexible(
                    flex: 1,
                    child: TextField(
                      controller: _cuotasController,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(labelText: 'Cuotas'),
                    ),
                  ),
                  SizedBox(width: 10),
                  Flexible(
                    flex: 1,
                    child: Row(
                      children: [
                        DropdownButton<String>(
                          value: selectedRateType,
                          onChanged: (String? newValue) {
                            setState(() {
                              selectedRateType = newValue!;
                            });
                          },
                          items: rateTypes
                              .map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(height: 10),
              TextField(
                controller: _valorPresenteController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(labelText: 'Valor Presente'),
              ),
              SizedBox(height: 10),
              TextField(
                controller: _valorFuturoController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(labelText: 'Valor Futuro'),
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

  void _calcular() {
    if (selectedType == 'Aritmetico') {
      if (_cuotasController.text.isEmpty) {
        _calcularPresenteInfinitoAritmetico();
      } else {
        _calcularPresenteAritmetico();
        _calcularFuturoAritmetico();
      }
    } else if (selectedType == 'Geometrico') {
      if (_cuotasController.text.isEmpty) {
        _calcularPresenteInfinitoGeometrico();
      } else {
        _calcularPresenteGeometrico();
        _calcularFuturoGeometrico();
      }
    }
  }

  void _calcularPresenteInfinitoAritmetico() {
    double ingresos = double.tryParse(_ingresosController.text) ?? 0;
    double tasaNormal = double.tryParse(_tasaController.text) ?? 0;
    double tasa = tasaNormal / 100;
    double aumento = double.tryParse(_aumentoController.text) ?? 0;
    double valorPresente = double.tryParse(_valorPresenteController.text) ?? 0;
    if (_valorPresenteController.text.isEmpty) {
      valorPresente = (ingresos / tasa) + (aumento / pow(tasa, 2));
      _valorPresenteController.text = valorPresente.toStringAsFixed(2);
    } else if (_ingresosController.text.isEmpty) {
      ingresos = (valorPresente - (aumento / pow(tasa, 2))) * tasa;
      _ingresosController.text = ingresos.toStringAsFixed(2);
    } else if (_aumentoController.text.isEmpty) {
      aumento = (valorPresente - (ingresos / tasa)) * pow(tasa, 2);
      _aumentoController.text = aumento.toStringAsFixed(2);
    } else if (_tasaController.text.isEmpty) {
      tasa = sqrt(aumento / valorPresente + 1);
      _tasaController.text = tasa.toStringAsFixed(2);
    }
  }

  void _calcularPresenteAritmetico() {
    double ingresos = double.tryParse(_ingresosController.text) ?? 0;
    double tasaNormal = double.tryParse(_tasaController.text) ?? 0;
    double tasa = tasaNormal / 100;
    double aumento = double.tryParse(_aumentoController.text) ?? 0;
    double valorPresente = double.tryParse(_valorPresenteController.text) ?? 0;
    double cuotas = double.tryParse(_cuotasController.text) ?? 0;
    double valorPresentePositivo = 0.0;
    double valorPresenteNegativo = 0.0;
    if (_valorPresenteController.text.isEmpty) {
      valorPresentePositivo = ingresos *
              ((((pow((1 + tasa), cuotas)) - 1) /
                  (tasa * (pow((1 + tasa), cuotas))))) +
          ((aumento / tasa) *
              (((pow((1 + tasa), cuotas) - 1)) /
                      (tasa * pow((1 + tasa), cuotas)) -
                  (cuotas / pow((1 + tasa), cuotas))));
      valorPresenteNegativo = ingresos *
              ((((pow((1 + tasa), cuotas)) - 1) /
                  (tasa * (pow((1 + tasa), cuotas))))) -
          ((aumento / tasa) *
              (((pow((1 + tasa), cuotas) - 1)) /
                      (tasa * pow((1 + tasa), cuotas)) -
                  (cuotas / pow((1 + tasa), cuotas))));
      if (valorPresentePositivo > 0) {
        valorPresente = valorPresentePositivo;
      } else {
        valorPresente = valorPresenteNegativo;
      }
      _valorPresenteController.text = valorPresente.toStringAsFixed(2);
    }
  }

  void _calcularFuturoAritmetico() {
    double ingresos = double.tryParse(_ingresosController.text) ?? 0;
    double tasaNormal = double.tryParse(_tasaController.text) ?? 0;
    double tasa = tasaNormal / 100;
    double aumento = double.tryParse(_aumentoController.text) ?? 0;
    double valorFuturo = double.tryParse(_valorFuturoController.text) ?? 0;
    double cuotas = double.tryParse(_cuotasController.text) ?? 0;
    double valorFuturoPositivo = 0.0;
    double valorFuturoNegativo = 0.0;
    if (_valorFuturoController.text.isEmpty) {
      valorFuturoPositivo =
          ingresos * ((((pow((1 + tasa), cuotas)) - 1) / (tasa))) +
              ((aumento / tasa) *
                  (((pow((1 + tasa), cuotas) - 1)) / (tasa) - (cuotas)));
      valorFuturoNegativo =
          ingresos * ((((pow((1 + tasa), cuotas)) - 1) / (tasa))) +
              ((aumento / tasa) *
                  (((pow((1 + tasa), cuotas) - 1)) / (tasa) - (cuotas)));
      if (valorFuturoPositivo > 0) {
        valorFuturo = valorFuturoPositivo;
      } else {
        valorFuturo = valorFuturoNegativo;
      }
      _valorFuturoController.text = valorFuturo.toStringAsFixed(2);
    }
  }

  void _calcularPresenteGeometrico() {
    double ingresos = double.tryParse(_ingresosController.text) ?? 0;
    double tasaNormal = double.tryParse(_tasaController.text) ?? 0;
    double tasa = tasaNormal / 100;
    double aumentoNormal = double.tryParse(_aumentoController.text) ?? 0;
    double aumento = aumentoNormal / 100;
    double valorPresente = double.tryParse(_valorFuturoController.text) ?? 0;
    double cuotas = double.tryParse(_cuotasController.text) ?? 0;
    if (aumentoNormal == tasaNormal) {
      valorPresente = ((cuotas * ingresos) / (1 + tasa));
    } else {
      valorPresente = ((ingresos) / (aumento - tasa)) *
          (((pow((1 + aumento), cuotas)) / (pow((1 + tasa), cuotas))) - 1);
    }
    _valorPresenteController.text = valorPresente.toStringAsFixed(2);
  }

  void _calcularFuturoGeometrico() {
    double ingresos = double.tryParse(_ingresosController.text) ?? 0;
    double tasaNormal = double.tryParse(_tasaController.text) ?? 0;
    double tasa = tasaNormal / 100;
    double aumentoNormal = double.tryParse(_aumentoController.text) ?? 0;
    double aumento = aumentoNormal / 100;
    double valorFuturo = double.tryParse(_valorFuturoController.text) ?? 0;
    double cuotas = double.tryParse(_cuotasController.text) ?? 0;
    if (aumentoNormal == tasaNormal) {
      valorFuturo = ((ingresos) / (pow((1 + tasa), (-cuotas + 1))));
    } else {
      valorFuturo = ((ingresos) / (aumento - tasa)) *
          (((pow((1 + aumento), cuotas)) - (pow((1 + tasa), cuotas))));
    }
    _valorFuturoController.text = valorFuturo.toStringAsFixed(2);
  }

  void _calcularPresenteInfinitoGeometrico() {
    double ingresos = double.tryParse(_ingresosController.text) ?? 0;
    double tasaNormal = double.tryParse(_tasaController.text) ?? 0;
    double tasa = tasaNormal / 100;
    double aumentoNormal = double.tryParse(_aumentoController.text) ?? 0;
    double aumento = aumentoNormal / 100;
    double valorPresente = double.tryParse(_valorFuturoController.text) ?? 0;
    if (aumentoNormal < tasaNormal) {
      valorPresente = (ingresos) / (tasa - aumento);
      _valorPresenteController.text = valorPresente.toStringAsFixed(2);
    }
  }

  void _limpiarCampos() {
    setState(() {
      selectedRateType = 'Meses';
    });
    setState(() {
      selectedType = 'Aritmetico';
    });
    _ingresosController.clear();
    _aumentoController.clear();
    _tasaController.clear();
    _cuotasController.clear();
    _valorPresenteController.clear();
    _valorFuturoController.clear();
    setState(() {});
  }
}
