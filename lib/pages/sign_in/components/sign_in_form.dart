import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../constants.dart';
import '../../../controller/controller_perfil_firebase.dart';
import '../../../controller/controller_user_firebase.dart';
import '../../../size_config.dart';
import '../../components/custom_surfix_icon.dart';
import '../../components/default_button_secundary.dart';
import '../../components/form_error.dart';
import '../../forgot_password/forgot_password.dart';
import '../../home_personal/home_personal.dart';

class SignForm extends StatefulWidget {
  const SignForm({super.key});

  @override
  _SignFormState createState() => _SignFormState();
}

class _SignFormState extends State<SignForm> {
  final _formKey = GlobalKey<FormState>();
  String? email;
  String? password;
  TextEditingController user = TextEditingController();
  TextEditingController pass = TextEditingController();
  ControlUserAuth controlua = Get.find();
  bool? remember = false;
  final List<String?> errors = [];

  void addError({String? error}) {
    if (!errors.contains(error)) {
      setState(() {
        errors.add(error);
      });
    }
  }

  void removeError({String? error}) {
    if (errors.contains(error)) {
      setState(() {
        errors.remove(error);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          buildEmailFormField(),
          SizedBox(height: getProportionateScreenHeight(30)),
          buildPasswordFormField(),
          SizedBox(height: getProportionateScreenHeight(30)),
          Row(
            children: [
              const Spacer(),
              GestureDetector(
                onTap: () =>
                    Navigator.pushNamed(context, ForgotPassword.routeName),
                child: const Text(
                  "¿Olvidaste tu contraseña?",
                  style: TextStyle(
                    decoration: TextDecoration.underline,
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w400,
                  ),
                ),
              )
            ],
          ),
          FormError(errors: errors),
          SizedBox(height: getProportionateScreenHeight(20)),
          DefaultButtonSecundary(
            text: "Ingresar",
            press: () {
              if (_formKey.currentState!.validate()) {
                _formKey.currentState!.save();
                controlua.ingresarUser(user.text, pass.text).then((value) {
                  if (controlua.userValido == null) {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: const Text("Error"),
                          content: Text(controlua.mensajesUser),
                          actions: [
                            TextButton(
                              onPressed: () => Navigator.pop(context),
                              child: const Text("OK"),
                            ),
                          ],
                        );
                      },
                    );
                  } else {
                    Navigator.pop(context);
                    Navigator.pushNamed(context, HomePersonal.routeName);
                  }
                });
              }
            },
          ),
        ],
      ),
    );
  }

  TextFormField buildPasswordFormField() {
    return TextFormField(
      obscureText: true,
      onSaved: (newValue) => password = newValue,
      onChanged: (value) {
        if (value.isNotEmpty) {
          removeError(error: gPassNullError);
        } else if (value.length >= 8) {
          removeError(error: gShortPassError);
        }
        return null;
      },
      validator: (value) {
        if (value!.isEmpty) {
          addError(error: gPassNullError);
          return "";
        } else if (value.length < 8) {
          addError(error: gShortPassError);
          return "";
        }
        return null;
      },
      controller: pass,
      decoration: const InputDecoration(
        labelText: "Contraseña",
        hintText: "Ingrese su contraseña",
        // If  you are using latest version of flutter then lable text and hint text shown like this
        // if you r using flutter less then 1.20.* then maybe this is not working properly
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: CustomSurfixIcon(svgIcon: "assets/icons/Lock.svg"),
      ),
    );
  }

  TextFormField buildEmailFormField() {
    return TextFormField(
      keyboardType: TextInputType.emailAddress,
      onSaved: (newValue) => email = newValue,
      onChanged: (value) {
        if (value.isNotEmpty) {
          removeError(error: gEmailNullError);
        } else if (emailValidatorRegExp.hasMatch(value)) {
          removeError(error: gInvalidEmailError);
        }
        return null;
      },
      validator: (value) {
        if (value!.isEmpty) {
          addError(error: gEmailNullError);
          return "";
        } else if (!emailValidatorRegExp.hasMatch(value)) {
          addError(error: gInvalidEmailError);
          return "";
        }
        return null;
      },
      controller: user,
      decoration: const InputDecoration(
        labelText: "Correo electrónico",
        hintText: "Ingrese su correo electrónico",
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: CustomSurfixIcon(svgIcon: "assets/icons/Mail.svg"),
      ),
    );
  }
}
