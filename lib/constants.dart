import 'package:flutter/material.dart';
import 'package:ingenieria_economica/size_config.dart';

const gBackgroundColor = Color.fromARGB(255, 33, 143, 21);
const gBackgroundColorSecundary = Color.fromARGB(255, 255, 255, 255);
const gTextColor = Color(0xFF262626);

const gButtonColor = Color.fromARGB(255, 255, 255, 255);
const gButtonTextColor = Color(0xFF262626);

const gButtonColorSecundary = Color.fromARGB(255, 33, 143, 21);
const gButtonTextColorSecundary = Color.fromARGB(255, 255, 255, 255);

const gPrimaryLightColor = Color.fromARGB(255, 255, 255, 255);

const gPrimaryGradientColor = LinearGradient(
  begin: Alignment.topLeft,
  end: Alignment.bottomRight,
  colors: [Color(0xFFFFA53E), Color(0xFFFF7643)],
);
const gSecondaryColor = Color(0xFF979797);
const gSecondaryColor1 = Color.fromARGB(255, 70, 152, 193);
// const gTextColor = Color(0xFF757575);

const gAnimationDuration = Duration(milliseconds: 200);

final headingStyle = TextStyle(
  fontSize: getProportionateScreenWidth(28),
  fontWeight: FontWeight.bold,
  color: Colors.black,
  height: 1.5,
);

const defaultDuration = Duration(milliseconds: 250);

// Form Error
final RegExp emailValidatorRegExp =
    RegExp(r"^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
const String gEmailNullError = "Por favor ingresar su correo electrónico";
const String gInvalidEmailError =
    "Por favor ingresar un correo electrónico válido";
const String gPassNullError = "Por favor ingresar su contraseña";
const String gShortPassError = "La contraseña es muy corta";
const String gMatchPassError = "Las contraseñas no coinciden";
const String gNamelNullError = "Por favor ingresar su nombre";
const String gPhoneNumberNullError = "Por favor ingresar su número de teléfono";
const String gAddressNullError = "Por favor ingresar su dirección";

final otpInputDecoration = InputDecoration(
  contentPadding:
      EdgeInsets.symmetric(vertical: getProportionateScreenWidth(15)),
  border: outlineInputBorder(),
  focusedBorder: outlineInputBorder(),
  enabledBorder: outlineInputBorder(),
);

OutlineInputBorder outlineInputBorder() {
  return OutlineInputBorder(
    borderRadius: BorderRadius.circular(getProportionateScreenWidth(15)),
    borderSide: const BorderSide(color: gTextColor),
  );
}
