import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'dart:math';

enum TiempoUnit { meses, anos }

class InteresCompuesto extends StatefulWidget {
  static String routeName = "/interes_compuesto";

  @override
  _InteresCompuestoState createState() => _InteresCompuestoState();
}

class _InteresCompuestoState extends State<InteresCompuesto> {
  TextEditingController _capitalController = TextEditingController();
  TextEditingController _tasaController = TextEditingController();
  TextEditingController _mesesController = TextEditingController();
  TextEditingController _aniosController = TextEditingController();
  TextEditingController _diasController = TextEditingController();
  TextEditingController _interesCompuestoController = TextEditingController();
  TextEditingController _montoCompuestoController = TextEditingController();
  DateTime? _startDate;
  DateTime? _endDate;
  bool _calculateByDates = false;
  String selectedRateType = 'Diariamente'; // Valor predeterminado

  List<String> rateTypes = [
    'Diariamente',
    'Mensualmente',
    'Trimestralmente',
    'Cuatrimestralmente',
    'Semestralmente',
    'Anualmente',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Calculadora de Interés Compuesto'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            TextField(
              controller: _capitalController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(labelText: 'Capital'),
            ),
            SizedBox(height: 10),
            TextField(
              controller: _tasaController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(labelText: 'Tasa de interés (%)'),
            ),
            Row(
              children: [
                SizedBox(width: 8),
                Text('Se capitaliza: '), // Etiqueta
                DropdownButton<String>(
                  value: selectedRateType,
                  onChanged: (String? newValue) {
                    setState(() {
                      selectedRateType = newValue!;
                    });
                  },
                  items:
                      rateTypes.map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                ),
              ],
            ),
            _calculateByDates
                ? Column(
                    children: [
                      GestureDetector(
                        onTap: () async {
                          _startDate = await _selectDate();
                          setState(() {});
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey),
                            borderRadius: BorderRadius.circular(5.0),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              _startDate != null
                                  ? DateFormat('dd/MM/yyyy').format(_startDate!)
                                  : 'Seleccionar Fecha Inicial',
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 10),
                      GestureDetector(
                        onTap: () async {
                          _endDate = await _selectDate();
                          setState(() {});
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey),
                            borderRadius: BorderRadius.circular(5.0),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              _endDate != null
                                  ? DateFormat('dd/MM/yyyy').format(_endDate!)
                                  : 'Seleccionar Fecha Final',
                            ),
                          ),
                        ),
                      ),
                    ],
                  )
                : Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Flexible(
                        child: TextField(
                          controller: _aniosController,
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(labelText: 'Años'),
                        ),
                      ),
                      Flexible(
                        child: TextField(
                          controller: _mesesController,
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(labelText: 'Meses'),
                        ),
                      ),
                      Flexible(
                        child: TextField(
                          controller: _diasController,
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(labelText: 'Días'),
                        ),
                      ),
                    ],
                  ),
            Row(
              children: [
                Checkbox(
                  value: _calculateByDates,
                  onChanged: (value) {
                    setState(() {
                      _calculateByDates = value!;
                      _mesesController.clear();
                      _aniosController.clear();
                      _diasController.clear();
                    });
                  },
                ),
                Text('Calcular por fechas'),
              ],
            ),
            TextField(
              controller: _interesCompuestoController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(labelText: 'Interes Compuesto'),
            ),
            SizedBox(height: 10),
            TextField(
              controller: _montoCompuestoController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(labelText: 'Monto Compuesto'),
            ),
            SizedBox(height: 8),
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
    );
  }

  Future<DateTime?> _selectDate() async {
    return await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
  }

  void _calculardiaconfechas() {
    if (_calculateByDates) {
      if (_startDate != null && _endDate != null) {
        Duration difference = _endDate!.difference(_startDate!);
        int totalDays = difference.inDays;

        _aniosController.text = (totalDays ~/ 365).toString();
        _mesesController.text = ((totalDays % 365) ~/ 30).toString();
        _diasController.text = (totalDays % 30).toString();
      }
    }
  }

  void _calcularSinMonto() {
    _calcularMonto();
    _calcularInteresesconMonto();
  }

  void _calcularConMonto() {
    if (_aniosController.text.isEmpty &&
        _mesesController.text.isEmpty &&
        _diasController.text.isEmpty) {
      _calcularTiempo();
    } else if (_capitalController.text.isEmpty) {
      _calcularCapital();
    } else if (_tasaController.text.isEmpty) {
      _calcularTasa();
    }
    _calcularInteresesconMonto();
  }

  void _calcular() {
    _calculardiaconfechas();
    if (_montoCompuestoController.text.isEmpty) {
      _calcularSinMonto();
    } else {
      _calcularConMonto();
    }
  }

  void _calcularMonto() {
    double capital = double.tryParse(_capitalController.text) ?? 0;
    double tasa = double.tryParse(_tasaController.text) ?? 0;
    int anios = int.tryParse(_aniosController.text) ?? 0;
    int meses = int.tryParse(_mesesController.text) ?? 0;
    int dias = int.tryParse(_diasController.text) ?? 0;
    int totalDias = (anios * 365) + (meses * 30) + dias;
    if (selectedRateType == 'Diariamente') {
      double monto = capital * pow(1 + (tasa / 100), totalDias);
      _montoCompuestoController.text = monto.toStringAsFixed(2);
    }
    if (selectedRateType == 'Mensualmente') {
      double monto = capital * pow(1 + (tasa / 100), (totalDias / 30));
      _montoCompuestoController.text = monto.toStringAsFixed(2);
    }
    if (selectedRateType == 'Trimestralmente') {
      double monto = capital * pow(1 + (tasa / 100), (totalDias / 90));
      _montoCompuestoController.text = monto.toStringAsFixed(2);
    }
    if (selectedRateType == 'Cuatrimestralmente') {
      double monto = capital * pow(1 + (tasa / 100), (totalDias / 120));
      _montoCompuestoController.text = monto.toStringAsFixed(2);
    }
    if (selectedRateType == 'Semestralmente') {
      double monto = capital * pow(1 + (tasa / 100), (totalDias / 182.5));
      _montoCompuestoController.text = monto.toStringAsFixed(2);
    }
    if (selectedRateType == 'Anualmente') {
      double monto = capital * pow(1 + (tasa / 100), (totalDias / 365));
      _montoCompuestoController.text = monto.toStringAsFixed(2);
    }
  }

  void _calcularTiempo() {
    double capital = double.tryParse(_capitalController.text) ?? 0;
    double tasa = double.tryParse(_tasaController.text) ?? 0;
    double monto = double.tryParse(_montoCompuestoController.text) ?? 0;
    if (selectedRateType == 'Diariamente') {
      double tiempoEnDias = (log(monto) - log(capital)) / log(1 + (tasa / 100));
      int anios = (tiempoEnDias / 365).floor();
      int meses = ((tiempoEnDias - (anios * 365)) / 30).floor();
      int dias = (tiempoEnDias - (anios * 365) - (meses * 30)).floor();

      _aniosController.text = anios.toString();
      _mesesController.text = meses.toString();
      _diasController.text = dias.toString();
    }
    if (selectedRateType == 'Mensualmente') {
      double tiempoEnDias =
          ((30) * (log(monto) - log(capital))) / log(1 + (tasa / 100));
      int anios = (tiempoEnDias / 365).floor();
      int meses = ((tiempoEnDias - (anios * 365)) / 30).floor();
      int dias = (tiempoEnDias - (anios * 365) - (meses * 30)).floor();

      _aniosController.text = anios.toString();
      _mesesController.text = meses.toString();
      _diasController.text = dias.toString();
    }
    if (selectedRateType == 'Trimestralmente') {
      double tiempoEnDias =
          ((90) * (log(monto) - log(capital))) / log(1 + (tasa / 100));
      int anios = (tiempoEnDias / 365).floor();
      int meses = ((tiempoEnDias - (anios * 365)) / 30).floor();
      int dias = (tiempoEnDias - (anios * 365) - (meses * 30)).floor();

      _aniosController.text = anios.toString();
      _mesesController.text = meses.toString();
      _diasController.text = dias.toString();
    }
    if (selectedRateType == 'Cuatrimestralmente') {
      double tiempoEnDias =
          ((120) * (log(monto) - log(capital))) / log(1 + (tasa / 100));
      int anios = (tiempoEnDias / 365).floor();
      int meses = ((tiempoEnDias - (anios * 365)) / 30).floor();
      int dias = (tiempoEnDias - (anios * 365) - (meses * 30)).floor();

      _aniosController.text = anios.toString();
      _mesesController.text = meses.toString();
      _diasController.text = dias.toString();
    }
    if (selectedRateType == 'Semestralmente') {
      double tiempoEnDias =
          ((182.5) * (log(monto) - log(capital))) / log(1 + (tasa / 100));
      int anios = (tiempoEnDias / 365).floor();
      int meses = ((tiempoEnDias - (anios * 365)) / 30).floor();
      int dias = (tiempoEnDias - (anios * 365) - (meses * 30)).floor();

      _aniosController.text = anios.toString();
      _mesesController.text = meses.toString();
      _diasController.text = dias.toString();
    }
    if (selectedRateType == 'Anualmente') {
      double tiempoEnDias =
          ((365) * (log(monto) - log(capital))) / log(1 + (tasa / 100));
      int anios = (tiempoEnDias / 365).floor();
      int meses = ((tiempoEnDias - (anios * 365)) / 30).floor();
      int dias = (tiempoEnDias - (anios * 365) - (meses * 30)).floor();

      _aniosController.text = anios.toString();
      _mesesController.text = meses.toString();
      _diasController.text = dias.toString();
    }
  }

  void _calcularCapital() {
    double monto = double.tryParse(_montoCompuestoController.text) ?? 0;
    double tasa = double.tryParse(_tasaController.text) ?? 0;
    int anios = int.tryParse(_aniosController.text) ?? 0;
    int meses = int.tryParse(_mesesController.text) ?? 0;
    int dias = int.tryParse(_diasController.text) ?? 0;
    int totalDias = (anios * 365) + (meses * 30) + dias;
    if (selectedRateType == 'Diariamente') {
      double capital = monto / (pow(1 + (tasa / 100), totalDias / 1));
      _capitalController.text = capital.toStringAsFixed(2);
    }
    if (selectedRateType == 'Mensualmente') {
      double capital = monto / (pow(1 + (tasa / 100), totalDias / 30));
      _capitalController.text = capital.toStringAsFixed(2);
    }
    if (selectedRateType == 'Trimestralmente') {
      double capital = monto / (pow(1 + (tasa / 100), totalDias / 90));
      _capitalController.text = capital.toStringAsFixed(2);
    }
    if (selectedRateType == 'Cuatrimestralmente') {
      double capital = monto / (pow(1 + (tasa / 100), totalDias / 120));
      _capitalController.text = capital.toStringAsFixed(2);
    }
    if (selectedRateType == 'Semestralmente') {
      double capital = monto / (pow(1 + (tasa / 100), totalDias / 182.5));
      _capitalController.text = capital.toStringAsFixed(2);
    }
    if (selectedRateType == 'Anualmente') {
      double capital = monto / (pow(1 + (tasa / 100), totalDias / 365));
      _capitalController.text = capital.toStringAsFixed(2);
    }
  }

  void _calcularTasa() {
    double monto = double.tryParse(_montoCompuestoController.text) ?? 0;
    double capital = double.tryParse(_capitalController.text) ?? 0;
    int anios = int.tryParse(_aniosController.text) ?? 0;
    int meses = int.tryParse(_mesesController.text) ?? 0;
    int dias = int.tryParse(_diasController.text) ?? 0;
    int totalDias = (anios * 365) + (meses * 30) + dias;
    if (selectedRateType == 'Diariamente') {
      double tasa = (pow((monto / capital), (1 / (totalDias / 1))) - 1) * 100;
      _tasaController.text = tasa.toStringAsFixed(2);
    }
    if (selectedRateType == 'Mensualmente') {
      double tasa = (pow((monto / capital), (1 / (totalDias / 30))) - 1) * 100;
      _tasaController.text = tasa.toStringAsFixed(2);
    }
    if (selectedRateType == 'Trimestralmente') {
      double tasa = (pow((monto / capital), (1 / (totalDias / 90))) - 1) * 100;
      _tasaController.text = tasa.toStringAsFixed(2);
    }
    if (selectedRateType == 'Cuatrimestralmente') {
      double tasa = (pow((monto / capital), (1 / (totalDias / 120))) - 1) * 100;
      _tasaController.text = tasa.toStringAsFixed(2);
    }
    if (selectedRateType == 'Semestralmente') {
      double tasa =
          (pow((monto / capital), (1 / (totalDias / 182.5))) - 1) * 100;
      _tasaController.text = tasa.toStringAsFixed(2);
    }
    if (selectedRateType == 'Anualmente') {
      double tasa = (pow((monto / capital), (1 / (totalDias / 365))) - 1) * 100;
      _tasaController.text = tasa.toStringAsFixed(2);
    }
  }

  _calcularInteresesconMonto() {
    double capital = double.tryParse(_capitalController.text) ?? 0;
    double monto = double.tryParse(_montoCompuestoController.text) ?? 0;
    double interes = (monto) - (capital);
    _interesCompuestoController.text = interes.toStringAsFixed(2);
  }

  void _limpiarCampos() {
    setState(() {
      selectedRateType = 'Diariamente';
    });
    _capitalController.clear();
    _tasaController.clear();
    _mesesController.clear();
    _aniosController.clear();
    _diasController.clear();
    _interesCompuestoController.clear();
    _montoCompuestoController.clear();
    _startDate = null;
    _endDate = null;
    _calculateByDates = false;
    setState(() {});
  }
}
