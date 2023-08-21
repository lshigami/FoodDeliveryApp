
import 'package:flutter/material.dart';
import 'package:fooddeliveryapp/core/res/colours.dart';
import 'package:fooddeliveryapp/core/res/fonts.dart';
import 'package:fooddeliveryapp/core/res/image_res.dart';

final pictures=[ImageRes.page1,ImageRes.page2,ImageRes.page3];
final text=["Order Your Favorite Food","Choose Your Favorite Restaurant","Quick Shipping"];


class InputField extends StatelessWidget {
  String TextHint;
  final FontStyle;
  final Color ? fillcolor;
  final controler;
  InputField({super.key,required this.TextHint,required this.FontStyle,this.fillcolor,this.controler});

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controler ,
      decoration: InputDecoration(
          border: OutlineInputBorder(
              borderSide: const BorderSide(
                width: 0,
                style: BorderStyle.none,
              ),
              borderRadius: BorderRadius.circular(15)
          ),
          hintText: TextHint,

        hintStyle: TextStyle(fontFamily: FontStyle,fontSize: 16,color: Colours.fieldText),
        fillColor: fillcolor?? Colors.white,
        filled: true,
      ),
    );
  }
}


class OrangeButtonWithWhiteText extends StatelessWidget {
  double height ;
  double widgth ;
  String text;
  final VoidCallback ? Onpressed;
  OrangeButtonWithWhiteText({super.key,this.height=58 ,this.widgth= 400,required this.text,required this.Onpressed});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
          minimumSize: Size(widgth, height),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(40)),
          backgroundColor: Colours.boldOrange
      ),
      child: Text(text,style: TextStyle(fontSize: 15,color: Colours.whiteText,fontWeight:FontWeight.bold,fontFamily: Fonts.Poppins)),onPressed: Onpressed,
    );
  }
}

class BigText extends StatelessWidget {
  final String text;
  final FontType;
  final FontWeight;
  final Size;
  final Color;
  const BigText({super.key,required this.text,required this.FontType,required this.FontWeight,required this.Size,required this.Color});

  @override
  Widget build(BuildContext context) {
    return Text(text,style: TextStyle(fontSize: Size,fontWeight: FontWeight,fontFamily: FontType,color: Color),);
  }
}


class Tag1 extends StatelessWidget {
  const Tag1({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 380,
      height: 120,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topRight,
          end: Alignment.bottomLeft,
          colors: [
            Color(0xFF6AF0E0),
            Color(0xFF51B698),
          ],
        ),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 15,top: 5),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Select Preferences",style: TextStyle(color: Colors.white,fontFamily: Fonts.Poppins,fontWeight: FontWeight.bold,fontSize: 24),),
                Text("For multiple users",style: TextStyle(color: Colors.white,fontFamily: Fonts.Poppins,fontStyle: FontStyle.italic,fontSize: 13),),
                Padding(
                  padding: const EdgeInsets.only(top: 18),
                  child: BigText(text: "You can now oder from multiple\nrestaurants at the same time!", FontType: Fonts.Roboto, FontWeight: FontWeight.w400, Size: 15.0, Color: Colors.white),
                )
              ],
            ),
          ),
          Column(
            children: [
              Image(image: AssetImage(ImageRes.tag1)),
              Padding(
                padding: const EdgeInsets.only(top:8),
                child: Row(
                  children: [
                    Icon(Icons.arrow_forward_ios,color: Colors.white,size: 15,),
                    BigText(text: "SET THEM NOW", FontType: Fonts.Metro, FontWeight: FontWeight.bold, Size: 15.0, Color: Colors.white)
                  ],
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}

class Tag2 extends StatelessWidget {
  const Tag2({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 380,
      height: 120,
      decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
            colors: [
              Color(0xFFFCA384 ),
              Color(0xFFFB6A70 ),
            ]
          ),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 15,top: 5),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Rescued Food",style: TextStyle(color: Colors.white,fontFamily: Fonts.Poppins,fontWeight: FontWeight.bold,fontSize: 24),),
                Text("Saving food and hunger",style: TextStyle(color: Colors.white,fontFamily: Fonts.Poppins,fontStyle: FontStyle.italic,fontSize: 13),),
                Padding(
                  padding: const EdgeInsets.only(top: 18),
                  child: BigText(text: "Left over food and supplies are\ngathered and are sold for 50% off!", FontType: Fonts.Roboto, FontWeight: FontWeight.w400, Size: 15.0, Color: Colors.white),
                )
              ],
            ),
          ),
          Column(
            children: [
              Image(image: AssetImage(ImageRes.tag2),width: 130,height: 87,),
              Padding(
                padding: const EdgeInsets.only(top:8),
                child: Row(
                  children: [
                    Icon(Icons.arrow_forward_ios,color: Colors.white,size: 15,),
                    BigText(text: "ORDER NOW", FontType: Fonts.Metro, FontWeight: FontWeight.bold, Size: 15.0, Color: Colors.white)
                  ],
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}

final pages = [Tag1(), Tag2()];

final circeimage =[ImageRes.cir1,ImageRes.cir2,ImageRes.cir3,ImageRes.cir4];

class ListCircle extends StatelessWidget {
  const ListCircle({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 100,
      child: Center(
        child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: circeimage.length,
            itemBuilder: (BuildContext context,int index){
              return Container(
                alignment: Alignment.center,
                width: 60,
                height: 60,
                child: Padding(
                  padding: const EdgeInsets.only(left: 5,right: 5),
                  child: Image(image: AssetImage(circeimage[index])),
                ),
              );
            }
        ),
      ),
    );
  }
}

class Badget extends StatelessWidget {
  final int idx;
  final String info;
  const Badget({super.key,required this.idx,required this.info});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Image(image: AssetImage(circeimage[idx])),
        Text(info,style: TextStyle(color: Color(0xFF707070),fontSize: 15,fontWeight: FontWeight.w500,fontFamily: Fonts.Roboto),textAlign: TextAlign.center,)
      ],
    );
  }
}

class BestSellerPageView extends StatefulWidget {
  const BestSellerPageView({super.key});

  @override
  State<BestSellerPageView> createState() => _BestSellerPageViewState();
}

class _BestSellerPageViewState extends State<BestSellerPageView> {
  @override
  Widget build(BuildContext context) {
      return SizedBox(
        child: PageView.builder(itemBuilder: (context,idx){
          return Container(
            width: 190,
            height: 250,
            child: Column(
              children: [

              ],
            ),
          );
        }),
      );
  }
}
