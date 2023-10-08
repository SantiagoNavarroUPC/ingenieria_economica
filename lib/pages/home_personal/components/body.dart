import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ingenieria_economica/pages/home_personal/components/banner1.dart';
import '../../../constants.dart';
import 'banner2.dart';
import 'banner3.dart';
import '../../../size_config.dart';
import 'banner4.dart';

class Body extends StatelessWidget {
  const Body({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        child: Column(
          children: [
            _buildSection(
              title: 'Sesión #1',
              icon: Icons.category,
              banner: const Banner1(),
            ),
            _buildSection(
              title: 'Sesión #2',
              icon: Icons.category,
              banner: const Banner2(),
            ),
            _buildSection(
              title: 'Sesión #3',
              icon: Icons.category,
              banner: const Banner3(),
            ),
            _buildSection(
              title: 'Sesión #4',
              icon: Icons.category,
              banner: const Banner4(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSection(
      {required String title, required IconData icon, required Widget banner}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding:
              EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(15)),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Icon(
                icon,
                color: Colors.black,
                size: getProportionateScreenWidth(20),
              ),
              Expanded(
                child: Text(
                  title,
                  style: TextStyle(
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w700,
                    fontSize: getProportionateScreenWidth(16),
                  ),
                ),
              ),
            ],
          ),
        ),
        banner,
      ],
    );
  }
}
