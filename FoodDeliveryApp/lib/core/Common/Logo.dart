import 'package:flutter/material.dart';
import 'package:fooddeliveryapp/core/res/image_res.dart';

class Logo extends StatelessWidget {
  double w;
  double h;
  Logo({super.key,this.w=73,this.h=73});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: w,
      height:h,
      decoration: BoxDecoration(
        color: Colors.white,
        shape: BoxShape.circle,
      ),
      child: Image(image: AssetImage(ImageRes.logo),fit: BoxFit.cover,),
    );
  }
}
