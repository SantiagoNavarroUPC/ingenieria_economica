import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../constants.dart';
import '../../../controller/controller_user_firebase.dart';
import '../../../size_config.dart';
import 'sign_up_form.dart';

class Body extends StatelessWidget {
  const Body({super.key});

  @override
  Widget build(BuildContext context) {
    ControlUserAuth controlua = Get.find();
    return SafeArea(
      child: SizedBox(
        width: double.infinity,
        child: Padding(
          padding:
              EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(20)),
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(height: SizeConfig.screenHeight * 0.04), // 4%
                Text(
                  "Registro de datos",
                  style: TextStyle(
                    color: gTextColor,
                    fontFamily: 'Inter',
                    fontSize: getProportionateScreenWidth(28),
                    fontWeight: FontWeight.w900,
                  ),
                ),
                SizedBox(height: getProportionateScreenHeight(6)),
                const Text(
                    "Completa los campos con tus datos \no continua con Google",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: gTextColor,
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.w400,
                    )),
                SizedBox(height: SizeConfig.screenHeight * 0.08),
                const SignUpForm(),
                SizedBox(height: SizeConfig.screenHeight * 0.08),
                const Text(
                  "Continuar con",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: gTextColor,
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w400,
                  ),
                ),
                SizedBox(height: getProportionateScreenHeight(15)),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [],
                ),
                SizedBox(height: getProportionateScreenHeight(20)),
                Text(
                  'Al continuar, aceptas nuestros terminos y condiciones',
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.bodySmall,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
