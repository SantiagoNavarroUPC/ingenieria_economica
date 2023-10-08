import 'package:flutter/material.dart';

import '../../constants.dart';
import '../../size_config.dart';

class DefaultButton extends StatelessWidget {
  const DefaultButton({
    Key? key,
    this.text,
    this.press,
  }) : super(key: key);
  final String? text;
  final Function? press;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: getProportionateScreenHeight(56),
      child: TextButton(
        style: TextButton.styleFrom(
          foregroundColor: gButtonTextColor,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
          backgroundColor: gButtonColor,
        ),
        onPressed: press as void Function()?,
        child: Text(
          text!,
          style: TextStyle(
              color: gTextColor,
              fontFamily: 'Inter',
              fontWeight: FontWeight.w600,
              fontSize: getProportionateScreenWidth(20)),
        ),
      ),
    );
  }
}
