import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:fooddeliveryapp/core/Common/Authentication.dart';
import 'package:fooddeliveryapp/core/res/image_res.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';


import 'core/Screen/SplashScreen.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp().then((value) =>Get.put(AuthController()) );
  runApp( MyApp());
}


class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const GetMaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}
