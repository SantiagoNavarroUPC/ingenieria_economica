import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../constants.dart';
import '../../../controller/controller_user_firebase.dart';
import '../../../size_config.dart';
import '../../complete_profile/complete_profile.dart';
import '../../components/custom_surfix_icon.dart';
import '../../components/default_button_secundary.dart';
import '../../components/form_error.dart';

class SignUpForm extends StatefulWidget {
  const SignUpForm({super.key});

  @override
  _SignUpFormState createState() => _SignUpFormState();
}

class _SignUpFormState extends State<SignUpForm> {
  final _formKey = GlobalKey<FormState>();
  String? email;
  String? password;
  // ignore: non_constant_identifier_names
  String? confirm_password;
  TextEditingController user = TextEditingController();
  TextEditingController pass = TextEditingController();
  ControlUserAuth controlua = Get.find();
  bool remember = false;
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
          buildConformPassFormField(),
          FormError(errors: errors),
          SizedBox(height: getProportionateScreenHeight(40)),
          DefaultButtonSecundary(
            text: "Siguiente",
            press: () {
              if (_formKey.currentState!.validate()) {
                _formKey.currentState!.save();
                controlua.crearUser(user.text, pass.text).then((value) {
                  if (controlua.userValido == null) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('ERROR. error de conexion'),
                      ),
                    );
                  } else {
                    Navigator.pop(context);
                    Navigator.pushNamed(context, CompleteProfile.routeName);
                  }
                });
              }
            },
          ),
        ],
      ),
    );
  }

  TextFormField buildConformPassFormField() {
    return TextFormField(
      obscureText: true,
      onSaved: (newValue) => confirm_password = newValue,
      onChanged: (value) {
        if (value.isNotEmpty) {
          removeError(error: gPassNullError);
        } else if (value.isNotEmpty && password == confirm_password) {
          removeError(error: gMatchPassError);
        }
        confirm_password = value;
      },
      validator: (value) {
        if (value!.isEmpty) {
          addError(error: gPassNullError);
          return "";
        } else if ((password != value)) {
          addError(error: gMatchPassError);
          return "";
        }
        return null;
      },
      decoration: const InputDecoration(
        labelText: "Confirmar contraseña",
        hintText: "Repita su contraseña",
        // If  you are using latest version of flutter then lable text and hint text shown like this
        // if you r using flutter less then 1.20.* then maybe this is not working properly
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: CustomSurfixIcon(svgIcon: "assets/icons/Lock.svg"),
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
        password = value;
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
        return;
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
        // If  you are using latest version of flutter then lable text and hint text shown like this
        // if you r using flutter less then 1.20.* then maybe this is not working properly
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: CustomSurfixIcon(svgIcon: "assets/icons/Mail.svg"),
      ),
    );
  }
}
