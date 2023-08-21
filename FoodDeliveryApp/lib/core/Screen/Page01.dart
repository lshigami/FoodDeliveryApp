import 'package:flutter/material.dart';
import 'package:fooddeliveryapp/core/Common/Logo.dart';
import 'package:fooddeliveryapp/core/Common/listpage1.dart';
import 'package:fooddeliveryapp/core/Screen/LoginPage.dart';
import 'package:fooddeliveryapp/core/res/colours.dart';
import 'package:fooddeliveryapp/core/res/fonts.dart';
import 'package:fooddeliveryapp/core/res/image_res.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class Page01 extends StatefulWidget {
  const Page01({super.key});

  @override
  State<Page01> createState() => _Page01State();
}

class _Page01State extends State<Page01> {
  final pagecontroller =PageController();
  @override
  void dispose(){
    super.dispose();
    pagecontroller.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:SafeArea(
        child: Container(
          color: Colours.darkOrange,
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(right: 40,top: 36),
                    child: TextButton(
                        child: Text("SKIP >>",style: TextStyle(fontSize: 18,color: Colours.grayText,fontFamily: Fonts.Ninito,fontWeight: FontWeight.w800)),
                      onPressed: (){
                          pagecontroller.animateToPage(3, duration: Duration(seconds: 1), curve: Curves.easeInOutCirc);
                      },
                    ),
                  ),
                ],
              ),
              Expanded(
                child: PageView.builder(
                  controller: pagecontroller,
                  itemCount: 3,
                  itemBuilder: (context,index){
                    return Container(child: List(idx: index));
                  },
                ),
              ),
              SmoothPageIndicator(
                  controller: pagecontroller,  // PageController
                  count:  3,
                  effect:  JumpingDotEffect(activeDotColor: Color(0xFFFFDFD4),dotColor: Color(0xFFFF855D),dotHeight: 10,dotWidth: 10),  // your preferred effect
                  onDotClicked: (index){
                  }
              )
            ],
          ),
        ),
      ),
    );
  }
}

class List extends StatelessWidget {
  final int idx;
  const List({super.key,required this.idx});

  @override
  Widget build(BuildContext context) {
    return  Column(
      children: [
        Logo(),
        SizedBox(
          height: 20,
        ),
        Container(
            child: Text(text[idx],style: TextStyle(fontFamily:Fonts.Poppins,color: Colors.white,fontSize: 36),textAlign: TextAlign.center,)
        ),
        SizedBox(
          height: 50,
        ),
        Container(
          height: 300,
            child: Transform.scale(
              scale: (idx==2)? 1.5: 1,
                child: Image(image: AssetImage(pictures[idx]),fit: BoxFit.contain,)
            )
        ),
        if(idx==2) (
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              padding: EdgeInsets.symmetric(horizontal: 100,vertical: 20),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(40)),
              backgroundColor: Colors.white
            ),
            child: Text("Let's Started",style: TextStyle(fontSize: 17,color: Colours.boldOrange,fontWeight:FontWeight.w600)),onPressed: (){
            Navigator.push(context, MaterialPageRoute(builder: (context)=>LoginPage()));
          },
          )
        ),
      ],
    );
  }
}
