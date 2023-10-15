import 'package:flutter/material.dart';
import 'package:ingenieria_economica/pages/components/default_button_secundary.dart';
import '../../../constants.dart';
import '../../../size_config.dart';
import '../../components/default_button.dart';
import '../../home_personal/home_personal.dart';
import '../../sign_in/sign_in.dart';

class Body extends StatefulWidget {
  const Body({super.key});

  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: GestureDetector(
        child: Column(
          children: <Widget>[
            const Spacer(),
            Text(
              "Bienvenido al aplicativo de ingenieria economica",
              style: TextStyle(
                color: gTextColor,
                fontFamily: 'Inter',
                fontSize: getProportionateScreenWidth(28),
                fontWeight: FontWeight.w900,
              ),
              textAlign: TextAlign.center,
            ),
            Align(
              child: Image.asset(
                "assets/images/Logo.png",
                height: getProportionateScreenHeight(300),
                width: getProportionateScreenWidth(300),
                fit: BoxFit.contain,
              ),
            ),
            Text(
              "Este software tiene la finalidad de resolver procedimientos matematicos de la ingenieria economica",
              style: TextStyle(
                color: gTextColor,
                fontFamily: 'Inter',
                fontSize: getProportionateScreenWidth(15),
                fontWeight: FontWeight.w600,
              ),
              textAlign: TextAlign.center,
            ),
            Expanded(
              flex: 2,
              child: Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: getProportionateScreenWidth(20)),
                child: Column(
                  children: <Widget>[
                    const Spacer(flex: 3),
                    DefaultButtonSecundary(
                      text: "Continuar",
                      press: () {
                        Navigator.pushReplacementNamed(
                            context, SignIn.routeName);
                      },
                    ),
                    const Spacer(),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
