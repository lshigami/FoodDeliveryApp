import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:fooddeliveryapp/core/Common/Authentication.dart';
import 'package:fooddeliveryapp/core/res/image_res.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';


import 'core/Screen/SplashScreen.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp().then((value) =>Get.put(AuthController()) );
  Stripe.publishableKey='pk_test_51NkejVKW8wbu5khDRkxZlm0BhF7d19Cth7VwPmvw7TEhnUi28HxauT6bu47W5KuoFFRJaAF14HjMulorycOsQ6iR00TfazbDSl';
  await Stripe.instance.applySettings();
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
