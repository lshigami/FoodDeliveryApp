import 'package:flutter/material.dart';
import 'package:fooddeliveryapp/core/res/colours.dart';
import 'package:fooddeliveryapp/core/res/fonts.dart';

class Order extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text("Order",style: TextStyle(color: Colors.black,fontSize: 25,fontWeight: FontWeight.bold,fontFamily: Fonts.Poppins),),
        leading: InkWell(onTap: (){
          Navigator.pop(context);
        },child: Icon(Icons.arrow_back,size: 25,color: Colors.black,)),
        backgroundColor: Color(0xffF5F5F8),
        elevation: 0,
      ),
    );
  }
}
