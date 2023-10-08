import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../constants.dart';
import '../../../controller/controller_perfil_firebase.dart';
import '../../../size_config.dart';
import '../../components/custom_surfix_icon.dart';
import '../../components/default_button_secundary.dart';
import '../../components/form_error.dart';
import '../../profile/profile.dart';

class UpdateProfileForm extends StatefulWidget {
  const UpdateProfileForm({super.key});

  @override
  _UpdateProfileFormState createState() => _UpdateProfileFormState();
}

class _UpdateProfileFormState extends State<UpdateProfileForm> {
  final _formKey = GlobalKey<FormState>();
  final List<String?> errors = [];
  String? firstName;
  String? lastName;
  String? phoneNumber;
  String? address;
  ControlUserPerfil controlup = Get.find();
  TextEditingController controlNombre = TextEditingController();
  TextEditingController controlApellido = TextEditingController();
  TextEditingController controlDireccion = TextEditingController();
  TextEditingController controlCelular = TextEditingController();

  @override
  void initState() {
    super.initState();
    obtenerPerfil(); // Llama a la función para obtener el perfil
  }

  Future<void> obtenerPerfil() async {
    try {
      final perfil = await controlup.obtenerPerfil();
      setState(() {
        controlNombre.text = perfil['nombre'] ?? '';
        controlApellido.text = perfil['apellido'] ?? '';
        controlDireccion.text = perfil['direccion'] ?? '';
        controlCelular.text = perfil['celular'] ?? '';
      });
    } catch (error) {
      print(error);
    }
  }

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
          buildFirstNameFormField(),
          SizedBox(height: getProportionateScreenHeight(30)),
          buildLastNameFormField(),
          SizedBox(height: getProportionateScreenHeight(30)),
          buildPhoneNumberFormField(),
          SizedBox(height: getProportionateScreenHeight(30)),
          buildAddressFormField(),
          FormError(errors: errors),
          SizedBox(height: getProportionateScreenHeight(40)),
          DefaultButtonSecundary(
            text: "Actualizar",
            press: () {
              if (_formKey.currentState!.validate()) {
                var perfil = <String, dynamic>{
                  'nombre': controlNombre.text,
                  'apellido': controlApellido.text,
                  'direccion': controlDireccion.text,
                  'celular': controlCelular.text,
                };
                controlup.crearperfil(perfil);
                Navigator.pushNamed(context, Profile.routeName);
              }
            },
          ),
        ],
      ),
    );
  }

  TextFormField buildAddressFormField() {
    return TextFormField(
      onSaved: (newValue) => address = newValue,
      onChanged: (value) {
        if (value.isNotEmpty) {
          removeError(error: gAddressNullError);
        }
        return null;
      },
      validator: (value) {
        if (value!.isEmpty) {
          addError(error: gAddressNullError);
          return "";
        }
        return null;
      },
      controller: controlDireccion,
      decoration: const InputDecoration(
        labelText: "Dirección",
        hintText: "Ingrese su dirección",
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon:
            CustomSurfixIcon(svgIcon: "assets/icons/Location point.svg"),
      ),
    );
  }

  TextFormField buildPhoneNumberFormField() {
    return TextFormField(
      keyboardType: TextInputType.phone,
      onSaved: (newValue) => phoneNumber = newValue,
      onChanged: (value) {
        if (value.isNotEmpty) {
          removeError(error: gPhoneNumberNullError);
        }
        return null;
      },
      validator: (value) {
        if (value!.isEmpty) {
          addError(error: gPhoneNumberNullError);
          return "";
        }
        return null;
      },
      controller: controlCelular,
      decoration: const InputDecoration(
        labelText: "Número de teléfono",
        hintText: "Ingrese su número de teléfono",
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: CustomSurfixIcon(svgIcon: "assets/icons/Phone.svg"),
      ),
    );
  }

  TextFormField buildLastNameFormField() {
    return TextFormField(
      onSaved: (newValue) => lastName = newValue,
      onChanged: (value) {
        if (value.isNotEmpty) {
          removeError(error: gNamelNullError);
        }
        return null;
      },
      validator: (value) {
        if (value!.isEmpty) {
          addError(error: gNamelNullError);
          return "";
        }
        return null;
      },
      controller: controlApellido,
      decoration: const InputDecoration(
        labelText: "Apellidos",
        hintText: "Ingrese su apellido",
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: CustomSurfixIcon(svgIcon: "assets/icons/User.svg"),
      ),
    );
  }

  TextFormField buildFirstNameFormField() {
    return TextFormField(
      onSaved: (newValue) => firstName = newValue,
      onChanged: (value) {
        if (value.isNotEmpty) {
          removeError(error: gNamelNullError);
        }
        return null;
      },
      validator: (value) {
        if (value!.isEmpty) {
          addError(error: gNamelNullError);
          return "";
        }
        return null;
      },
      controller: controlNombre,
      decoration: const InputDecoration(
        labelText: "Nombre(s)",
        hintText: "Ingrese su nombre",
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: CustomSurfixIcon(svgIcon: "assets/icons/User.svg"),
      ),
    );
  }
}
