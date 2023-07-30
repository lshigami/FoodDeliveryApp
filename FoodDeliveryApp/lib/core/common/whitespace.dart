import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class WhiteSpace extends StatelessWidget {
  const WhiteSpace({super.key, required this.height, required this.width});
  final double? height;
  final double? width;
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return SizedBox(
      height: height?.h ,
      width: width?.h ,
    );
  }
}
