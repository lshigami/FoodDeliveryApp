

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fooddeliveryapp/core/Screen/HomeScreen.dart';
import 'package:fooddeliveryapp/core/Screen/Page01.dart';
import 'package:get/get.dart';

class AuthController extends GetxController{
  static AuthController instance =Get.find();
  late Rx<User?>_user;
  FirebaseAuth auth = FirebaseAuth.instance;
  @override
  void onReady() {
    // TODO: implement onReady
    super.onReady();
    _user=Rx<User?>(auth.currentUser);
    _user.bindStream(auth.userChanges());
    ever(_user,_initialScreen);
  }
  _initialScreen(User? user){
    if(user!=null){
      Get.offAll(()=>HomeScreen());
    }
    else Get.offAll(()=>Page01());
  }
  void register(String email,password,confirmpass) async{
    if(password!=confirmpass){
      Get.snackbar("Error", "Password doesn't match",
          backgroundColor: Colors.red,
          snackPosition:SnackPosition.BOTTOM,
      );
    }
    else{
      try{
        await auth.createUserWithEmailAndPassword(email: email, password: password);
        FirebaseFirestore.instance.collection('Users').doc(FirebaseAuth.instance.currentUser!.uid).set({
          'Name':'Noname',
          'Email':email,
          'Phone':'Nophone',
          'Image':"https://firebasestorage.googleapis.com/v0/b/testfirestore-b7869.appspot.com/o/avatar%2Favtapp.png?alt=media&token=b7008aa8-c566-448d-9023-06f58dc872dd",
          'Total':0.0,
          'Cart':[],
        });

      }catch(e){
        Get.snackbar("About Register User", "User message",
            backgroundColor: Colors.red,
            snackPosition:SnackPosition.BOTTOM,
            titleText: Text("FAILD REGISTED",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 15),),
            messageText: Text(e.toString(),style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 15),)
        );
      }
    }

  }
  void login(String email,password) async{
    try{
      await auth.signInWithEmailAndPassword(email: email, password: password);
    }catch(e){
      Get.snackbar("About Login User", "User message",
          backgroundColor: Colors.red,
          snackPosition:SnackPosition.BOTTOM,
          titleText: Text("FAILD LOGIN",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 15),),
          messageText: Text(e.toString(),style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 15),)
      );
    }
  }
  void logOut()async{
    await auth.signOut();
  }
}
