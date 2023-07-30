import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:fooddeliveryapp/core/common/logo.dart';
import 'package:fooddeliveryapp/core/common/titile_text.dart';
import 'package:fooddeliveryapp/core/res/colours.dart';
import 'package:fooddeliveryapp/core/res/fonts.dart';
import 'package:fooddeliveryapp/core/res/image_res.dart';
import 'package:fooddeliveryapp/features/on_boarding/views/widgets/Introduction_page.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class FirstPage extends StatefulWidget {
  const FirstPage({super.key});

  @override
  State<FirstPage> createState() => _FirstPageState();
}

class _FirstPageState extends State<FirstPage> {
  final pageController = PageController();
  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      backgroundColor: Colours.darkOrange,
      body: SafeArea(
        bottom: false,
        child: Stack(
          alignment: Alignment.bottomCenter,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 32.0),
              child: Align(
                alignment: Alignment.topRight,
                child: Text(
                  'SKIP >>',
                  style: TextStyle(
                      fontFamily: Fonts.Ninito,
                      fontWeight: FontWeight.w800,
                      color: Color.fromRGBO(255, 255, 255, 0.60)),
                ),
              ),
            ),
            PageView(
              controller: pageController,
              children: [
                Container(
                  height: MediaQuery.of(context).size.height,
                  child: Column(
                    children: [
                      Container(
                        height: MediaQuery.of(context).size.height / 6,
                        alignment: Alignment(0.0, 0.9),
                        child: const Logo(),
                      ),
                      const TitleText(text: 'Order Your Favorite Food'),
                      Image.asset(ImageRes.page3),
                    ],
                  ),
                ),
                // FirstPage(),
                SecondPage(),
                ThirdPage(),
              ],
            ),
            Transform.translate(
              offset: const Offset(0.0, -60.0),
              child: SmoothPageIndicator(
                controller: pageController,
                count: 3,
                effect: WormEffect(
                  dotColor: Color(0x99FF855D),
                  dotHeight: 5.0,
                  activeDotColor: Colours.whiteText,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
