import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class InteresSimple extends StatefulWidget {
  static String routeName = "/interes_simple";

  @override
  _InteresSimpleState createState() => _InteresSimpleState();
}

class _InteresSimpleState extends State<InteresSimple> {
  TextEditingController _capitalController = TextEditingController();
  TextEditingController _tasaController = TextEditingController();
  TextEditingController _mesesController = TextEditingController();
  TextEditingController _aniosController = TextEditingController();
  TextEditingController _diasController = TextEditingController();
  TextEditingController _interesesController = TextEditingController();
  TextEditingController _montoController = TextEditingController();
  DateTime? _startDate;
  DateTime? _endDate;
  bool _calculateByDates = false;
  String selectedRateType = 'Anualmente'; // Valor predeterminado

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
        title: Text('Calculadora de Interes Simple'),
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
              controller: _interesesController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(labelText: 'Interes Simple'),
            ),
            SizedBox(height: 10),
            TextField(
              controller: _montoController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(labelText: 'Monto Simple'),
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

/////-----Capitalizacion Simple-----/////////////
  void _calcularSinMonto() {
    if (_aniosController.text.isEmpty &&
        _mesesController.text.isEmpty &&
        _diasController.text.isEmpty) {
      _calcularTiempoSinMonto();
    } else if (_capitalController.text.isEmpty) {
      _calcularCapitalSinMonto();
    } else if (_tasaController.text.isEmpty) {
      _calcularTasaSinMonto();
    }
    _calcularMonto();
    _calcularInteresesconMonto();
  }

  void _calcularTiempoSinMonto() {
    double capital = double.tryParse(_capitalController.text) ?? 0;
    double tasa = double.tryParse(_tasaController.text) ?? 0;
    double intereses = double.tryParse(_interesesController.text) ?? 0;
    if (selectedRateType == 'Diariamente') {
      double tiempoEnDias =
          (intereses) / (capital * (tasa / 100) * 30) * (365 / 30);
      int anios = (tiempoEnDias / 365).floor();
      int meses = ((tiempoEnDias - (anios * 365)) / 30).floor();
      int dias = (tiempoEnDias - (anios * 365) - (meses * 30)).floor();

      _aniosController.text = anios.toString();
      _mesesController.text = meses.toString();
      _diasController.text = dias.toString();
    }
    if (selectedRateType == 'Mensualmente') {
      double tiempoEnDias = (intereses) / (capital * (tasa / 100) * 12 / 365);
      int anios = (tiempoEnDias / 365).floor();
      int meses = ((tiempoEnDias - (anios * 365)) / 30).floor();
      int dias = (tiempoEnDias - (anios * 365) - (meses * 30)).floor();

      _aniosController.text = anios.toString();
      _mesesController.text = meses.toString();
      _diasController.text = dias.toString();
    }
    if (selectedRateType == 'Trimestralmente') {
      double tiempoEnDias = (intereses) / (capital * (tasa / 100) * 4 / 365);
      int anios = (tiempoEnDias / 365).floor();
      int meses = ((tiempoEnDias - (anios * 365)) / 30).floor();
      int dias = (tiempoEnDias - (anios * 365) - (meses * 30)).floor();

      _aniosController.text = anios.toString();
      _mesesController.text = meses.toString();
      _diasController.text = dias.toString();
    }
    if (selectedRateType == 'Cuatrimestralmente') {
      double tiempoEnDias = (intereses) / (capital * (tasa / 100) * 3 / 365);
      int anios = (tiempoEnDias / 365).floor();
      int meses = ((tiempoEnDias - (anios * 365)) / 30).floor();
      int dias = (tiempoEnDias - (anios * 365) - (meses * 30)).floor();

      _aniosController.text = anios.toString();
      _mesesController.text = meses.toString();
      _diasController.text = dias.toString();
    }
    if (selectedRateType == 'Semestralmente') {
      double tiempoEnDias = (intereses) / (capital * (tasa / 100) * 2 / 365);
      int anios = (tiempoEnDias / 365).floor();
      int meses = ((tiempoEnDias - (anios * 365)) / 30).floor();
      int dias = (tiempoEnDias - (anios * 365) - (meses * 30)).floor();

      _aniosController.text = anios.toString();
      _mesesController.text = meses.toString();
      _diasController.text = dias.toString();
    }
    if (selectedRateType == 'Anualmente') {
      double tiempoEnDias = (intereses) / (capital * (tasa / 100) * 1 / 365);
      int anios = (tiempoEnDias / 365).floor();
      int meses = ((tiempoEnDias - (anios * 365)) / 30).floor();
      int dias = (tiempoEnDias - (anios * 365) - (meses * 30)).floor();

      _aniosController.text = anios.toString();
      _mesesController.text = meses.toString();
      _diasController.text = dias.toString();
    }
  }

  void _calcularTasaSinMonto() {
    double intereses = double.tryParse(_interesesController.text) ?? 0;
    double capital = double.tryParse(_capitalController.text) ?? 0;
    int anios = int.tryParse(_aniosController.text) ?? 0;
    int meses = int.tryParse(_mesesController.text) ?? 0;
    int dias = int.tryParse(_diasController.text) ?? 0;
    int totalDias = (anios * 365) + (meses * 30) + dias;
    if (selectedRateType == 'Diariamente') {
      double tasa = intereses / (((capital)) * (totalDias / 365));
      _capitalController.text = capital.toStringAsFixed(2);
    }
    if (selectedRateType == 'Mensualmente') {
      double tasa = intereses / (((capital) * 12) * (totalDias / 365));
      _capitalController.text = capital.toStringAsFixed(2);
    }
    if (selectedRateType == 'Trimestralmente') {
      double tasa = intereses / (((capital) * 4) * (totalDias / 365));
      _capitalController.text = capital.toStringAsFixed(2);
    }
    if (selectedRateType == 'Cuatrimestralmente') {
      double tasa = intereses / (((capital / 100) * 3) * (totalDias / 365));
      _capitalController.text = capital.toStringAsFixed(2);
    }
    if (selectedRateType == 'Semestralmente') {
      double tasa = intereses / (((capital / 100) * 2) * (totalDias / 365));
      _capitalController.text = capital.toStringAsFixed(2);
    }
    if (selectedRateType == 'Anualmente') {
      double tasa = intereses / (((capital / 100) * 1) * (totalDias / 365));
      _tasaController.text = tasa.toStringAsFixed(2);
    }
  }

  void _calcularCapitalSinMonto() {
    double intereses = double.tryParse(_interesesController.text) ?? 0;
    double tasa = double.tryParse(_tasaController.text) ?? 0;
    int anios = int.tryParse(_aniosController.text) ?? 0;
    int meses = int.tryParse(_mesesController.text) ?? 0;
    int dias = int.tryParse(_diasController.text) ?? 0;
    int totalDias = (anios * 365) + (meses * 30) + dias;
    if (selectedRateType == 'Diariamente') {
      double capital = intereses / (((tasa / 100)) * (totalDias / 365));
      _capitalController.text = capital.toStringAsFixed(2);
    }
    if (selectedRateType == 'Mensualmente') {
      double capital = intereses / (((tasa / 100) * 12) * (totalDias / 365));
      _capitalController.text = capital.toStringAsFixed(2);
    }
    if (selectedRateType == 'Trimestralmente') {
      double capital = intereses / (((tasa / 100) * 4) * (totalDias / 365));
      _capitalController.text = capital.toStringAsFixed(2);
    }
    if (selectedRateType == 'Cuatrimestralmente') {
      double capital = intereses / (((tasa / 100) * 3) * (totalDias / 365));
      _capitalController.text = capital.toStringAsFixed(2);
    }
    if (selectedRateType == 'Semestralmente') {
      double capital = intereses / (((tasa / 100) * 2) * (totalDias / 365));
      _capitalController.text = capital.toStringAsFixed(2);
    }
    if (selectedRateType == 'Anualmente') {
      double capital = intereses / (((tasa / 100) * 1) * (totalDias / 365));
      _capitalController.text = capital.toStringAsFixed(2);
    }
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
    if (_montoController.text.isEmpty) {
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
      double monto = capital * (1 + ((tasa / 100) * 30) * (totalDias / 365));
      _montoController.text = monto.toStringAsFixed(2);
    }
    if (selectedRateType == 'Mensualmente') {
      double monto = capital * (1 + ((tasa / 100) * 12) * (totalDias / 365));
      _montoController.text = monto.toStringAsFixed(2);
    }
    if (selectedRateType == 'Trimestralmente') {
      double monto = capital * (1 + ((tasa / 100) * 4) * (totalDias / 365));
      _montoController.text = monto.toStringAsFixed(2);
    }
    if (selectedRateType == 'Cuatrimestralmente') {
      double monto = capital * (1 + ((tasa / 100) * 3) * (totalDias / 365));
      _montoController.text = monto.toStringAsFixed(2);
    }
    if (selectedRateType == 'Semestralmente') {
      double monto = capital * (1 + ((tasa / 100) * 2) * (totalDias / 365));
      _montoController.text = monto.toStringAsFixed(2);
    }
    if (selectedRateType == 'Anualmente') {
      double monto = capital * (1 + ((tasa / 100)) * (totalDias / 365));
      _montoController.text = monto.toStringAsFixed(2);
    }
  }

  void _calcularTiempo() {
    double capital = double.tryParse(_capitalController.text) ?? 0;
    double tasa = double.tryParse(_tasaController.text) ?? 0;
    double monto = double.tryParse(_montoController.text) ?? 0;
    if (selectedRateType == 'Diariamente') {
      double tiempoEnDias =
          (monto / capital) / (1 + (tasa / 100) * 30) * (365 / 30);
      int anios = (tiempoEnDias / 365).floor();
      int meses = ((tiempoEnDias - (anios * 365)) / 30).floor();
      int dias = (tiempoEnDias - (anios * 365) - (meses * 30)).floor();

      _aniosController.text = anios.toString();
      _mesesController.text = meses.toString();
      _diasController.text = dias.toString();
    }
    if (selectedRateType == 'Mensualmente') {
      double tiempoEnDias = ((monto / capital) - 1) / ((tasa / 100) * 12 / 365);
      int anios = (tiempoEnDias / 365).floor();
      int meses = ((tiempoEnDias - (anios * 365)) / 30).floor();
      int dias = (tiempoEnDias - (anios * 365) - (meses * 30)).floor();

      _aniosController.text = anios.toString();
      _mesesController.text = meses.toString();
      _diasController.text = dias.toString();
    }
    if (selectedRateType == 'Trimestralmente') {
      double tiempoEnDias = ((monto / capital) - 1) / ((tasa / 100) * 4 / 365);
      int anios = (tiempoEnDias / 365).floor();
      int meses = ((tiempoEnDias - (anios * 365)) / 30).floor();
      int dias = (tiempoEnDias - (anios * 365) - (meses * 30)).floor();

      _aniosController.text = anios.toString();
      _mesesController.text = meses.toString();
      _diasController.text = dias.toString();
    }
    if (selectedRateType == 'Cuatrimestralmente') {
      double tiempoEnDias = ((monto / capital) - 1) / ((tasa / 100) * 3 / 365);
      int anios = (tiempoEnDias / 365).floor();
      int meses = ((tiempoEnDias - (anios * 365)) / 30).floor();
      int dias = (tiempoEnDias - (anios * 365) - (meses * 30)).floor();

      _aniosController.text = anios.toString();
      _mesesController.text = meses.toString();
      _diasController.text = dias.toString();
    }
    if (selectedRateType == 'Semestralmente') {
      double tiempoEnDias = ((monto / capital) - 1) / ((tasa / 100) * 2 / 365);
      int anios = (tiempoEnDias / 365).floor();
      int meses = ((tiempoEnDias - (anios * 365)) / 30).floor();
      int dias = (tiempoEnDias - (anios * 365) - (meses * 30)).floor();

      _aniosController.text = anios.toString();
      _mesesController.text = meses.toString();
      _diasController.text = dias.toString();
    }
    if (selectedRateType == 'Anualmente') {
      double tiempoEnDias = ((monto / capital) - 1) / ((tasa / 100) * 1 / 365);
      int anios = (tiempoEnDias / 365).floor();
      int meses = ((tiempoEnDias - (anios * 365)) / 30).floor();
      int dias = (tiempoEnDias - (anios * 365) - (meses * 30)).floor();

      _aniosController.text = anios.toString();
      _mesesController.text = meses.toString();
      _diasController.text = dias.toString();
    }
  }

  void _calcularCapital() {
    double monto = double.tryParse(_montoController.text) ?? 0;
    double tasa = double.tryParse(_tasaController.text) ?? 0;
    int anios = int.tryParse(_aniosController.text) ?? 0;
    int meses = int.tryParse(_mesesController.text) ?? 0;
    int dias = int.tryParse(_diasController.text) ?? 0;
    int totalDias = (anios * 365) + (meses * 30) + dias;
    if (selectedRateType == 'Diariamente') {
      double capital = monto / (1 + ((tasa / 100) * 30) * (totalDias / 365));
      _capitalController.text = capital.toStringAsFixed(2);
    }
    if (selectedRateType == 'Mensualmente') {
      double capital = monto / (1 + ((tasa / 100) * 12) * (totalDias / 365));
      _capitalController.text = capital.toStringAsFixed(2);
    }
    if (selectedRateType == 'Trimestralmente') {
      double capital = monto / (1 + ((tasa / 100) * 4) * (totalDias / 365));
      _capitalController.text = capital.toStringAsFixed(2);
    }
    if (selectedRateType == 'Cuatrimestralmente') {
      double capital = monto / (1 + ((tasa / 100) * 3) * (totalDias / 365));
      _capitalController.text = capital.toStringAsFixed(2);
    }
    if (selectedRateType == 'Semestralmente') {
      double capital = monto / (1 + ((tasa / 100) * 2) * (totalDias / 365));
      _capitalController.text = capital.toStringAsFixed(2);
    }
    if (selectedRateType == 'Anualmente') {
      double capital = monto / (1 + ((tasa / 100) * 1) * (totalDias / 365));
      _capitalController.text = capital.toStringAsFixed(2);
    }
  }

  void _calcularTasa() {
    double monto = double.tryParse(_montoController.text) ?? 0;
    double capital = double.tryParse(_capitalController.text) ?? 0;
    int anios = int.tryParse(_aniosController.text) ?? 0;
    int meses = int.tryParse(_mesesController.text) ?? 0;
    int dias = int.tryParse(_diasController.text) ?? 0;
    int totalDias = (anios * 365) + (meses * 30) + dias;
    if (selectedRateType == 'Diariamente') {
      double tasa = 100 * (((monto / capital) - 1) / (30 * totalDias / 365));
      _tasaController.text = tasa.toStringAsFixed(2);
    }
    if (selectedRateType == 'Mensualmente') {
      double tasa = 100 * (((monto / capital) - 1) / (12 * totalDias / 365));
      _tasaController.text = tasa.toStringAsFixed(2);
    }
    if (selectedRateType == 'Trimestralmente') {
      double tasa = 100 * (((monto / capital) - 1) / (4 * totalDias / 365));
      _tasaController.text = tasa.toStringAsFixed(2);
    }
    if (selectedRateType == 'Cuatrimestralmente') {
      double tasa = 100 * (((monto / capital) - 1) / (3 * totalDias / 365));
      _tasaController.text = tasa.toStringAsFixed(2);
    }
    if (selectedRateType == 'Semestralmente') {
      double tasa = 100 * (((monto / capital) - 1) / (2 * totalDias / 365));
      _tasaController.text = tasa.toStringAsFixed(2);
    }
    if (selectedRateType == 'Anualmente') {
      double tasa = 100 * (((monto / capital) - 1) / (1 * totalDias / 365));
      _tasaController.text = tasa.toStringAsFixed(2);
    }
  }

  _calcularInteresesconMonto() {
    double capital = double.tryParse(_capitalController.text) ?? 0;
    double monto = double.tryParse(_montoController.text) ?? 0;
    double interes = (monto) - (capital);
    _interesesController.text = interes.toStringAsFixed(2);
  }

  void _limpiarCampos() {
    setState(() {
      selectedRateType = 'Anualmente';
    });
    _capitalController.clear();
    _tasaController.clear();
    _mesesController.clear();
    _aniosController.clear();
    _diasController.clear();
    _interesesController.clear();
    _montoController.clear();
    _startDate = null;
    _endDate = null;
    _calculateByDates = false;
    setState(() {});
  }
}
