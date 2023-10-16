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
  TextEditingController _periodoGraciaController = TextEditingController();
  TextEditingController _cuotaxController = TextEditingController();
  TextEditingController _cuotapositivaController = TextEditingController();
  TextEditingController _cuotanegativaController = TextEditingController();

  String selectedTypetasa = 'Pago por Periodo';
  String selectedRateType = 'Meses';
  String selectedType = 'Aritmetico';
  String selectedFuncion = 'Creciente';
  bool isPeriodoGraciaEnabled = false;
  bool iscuotaEnabled = false;
  bool interpolacionEnabled = false;

  List<String> typeGradiente = [
    'Aritmetico',
    'Geometrico',
  ];

  List<String> typefuncion = [
    'Creciente',
    'Decreciente',
  ];

  List<String> rateTypes = [
    'Dias',
    'Meses',
    'Trimestres',
    'Cuatrimestres',
    'Semestres',
    'Años',
  ];

  List<String> tasaTypes = [
    'Pago por Periodo',
    'Nominal',
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
              Row(
                children: [
                  Text('Tipo de Funcion: '), // Etiqueta
                  DropdownButton<String>(
                    value: selectedFuncion,
                    onChanged: (String? newValue) {
                      setState(() {
                        selectedFuncion = newValue!;
                      });
                    },
                    items: typefuncion
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
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Flexible(
                    flex: 1,
                    child: TextField(
                      controller: _tasaController,
                      keyboardType: TextInputType.number,
                      decoration:
                          InputDecoration(labelText: 'Tasa de interes %'),
                    ),
                  ),
                  SizedBox(width: 10),
                  Flexible(
                    flex: 1,
                    child: Row(
                      children: [
                        DropdownButton<String>(
                          value: selectedTypetasa,
                          onChanged: (String? newValue) {
                            setState(() {
                              selectedTypetasa = newValue!;
                            });
                          },
                          items: tasaTypes
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
              Row(
                children: <Widget>[
                  Checkbox(
                    value: isPeriodoGraciaEnabled,
                    onChanged: (value) {
                      setState(() {
                        isPeriodoGraciaEnabled = value!;
                        if (!isPeriodoGraciaEnabled) {
                          _periodoGraciaController.clear();
                        }
                      });
                    },
                  ),
                  Text('Activar Período de Gracia'),
                ],
              ),
              if (isPeriodoGraciaEnabled)
                TextField(
                  controller: _periodoGraciaController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    labelText: 'Periodo de Gracia',
                  ),
                ),
              Row(
                children: <Widget>[
                  Checkbox(
                    value: iscuotaEnabled,
                    onChanged: (value) {
                      setState(() {
                        iscuotaEnabled = value!;
                        if (!iscuotaEnabled) {
                          _cuotaxController.clear();
                        }
                      });
                    },
                  ),
                  Text('Calcular valor de la cuota x'),
                ],
              ),
              if (iscuotaEnabled)
                TextField(
                  controller: _cuotaxController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    labelText: 'Cuota X',
                  ),
                ),
              Row(
                children: <Widget>[
                  Checkbox(
                    value: interpolacionEnabled,
                    onChanged: (value) {
                      setState(() {
                        interpolacionEnabled = value!;
                        if (!interpolacionEnabled) {
                          _cuotapositivaController.clear();
                          _cuotanegativaController.clear();
                        }
                      });
                    },
                  ),
                  Text('Interpolacion'),
                ],
              ),
              if (interpolacionEnabled)
                Row(
                  children: [
                    Expanded(
                      child: Padding(
                        padding: EdgeInsets.only(
                            right:
                                8.0), // Ajusta el valor para la distancia deseada
                        child: TextField(
                          controller: _cuotapositivaController,
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(labelText: 'Valor Menor'),
                        ),
                      ),
                    ),
                    Expanded(
                      child: TextField(
                        controller: _cuotanegativaController,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(labelText: 'Valor Mayor'),
                      ),
                    ),
                  ],
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
    _calculartasa();
    if (selectedType == 'Aritmetico') {
      if (_cuotasController.text.isEmpty &&
          _valorPresenteController.text.isEmpty) {
        _calcularPresenteInfinitoAritmetico();
      } else {
        _calcularPresenteAritmetico();
        _calcularFuturoAritmetico();
      }
      if (_cuotaxController.text.isNotEmpty) {
        _calcularcuotax();
      }
    } else if (selectedType == 'Geometrico') {
      if (_cuotasController.text.isEmpty &&
          _valorPresenteController.text.isEmpty) {
        _calcularPresenteInfinitoGeometrico();
      } else {
        _calcularPresenteGeometrico();
        _calcularFuturoGeometrico();
      }
    }
  }

  void _calculartasa() {
    double tasa = double.tryParse(_tasaController.text) ?? 0;
    tasa = tasa / 100;
    if (selectedTypetasa == 'Nominal') {
      if (selectedRateType == 'Dias') {
        tasa = pow((1 + tasa), 1 / 30).toDouble() - 1;
        tasa = tasa * 100;
        _tasaController.text = tasa.toStringAsFixed(2);
        setState(() {
          selectedTypetasa = 'Pago por Periodo';
        });
      }
      if (selectedRateType == 'Meses') {
        tasa = pow((1 + tasa), 1 / 12).toDouble() - 1;
        tasa = tasa * 100;
        _tasaController.text = tasa.toStringAsFixed(2);
        setState(() {
          selectedTypetasa = 'Pago por Periodo';
        });
      }
      if (selectedRateType == 'Trimestres') {
        tasa = pow((1 + tasa), 1 / 4).toDouble() - 1;
        tasa = tasa * 100;
        _tasaController.text = tasa.toStringAsFixed(2);
        setState(() {
          selectedTypetasa = 'Pago por Periodo';
        });
      }
      if (selectedRateType == 'Cuatrimestres') {
        tasa = pow((1 + tasa), 1 / 3).toDouble() - 1;
        tasa = tasa * 100;
        _tasaController.text = tasa.toStringAsFixed(2);
        setState(() {
          selectedTypetasa = 'Pago por Periodo';
        });
      }
      if (selectedRateType == 'Semestres') {
        tasa = pow((1 + tasa), 1 / 2).toDouble() - 1;
        tasa = tasa * 100;
        _tasaController.text = tasa.toStringAsFixed(2);
        setState(() {
          selectedTypetasa = 'Pago por Periodo';
        });
      }
      if (selectedRateType == 'Años') {
        tasa = pow((1 + tasa), 1).toDouble() - 1;
        tasa = tasa * 100;
        _tasaController.text = tasa.toStringAsFixed(2);
        setState(() {
          selectedTypetasa = 'Pago por Periodo';
        });
      }
    }
  }

  void _calcularcuotax() {
    double ingresos = double.tryParse(_ingresosController.text) ?? 0;
    double aumento = double.tryParse(_aumentoController.text) ?? 0;
    double cuotax = double.tryParse(_cuotaxController.text) ?? 0.0;
    if (selectedFuncion == 'Creciente') {
      cuotax = ingresos + (cuotax - 1) * aumento;
      _cuotaxController.text = cuotax.toStringAsFixed(2);
    } else {
      cuotax = ingresos - (cuotax - 1) * aumento;
      _cuotaxController.text = cuotax.toStringAsFixed(2);
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
      if (selectedFuncion == 'Creciente') {
        valorPresente = valorPresentePositivo;
        valorPresente = valorPresente.abs();
        _valorPresenteController.text = valorPresente.toStringAsFixed(2);
      } else {
        valorPresente = valorPresenteNegativo;
        valorPresente = valorPresente.abs();
        _valorPresenteController.text = valorPresente.toStringAsFixed(2);
      }
    }
    if (_ingresosController.text.isEmpty) {
      if (selectedFuncion == 'Creciente') {
        ingresos = (valorPresente -
                (aumento / tasa) *
                    (((1 - pow((1 + tasa), -cuotas)) / tasa) -
                        (cuotas / pow((1 + tasa), cuotas)))) /
            ((1 - pow((1 + tasa), -cuotas)) / tasa);

        _ingresosController.text = ingresos.toStringAsFixed(2);
      } else {
        ingresos = (valorPresente +
                (aumento / tasa) *
                    (((1 - pow((1 + tasa), -cuotas)) / tasa) -
                        (cuotas / pow((1 + tasa), cuotas)))) /
            ((1 - pow((1 + tasa), -cuotas)) / tasa);

        _ingresosController.text = ingresos.toStringAsFixed(2);
      }
    }
    if (_cuotasController.text.isEmpty) {
      double cuotapositiva =
          double.tryParse(_cuotapositivaController.text) ?? 0;
      double cuotanegativa =
          double.tryParse(_cuotanegativaController.text) ?? 0;
      if (selectedFuncion == 'Creciente') {
        valorPresentePositivo = ingresos *
                ((((pow((1 + tasa), cuotapositiva)) - 1) /
                    (tasa * (pow((1 + tasa), cuotapositiva))))) +
            ((aumento / tasa) *
                (((pow((1 + tasa), cuotapositiva) - 1)) /
                        (tasa * pow((1 + tasa), cuotapositiva)) -
                    (cuotapositiva / pow((1 + tasa), cuotapositiva))));
        valorPresenteNegativo = ingresos *
                ((((pow((1 + tasa), cuotanegativa)) - 1) /
                    (tasa * (pow((1 + tasa), cuotanegativa))))) +
            ((aumento / tasa) *
                (((pow((1 + tasa), cuotanegativa) - 1)) /
                        (tasa * pow((1 + tasa), cuotanegativa)) -
                    (cuotanegativa / pow((1 + tasa), cuotanegativa))));
        double diferenciapositiva = valorPresente - valorPresentePositivo;
        double diferencianegativa = valorPresente - valorPresenteNegativo;
        cuotas = cuotapositiva +
            ((0 - diferenciapositiva) * (cuotanegativa - cuotapositiva)) /
                (diferencianegativa - diferenciapositiva);
        cuotas = cuotas.roundToDouble();
        _cuotasController.text = cuotas.toStringAsFixed(2);
      } else {
        valorPresentePositivo = ingresos *
                ((((pow((1 + tasa), cuotapositiva)) - 1) /
                    (tasa * (pow((1 + tasa), cuotapositiva))))) -
            ((aumento / tasa) *
                (((pow((1 + tasa), cuotapositiva) - 1)) /
                        (tasa * pow((1 + tasa), cuotapositiva)) -
                    (cuotapositiva / pow((1 + tasa), cuotapositiva))));
        valorPresenteNegativo = ingresos *
                ((((pow((1 + tasa), cuotanegativa)) - 1) /
                    (tasa * (pow((1 + tasa), cuotanegativa))))) -
            ((aumento / tasa) *
                (((pow((1 + tasa), cuotanegativa) - 1)) /
                        (tasa * pow((1 + tasa), cuotanegativa)) -
                    (cuotanegativa / pow((1 + tasa), cuotanegativa))));
        double diferenciapositiva = valorPresente - valorPresentePositivo;
        double diferencianegativa = valorPresente - valorPresenteNegativo;
        cuotas = cuotapositiva +
            ((0 - diferenciapositiva) * (cuotanegativa - cuotapositiva)) /
                (diferencianegativa - diferenciapositiva);
        cuotas = cuotas.roundToDouble();
        _cuotasController.text = cuotas.toStringAsFixed(2);
      }
    }
    if (_aumentoController.text.isEmpty) {
      if (selectedFuncion == 'Creciente') {
        aumento = ((valorPresente -
                    (ingresos * ((1 - pow(1 + tasa, -cuotas)) / tasa))) /
                (((1 - pow(1 + tasa, -cuotas)) / (tasa)) -
                    (cuotas / (pow(1 + tasa, cuotas))))) *
            tasa;
        _aumentoController.text = aumento.toStringAsFixed(2);
      } else {
        aumento = ((valorPresente +
                    (ingresos * ((1 - pow(1 + tasa, -cuotas)) / tasa))) /
                (((1 - pow(1 + tasa, -cuotas)) / (tasa)) -
                    (cuotas / (pow(1 + tasa, cuotas))))) *
            tasa;
        _aumentoController.text = aumento.toStringAsFixed(2);
      }
    }
    if (_tasaController.text.isEmpty) {
      double tasapositiva = double.tryParse(_cuotapositivaController.text) ?? 0;
      double tasanegativa = double.tryParse(_cuotanegativaController.text) ?? 0;
      tasapositiva = tasapositiva / 100;
      tasanegativa = tasanegativa / 100;
      if (selectedFuncion == 'Creciente') {
        valorPresentePositivo = ingresos *
                ((((pow((1 + tasapositiva), cuotas)) - 1) /
                    (tasapositiva * (pow((1 + tasapositiva), cuotas))))) +
            ((aumento / tasapositiva) *
                (((pow((1 + tasapositiva), cuotas) - 1)) /
                        (tasapositiva * pow((1 + tasapositiva), cuotas)) -
                    (cuotas / pow((1 + tasapositiva), cuotas))));
        valorPresenteNegativo = ingresos *
                ((((pow((1 + tasanegativa), cuotas)) - 1) /
                    (tasanegativa * (pow((1 + tasanegativa), cuotas))))) +
            ((aumento / tasanegativa) *
                (((pow((1 + tasanegativa), cuotas) - 1)) /
                        (tasanegativa * pow((1 + tasanegativa), cuotas)) -
                    (cuotas / pow((1 + tasanegativa), cuotas))));
        double diferenciapositiva = valorPresente - valorPresentePositivo;
        double diferencianegativa = valorPresente - valorPresenteNegativo;
        tasa = tasapositiva +
            ((0 - diferenciapositiva) * (tasanegativa - tasapositiva)) /
                (diferencianegativa - diferenciapositiva);
        tasa = tasa * 100;
        _tasaController.text = tasa.toStringAsFixed(2);
      } else {
        valorPresentePositivo = ingresos *
                ((((pow((1 + tasapositiva), cuotas)) - 1) /
                    (tasapositiva * (pow((1 + tasapositiva), cuotas))))) -
            ((aumento / tasapositiva) *
                (((pow((1 + tasapositiva), cuotas) - 1)) /
                        (tasapositiva * pow((1 + tasapositiva), cuotas)) -
                    (cuotas / pow((1 + tasapositiva), cuotas))));
        valorPresenteNegativo = ingresos *
                ((((pow((1 + tasanegativa), cuotas)) - 1) /
                    (tasanegativa * (pow((1 + tasanegativa), cuotas))))) -
            ((aumento / tasanegativa) *
                (((pow((1 + tasanegativa), cuotas) - 1)) /
                        (tasanegativa * pow((1 + tasanegativa), cuotas)) -
                    (cuotas / pow((1 + tasanegativa), cuotas))));
        double diferenciapositiva = valorPresente - valorPresentePositivo;
        double diferencianegativa = valorPresente - valorPresenteNegativo;
        tasa = tasapositiva +
            ((0 - diferenciapositiva) * (tasanegativa - tasapositiva)) /
                (diferencianegativa - diferenciapositiva);
        tasa = tasa * 100;
        _tasaController.text = tasa.toStringAsFixed(2);
      }
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
          ingresos * ((((pow((1 + tasa), cuotas)) - 1) / (tasa))) -
              ((aumento / tasa) *
                  (((pow((1 + tasa), cuotas) - 1)) / (tasa) - (cuotas)));
      if (selectedFuncion == 'Creciente') {
        valorFuturo = valorFuturoPositivo;
        valorFuturo = valorFuturo.abs();
        _valorFuturoController.text = valorFuturo.toStringAsFixed(2);
      } else {
        valorFuturo = valorFuturoNegativo;
        valorFuturo = valorFuturo.abs();
        _valorFuturoController.text = valorFuturo.toStringAsFixed(2);
      }
      if (_valorPresenteController.text.isEmpty) {
        double valorPresente =
            double.tryParse(_valorPresenteController.text) ?? 0;
        valorPresente = valorFuturo / pow((1 + tasa), cuotas);
        valorPresente = valorPresente.abs();
        _valorPresenteController.text = valorPresente.toStringAsFixed(2);
      }
    }
  }

  void _calcularPresenteGeometrico() {
    double ingresos = double.tryParse(_ingresosController.text) ?? 0;
    double tasaNormal = double.tryParse(_tasaController.text) ?? 0;
    double tasa = tasaNormal / 100;
    double aumentoNormal = double.tryParse(_aumentoController.text) ?? 0;
    double aumento = aumentoNormal / 100;
    double valorPresente = double.tryParse(_valorPresenteController.text) ?? 0;
    double cuotas = double.tryParse(_cuotasController.text) ?? 0;

    if (_valorPresenteController.text.isEmpty) {
      if (aumentoNormal == tasaNormal) {
        valorPresente = ((cuotas * ingresos) / (1 + tasa));
      } else {
        valorPresente = ((ingresos) / (aumento - tasa)) *
            (((pow((1 + aumento), cuotas)) / (pow((1 + tasa), cuotas))) - 1);
      }
      _valorPresenteController.text = valorPresente.toStringAsFixed(2);
    }
    if (_ingresosController.text.isEmpty) {
      double pg = double.tryParse(_periodoGraciaController.text) ?? 0;
      cuotas = cuotas - pg;
      ingresos = (((pow((1 + tasa), cuotas) - pow((1 + aumento), cuotas)) /
              ((tasa - aumento) * pow((1 + tasa), cuotas))) /
          (valorPresente * pow((1 + tasa), pg)));
      _ingresosController.text = ingresos.toStringAsFixed(2);
    }
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
    setState(() {
      selectedFuncion = 'Creciente';
    });
    setState(() {
      selectedTypetasa = 'Pago por Periodo';
    });
    _ingresosController.clear();
    _aumentoController.clear();
    _tasaController.clear();
    _cuotasController.clear();
    _valorPresenteController.clear();
    _valorFuturoController.clear();
  }
}
