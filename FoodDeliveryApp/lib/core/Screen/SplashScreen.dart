

import 'package:flutter/material.dart';
import 'package:fooddeliveryapp/core/Screen/Page01.dart';
import 'package:fooddeliveryapp/core/res/image_res.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState(){
    super.initState();
    Future.delayed(Duration(seconds: 3)).then((value){
     Navigator.push(context, MaterialPageRoute(builder: (context)=>Page01()));
    });
  }

  @override
  Widget build(BuildContext context) {
    double ws = MediaQuery.sizeOf(context).width;
    double hs = MediaQuery.sizeOf(context).height;

    return Scaffold(
      body: Stack(
        children: [
          Container(
            height: double.infinity,
            width: double.infinity,
            child: Image(image: AssetImage(ImageRes.bg), fit: BoxFit.cover),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 30,top: 120),
            child: Container(
              alignment: Alignment.center,
              child: Transform.scale(
                scale: 1.5, // Phóng to hình ảnh gấp đôi
                child: Image(
                  image: AssetImage("assets/images/ICON.png"),
                  color: Colors.white,
                  fit: BoxFit.contain,
                ),
              ),
            ),
          ),
          Container(
            height: double.infinity,
            width: double.infinity,
            child: Image(image: AssetImage(ImageRes.logo),),
          )
        ],
      ),
    );
  }
}
