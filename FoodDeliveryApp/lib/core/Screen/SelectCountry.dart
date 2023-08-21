import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:fooddeliveryapp/core/Common/Logo.dart';
import 'package:fooddeliveryapp/core/Screen/HomeScreen.dart';
import 'package:fooddeliveryapp/core/res/colours.dart';
import 'package:fooddeliveryapp/core/res/fonts.dart';

class Country extends StatelessWidget {
  const Country({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child:Container(
          color: Colours.darkOrange,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Align(
                alignment: Alignment.bottomRight,
                child: TextButton(
                  child: Text("SKIP >>",style: TextStyle(fontSize: 27,color: Colours.grayText,fontFamily: Fonts.Ninito,fontWeight: FontWeight.w800)),
                  onPressed: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>HomeScreen()));
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 30),
                child: Logo(w: 135,h: 135,),
              ),
              Text("Welcome Back",style: TextStyle(fontFamily: Fonts.Roboto,color: Colors.white,fontSize: 45)),
              Padding(
                padding: const EdgeInsets.only(top: 150,left: 35),
                child: Row(
                  children: [
                    Text("SELECT LOCATION",style: TextStyle(fontFamily: Fonts.Nunito,color: Colours.grayText,fontSize: 18)),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 35,right: 35,top: 10,bottom: 30),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      minimumSize: Size(250, 70),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(40)),
                      backgroundColor: Colors.white
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Icon(FontAwesomeIcons.magnifyingGlass,color: Color(0xFFFF460A),),
                      SizedBox(width: 20,),
                      Text("My Location",style: TextStyle(fontSize: 20,color: Color(0xFFFF460A),fontWeight:FontWeight.w900,fontFamily: Fonts.Poppins)),
                    ],
                  ),onPressed: (){},
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 35,right: 35,top: 10),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      minimumSize: Size(250, 70),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(40)),
                      backgroundColor: Colors.white
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Icon(FontAwesomeIcons.locationDot,color: Color(0xFFFF460A),),
                      SizedBox(width: 20,),
                      Text("Location",style: TextStyle(fontSize: 20,color: Color(0xFFFF460A),fontWeight:FontWeight.w900,fontFamily: Fonts.Poppins)),
                    ],
                  ),onPressed: (){},
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
