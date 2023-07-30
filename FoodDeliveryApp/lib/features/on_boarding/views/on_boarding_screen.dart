import 'package:flutter/material.dart';
import 'package:fooddeliveryapp/core/common/logo.dart';
import 'package:fooddeliveryapp/core/res/image_res.dart';
import 'package:fooddeliveryapp/features/on_boarding/views/widgets/page1.dart';

class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({super.key});

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(seconds: 3)).then((value) {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => FirstPage()));
    });
  }

  @override
  Widget build(BuildContext context) {
    var hOfContext = MediaQuery.of(context).size.height;
    var wOfContext = MediaQuery.of(context).size.width;
    // TODO: implement build
    return Scaffold(
      body: Container(
        width: wOfContext,
        height: hOfContext,
        child: Stack(
          children: [
            Image.asset(ImageRes.background),
            Center(
                child: Stack(
              children: [
                LogoMessage(w: wOfContext / 1.4, h: wOfContext / 1.1),
              ],
            )),
          ],
        ),
      ),
    );
  }
}
