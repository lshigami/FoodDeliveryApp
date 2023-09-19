import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:fooddeliveryapp/core/Common/Authentication.dart';
import 'package:fooddeliveryapp/core/Common/listpage1.dart';
import 'package:fooddeliveryapp/core/Screen/BookMark.dart';
import 'package:fooddeliveryapp/core/Screen/BoxNotification.dart';
import 'package:fooddeliveryapp/core/Screen/History.dart';
import 'package:fooddeliveryapp/core/Screen/YourCard.dart';
import 'package:fooddeliveryapp/core/res/fonts.dart';
import 'package:fooddeliveryapp/core/res/image_res.dart';
import 'package:image_picker/image_picker.dart';

class Screen_User extends StatefulWidget {
  Screen_User({super.key});

  @override
  State<Screen_User> createState() => _Screen_UserState();
}

class _Screen_UserState extends State<Screen_User> {
  final CollectionReference _user = FirebaseFirestore.instance.collection('Users');
  final String uid = FirebaseAuth.instance.currentUser!.uid;
  String imagefromCamera="";
  final TextEditingController _namecontrol = TextEditingController();
  final TextEditingController _emailcontrol = TextEditingController();
  final TextEditingController _numberphonecontrol = TextEditingController();
  Future<void>_update([DocumentSnapshot? documentSnapshot])async{
    if(documentSnapshot!=null){
      _namecontrol.text=documentSnapshot['Name'];
      _emailcontrol.text=documentSnapshot['Email'];
      _numberphonecontrol.text=documentSnapshot['Phone'];
    }
    await showModalBottomSheet(
        context: context,
        builder: (BuildContext buildcontext){
          return Column(
           children: [
             InputField(TextHint: "Enter new name", FontStyle:Fonts.Poppins,controler: _namecontrol,),
             InputField(TextHint: "Enter new email", FontStyle: Fonts.Poppins,controler: _emailcontrol,),
             InputField(TextHint: "Enter new phone number", FontStyle: Fonts.Poppins,controler:_numberphonecontrol),
             IconButton(onPressed: ()async{
               ImagePicker imagepicker= ImagePicker();
               XFile? file = await imagepicker.pickImage(source: ImageSource.gallery);
               Reference root =FirebaseStorage.instance.ref();
               Reference dir  =root.child('avatar');
               String uniqueFileName =DateTime.now().millisecondsSinceEpoch.toString();
               Reference imagesreal=dir.child(uniqueFileName);
               await imagesreal.putFile(File(file!.path));
               imagefromCamera =await imagesreal.getDownloadURL();
             }, icon: Icon(Icons.camera_alt)),

             ElevatedButton(onPressed: ()async{
               await _user.doc(uid).update({
                 'Name':_namecontrol.text,
                 'Email':_emailcontrol.text,
                 'Phone':_numberphonecontrol.text,
                 'Image':imagefromCamera,
               });
               _namecontrol.text=documentSnapshot?['Name'];
               _emailcontrol.text=documentSnapshot?['Email'];
               _numberphonecontrol.text=documentSnapshot?['Phone'];
               Navigator.of(context).pop();

             }, child: Text("SAVE CHANGE")
             )

           ],
          );
        }
    );
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color(0xFFF5F5F8),
      child: ListView(
        children:[
          Padding(
            padding: const EdgeInsets.only(top: 20,left: 15,right: 15,bottom: 15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Personal Details",style: TextStyle(fontFamily: Fonts.Poppins,fontWeight: FontWeight.w900,fontSize: 18),),
                GestureDetector(onTap: ()async{
                  final DocumentSnapshot documentSnapshot = await _user.doc(uid).get();
                  _update(documentSnapshot);
                  } ,child: Text("Edit",style: TextStyle(fontFamily: Fonts.Metro,fontSize: 15,color:Color(0xFFFA4A0C) ),),)
              ],
            ),
          ), // FIRST LINE
          StreamBuilder<DocumentSnapshot>(
              stream: _user.doc(uid).snapshots(),
              builder: (BuildContext context,AsyncSnapshot<DocumentSnapshot>snapshot){
                if(snapshot.hasData){
                  return  Padding(
                    padding: const EdgeInsets.all(10),
                    child: Container(
                      width: 364,
                      height: 155,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20),
                          boxShadow: [
                            BoxShadow(
                                blurRadius: 20,
                                color: Colors.black12
                            )
                          ]
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(right: 20),
                            child: Container(
                              width: 92,
                              height: 94,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(20),
                                child: Image(
                                  image: NetworkImage(snapshot.data!['Image']),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            )

                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(snapshot.data!['Name'],style: TextStyle(fontSize: 20,fontFamily: Fonts.Poppins,fontWeight: FontWeight.bold),overflow: TextOverflow.ellipsis,),
                              Text(snapshot.data!['Email'],style: TextStyle(fontFamily: Fonts.Roboto,color: Color(0xFF707070),fontSize: 15),),
                              // Image(image: AssetImage(ImageRes.line)),
                              Text(snapshot.data!['Phone'],style: TextStyle(fontFamily: Fonts.Poppins,color: Color(0xFF707070),fontSize: 15)),
                              // Image(image: AssetImage(ImageRes.line)),
                              // Text("# 30-06-2004",style: TextStyle(fontFamily: Fonts.Poppins,color: Color(0xFF707070),fontSize: 15)),
                            ],
                          ),
                        ],
                      ),
                    ),
                  );
                }
                else{
                  return CircularProgressIndicator();
                }
              }
          ),// CARD
          Padding(
            padding: const EdgeInsets.only(top: 15,bottom: 15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                InkWell(
                  onTap: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>BookMarks()));
                  },
                  child: Container(
                    width: 90,
                    height: 65,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20)
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.bookmark_outline_outlined),
                        Text("Bookmarks")
                      ],
                    ),
                  ),
                ), // BOOKMARK
                InkWell(
                  onTap: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>BoxNoti()));
                  },
                  child: Padding(
                    padding: const EdgeInsets.only(left: 8,right: 4),
                    child: Container(
                      width: 90,
                      height: 65,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20)
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.notifications_outlined),
                          Text("Notifications")
                        ],
                      ),
                    ),
                  ),
                ), // NOTIFICATION
                InkWell(
                  onTap: (){},
                  child: Padding(
                    padding: const EdgeInsets.only(left: 4,right: 8),
                    child: Container(
                      width: 90,
                      height: 65,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20)
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.settings_outlined),
                          Text("Settings")
                        ],
                      ),
                    ),
                  ),
                ), // SETTING
                InkWell(
                  onTap: (){},
                  child: Container(
                    width: 90,
                    height: 65,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20)
                    ),
                    child: InkWell(
                      onTap: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context)=>CreditCardScreen(cardNumber: "1111 2222 3333 4444", expiryDate: '111 ', cardHolderName: 'quang', cvvCode: '12345')));
                      },
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.payment_rounded),
                          Text("Payments")
                        ],
                      ),
                    ),
                  ),
                ), // PAYMENT
              ],
            ), //
          ), //4 icon
          Padding(
            padding: const EdgeInsets.only(left: 20,right: 20),
            child: Container(
              width: 365,
              height: 60,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(15)
              ),
              child: Padding(
                padding: const EdgeInsets.only(left: 15,right: 15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Your Order",style: TextStyle(fontSize: 20,fontFamily: Fonts.Poppins,fontWeight: FontWeight.bold),),
                    InkWell(onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>History()));
                    },child: Icon(Icons.arrow_forward_ios,size: 19,))
                  ],
                ),
              ),
            ),
          ), // Order
          Padding(
            padding: const EdgeInsets.only(left: 20,right: 20,top: 15,bottom: 15),
            child: Container(
              width: 365,
              height: 60,
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(15)
              ),
              child: Padding(
                padding: const EdgeInsets.only(left: 15,right: 15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Feedback & Refunds",style: TextStyle(fontSize: 20,fontFamily: Fonts.Poppins,fontWeight: FontWeight.bold),),
                    Icon(Icons.arrow_forward_ios,size: 19,)
                  ],
                ),
              ),
            ),
          ), // Feedback
          // Padding(
          //   padding: const EdgeInsets.only(left: 20,right: 20,bottom: 15),
          //   child: Container(
          //     width: 365,
          //     height: 60,
          //     decoration: BoxDecoration(
          //         color: Colors.white,
          //         borderRadius: BorderRadius.circular(15)
          //     ),
          //     child: Padding(
          //       padding: const EdgeInsets.only(left: 15,right: 15),
          //       child: Row(
          //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //         children: [
          //           Text("My Preferences",style: TextStyle(fontSize: 20,fontFamily: Fonts.Poppins,fontWeight: FontWeight.bold),),
          //           Icon(Icons.arrow_forward_ios,size: 19,)
          //         ],
          //       ),
          //     ),
          //   ),
          // ), // Mypreferences
          Padding(
            padding: const EdgeInsets.only(left: 20,right: 20),
            child: Container(
              width: 365,
              height: 60,
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(15)
              ),
              child: Padding(
                padding: const EdgeInsets.only(left: 15,right: 15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Help",style: TextStyle(fontSize: 20,fontFamily: Fonts.Poppins,fontWeight: FontWeight.bold),),
                    Icon(Icons.arrow_forward_ios,size: 19,)
                  ],
                ),
              ),
            ),
          ), // Help
          Padding(
            padding: const EdgeInsets.only(left: 22,top: 20,bottom: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Send Feedback",style: TextStyle(fontFamily: Fonts.Poppins,fontWeight: FontWeight.bold,fontSize: 18)),
                Padding(
                  padding: const EdgeInsets.only(top: 10,bottom: 10),
                  child: Text("Report an Emergency",style: TextStyle(fontFamily: Fonts.Poppins,fontWeight: FontWeight.bold,fontSize: 18)),
                ),
                Text("Rate us on the PlayStore",style: TextStyle(fontFamily: Fonts.Poppins,fontWeight: FontWeight.bold,fontSize: 18)),
                Padding(
                  padding: const EdgeInsets.only(top: 10,bottom: 10),
                  child: Text("Report an Emergency",style: TextStyle(fontFamily: Fonts.Poppins,fontWeight: FontWeight.bold,fontSize: 18)),
                ),
                GestureDetector(child: Text("Log Out",style: TextStyle(fontFamily: Fonts.Poppins,fontWeight: FontWeight.bold,fontSize: 18,color: Color(0xFFFA4A0C)),),onTap: (){AuthController.instance.logOut();},)
              ],
            ),
          ),
          OrangeButtonWithWhiteText(text: "UPDATE", Onpressed: (){},widgth: 314,height: 49,)
        ] ,
      ),
    );
  }
}
