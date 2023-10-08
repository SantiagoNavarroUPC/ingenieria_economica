import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:ingenieria_economica/pages/profile/components/profile_menu.dart';
import '../../../controller/controller_perfil_firebase.dart';
import '../../update_profile/update_profile.dart';
import '../../view_profile/ver_profile.dart';
import 'profile_picture.dart';

class Body extends StatefulWidget {
  final Key refreshIndicatorKey;

  const Body({Key? key, required this.refreshIndicatorKey}) : super(key: key);

  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  // Lista de elementos en el perfil
  List<String> profileItems = [
    "Ver mi perfil",
    "Actualizar perfil",
    "Ver historial de ejercicios",
    "Cerrar sesión",
  ];

  final ScrollController _scrollController = ScrollController();
  bool _isRefreshing = false;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_scrollController.position.pixels ==
        _scrollController.position.maxScrollExtent) {
      _refreshProfileItems();
    }
  }

  Future<void> _refreshProfileItems() async {
    if (!_isRefreshing) {
      setState(() {
        _isRefreshing = true;
      });

      // Simula la carga o actualización de los datos del perfil
      await Future.delayed(const Duration(seconds: 2));

      setState(() {
        // Actualiza los elementos del perfil
        profileItems = [
          "Ver mi perfil",
          "Actualizar perfil",
          "Ver historial de ejercicios",
          "Cerrar sesión",
        ];
        _isRefreshing = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      key: widget.refreshIndicatorKey,
      onRefresh: _refreshProfileItems,
      child: SingleChildScrollView(
        controller: _scrollController,
        padding: const EdgeInsets.symmetric(vertical: 20),
        child: Column(
          children: [
            GetBuilder<ControlUserPerfil>(
              builder: (controller) {
                return ProfilePicture(
                  refreshProfile: controller.obtenerFotoCatalogo,
                );
              },
            ),
            const SizedBox(height: 20),
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: profileItems.length,
              itemBuilder: (context, index) {
                return ProfileMenu(
                  text: profileItems[index],
                  icon: "assets/icons/${getIconName(profileItems[index])}.svg",
                  press: () => handleProfileMenuItemClick(index),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  // Obtén el nombre del icono según el texto del elemento del perfil
  String getIconName(String profileItem) {
    if (profileItem == "Ver mi perfil") {
      return "User Icon";
    } else if (profileItem == "Actualizar perfil") {
      return "Settings";
    } else if (profileItem == "Ver historial de ejercicios") {
      return "receipt";
    } else if (profileItem == "Cerrar sesión") {
      return "Log out";
    } else {
      return "";
    }
  }

  // Maneja el clic en un elemento del perfil
  void handleProfileMenuItemClick(int index) {
    switch (index) {
      case 0:
        Navigator.pushNamed(
          context,
          VerProfile.routeName, // Elimina todas las rutas anteriores
        );
        break;
      case 1:
        Navigator.pushNamed(
          context,
          UpdateProfile.routeName, // Elimina todas las rutas anteriores
        );
        break;
      case 2:
        break;
      case 3:
        SystemChannels.platform
            .invokeMethod<void>('SystemNavigator.pop'); // Sale de la aplicación
        break;
    }
  }
}
