import 'package:flutter/material.dart';
import '../../constants.dart';
import '../../size_config.dart';
import '../sign_up/sign_up.dart';
import '../size_config.dart';

class NoAccount extends StatelessWidget {
  const NoAccount({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          "¿Aún no tienes una cuenta? ",
          style: TextStyle(
            fontSize: getProportionateScreenWidth(16),
            fontFamily: 'Inter',
            fontWeight: FontWeight.w400,
          ),
        ),
        GestureDetector(
          onTap: () =>
              Navigator.pushReplacementNamed(context, SignUp.routeName),
          child: Text(
            "Registrarse",
            style: TextStyle(
              fontSize: getProportionateScreenWidth(16),
              color: gBackgroundColor,
              fontFamily: 'Inter',
              fontWeight: FontWeight.w900,
            ),
          ),
        ),
      ],
    );
  }
}
