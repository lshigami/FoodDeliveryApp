import 'package:flutter/material.dart';
import 'package:fooddeliveryapp/core/res/colours.dart';
import 'package:fooddeliveryapp/core/res/fonts.dart';

class TitleText extends StatelessWidget {
  final String text;
  const TitleText({super.key, required this.text});
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Text(
        text,
        textAlign: TextAlign.center,
        style: TextStyle(
          fontFamily: Fonts.Poppins,
          fontSize: 36,
          color: Colours.whiteText,
        ),
    );
  }
}
