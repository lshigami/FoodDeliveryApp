import 'package:flutter/material.dart';
import 'package:fooddeliveryapp/core/common/logo.dart';
import 'package:fooddeliveryapp/core/common/titile_text.dart';
import 'package:fooddeliveryapp/core/res/image_res.dart';

class SecondPage extends StatelessWidget {
  const SecondPage({super.key});
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      height: MediaQuery.of(context).size.height,
      child: Column(
        children: [
          Container(
            height: MediaQuery.of(context).size.height / 6,
            alignment: Alignment(0.0, 0.9),
            child: const Logo(),
          ),
          const TitleText(text: 'Choose Your Favorite Restaurants'),
          Image.asset(ImageRes.page2),
        ],
      ),
    );
  }
}

class ThirdPage extends StatelessWidget {
  const ThirdPage({super.key});
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      height: MediaQuery.of(context).size.height,
      child: Column(
        children: [
          Container(
            height: MediaQuery.of(context).size.height / 6,
            alignment: Alignment(0.0, 0.9),
            child: const Logo(),
          ),
          const TitleText(text: 'Quick Shipping'),
          Image.asset(ImageRes.page3),
        ],
      ),
    );
  }
}
