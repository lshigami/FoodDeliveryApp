import 'package:flutter/material.dart';
import 'package:fooddeliveryapp/core/res/colours.dart';
import 'package:fooddeliveryapp/core/res/fonts.dart';

class BoxNoti extends StatefulWidget {
  const BoxNoti({super.key});

  @override
  State<BoxNoti> createState() => _BoxNotiState();
}

class _BoxNotiState extends State<BoxNoti> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Notification Center",style: TextStyle(color: Colors.black,fontSize: 25,fontWeight: FontWeight.bold,fontFamily: Fonts.Poppins),),
        leading: InkWell(onTap: (){
          Navigator.pop(context);
        },child: Icon(Icons.arrow_back,size: 25,color: Colors.black,)),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
    );
  }
}
