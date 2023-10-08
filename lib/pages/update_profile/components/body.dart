import 'package:flutter/material.dart';

import '../../../constants.dart';
import '../../../size_config.dart';
import 'update_profile_form.dart';

class Body extends StatelessWidget {
  const Body({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SizedBox(
        width: double.infinity,
        child: Padding(
          padding:
              EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(20)),
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(height: SizeConfig.screenHeight * 0.03),
                Text(
                  "Modifica tu perfil",
                  style: TextStyle(
                    color: gTextColor,
                    fontFamily: 'Inter',
                    fontSize: getProportionateScreenWidth(28),
                    fontWeight: FontWeight.w900,
                  ),
                ),
                SizedBox(height: SizeConfig.screenHeight * 0.06),
                const UpdateProfileForm(),
                SizedBox(height: getProportionateScreenHeight(30)),
                Text(
                  "Al continuar, aceptas nuestros terminos y condiciones",
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.bodySmall,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
