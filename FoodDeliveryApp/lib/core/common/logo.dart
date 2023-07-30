import 'package:flutter/material.dart';
import 'package:fooddeliveryapp/core/res/image_res.dart';

class Logo extends StatelessWidget {
  const Logo({super.key, this.w, this.h});
  final double? w;
  final double? h;
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      width: w ?? 99,
      height: h ?? 66,
      // color: Colors.white,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.white,
      ),
      child: Image.asset(ImageRes.logo),
    );
  }
}

class LogoMessage extends StatelessWidget {
  const LogoMessage({super.key, this.w, this.h});
  final double? w;
  final double? h;
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      width: w ?? 99,
      height: h ?? 99,
      // color: Colors.white,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.white,
      ),
      child: Stack(
        children: [
          Align(
            alignment: Alignment.center,
            child: Image.asset(ImageRes.logo),
          ),
          Align(
            alignment: Alignment.topRight,
            child: Image.asset(ImageRes.page0, scale: 1,),
          ),
        ],
      ),
    );
  }
}
