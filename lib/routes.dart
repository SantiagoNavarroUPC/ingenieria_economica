import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:ingenieria_economica/pages/complete_profile/complete_profile.dart';
import 'package:ingenieria_economica/pages/forgot_password/forgot_password.dart';
import 'package:ingenieria_economica/pages/home_personal/home_personal.dart';
import 'package:ingenieria_economica/pages/notebook/page_amortizacion.dart';
import 'package:ingenieria_economica/pages/notebook/page_interes_compuesto.dart';
import 'package:ingenieria_economica/pages/notebook/page_interes_simple.dart';
import 'package:ingenieria_economica/pages/profile/profile.dart';
import 'package:ingenieria_economica/pages/sign_in/sign_in.dart';
import 'package:ingenieria_economica/pages/sign_up/sign_up.dart';
import 'package:ingenieria_economica/pages/start/start.dart';
import 'package:ingenieria_economica/pages/update_profile/update_profile.dart';
import 'package:ingenieria_economica/pages/view_profile/ver_profile.dart';

final Map<String, WidgetBuilder> routes = {
  StartApp.routeName: (context) => const StartApp(),
  SignIn.routeName: (context) => const SignIn(),
  ForgotPassword.routeName: (context) => const ForgotPassword(),
  SignUp.routeName: (context) => const SignUp(),
  CompleteProfile.routeName: (context) => const CompleteProfile(),
  UpdateProfile.routeName: (context) => const UpdateProfile(),
  VerProfile.routeName: (context) => const VerProfile(),
  HomePersonal.routeName: (context) => const HomePersonal(),
  Profile.routeName: (context) => const Profile(),
  InteresSimple.routeName: (context) => InteresSimple(),
  InteresCompuesto.routeName: (context) => InteresCompuesto(),
  Amortizacion.routeName: (context) => Amortizacion(),
};
