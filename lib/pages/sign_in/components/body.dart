import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../constants.dart';
import '../../../controller/controller_user_firebase.dart';
import '../../../size_config.dart';
import '../../components/no_account.dart';
import 'sign_in_form.dart';

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
                SizedBox(height: SizeConfig.screenHeight * 0.04),
                Text(
                  "Bienvenido de nuevo",
                  style: TextStyle(
                    color: gTextColor,
                    fontFamily: 'Inter',
                    fontSize: getProportionateScreenWidth(28),
                    fontWeight: FontWeight.w900,
                  ),
                ),
                SizedBox(height: getProportionateScreenHeight(6)),
                const Text(
                  "Introduzca su correo electrónico y contraseña",
                  style: TextStyle(
                    color: gTextColor,
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w400,
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: SizeConfig.screenHeight * 0.08),
                const SignForm(),
                SizedBox(height: SizeConfig.screenHeight * 0.08),
                SizedBox(height: getProportionateScreenHeight(15)),
                SizedBox(height: getProportionateScreenHeight(20)),
                const NoAccount(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
