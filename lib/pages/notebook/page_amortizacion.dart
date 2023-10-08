import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'dart:math';

import 'package:flutter/material.dart';

class Amortizacion extends StatefulWidget {
  static String routeName = "/amortizacion";

  @override
  _AmortizacionState createState() => _AmortizacionState();
}

class _AmortizacionState extends State<Amortizacion> {
  // Variables para el cálculo
  double principal = 0.0;
  double interestRate = 0.0;
  int loanTerm = 0;
  double monthlyPayment = 0.0;

  // Controladores de los campos de entrada
  TextEditingController principalController = TextEditingController();
  TextEditingController interestRateController = TextEditingController();
  TextEditingController loanTermController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Calculadora de Amortización'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TextField(
              controller: principalController,
              decoration: InputDecoration(labelText: 'Monto del préstamo'),
              keyboardType: TextInputType.number,
            ),
            TextField(
              controller: interestRateController,
              decoration:
                  InputDecoration(labelText: 'Tasa de interés anual (%)'),
              keyboardType: TextInputType.number,
            ),
            TextField(
              controller: loanTermController,
              decoration:
                  InputDecoration(labelText: 'Plazo del préstamo (años)'),
              keyboardType: TextInputType.number,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: calculateAmortization,
              child: Text('Calcular Amortización'),
            ),
            SizedBox(height: 20),
            Text('Pago mensual: \$${monthlyPayment.toStringAsFixed(2)}'),
          ],
        ),
      ),
    );
  }

  void calculateAmortization() {
    print("tc");
  }
}
