
import 'package:fooddeliveryapp/core/Common/Authentication.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:fooddeliveryapp/core/res/fonts.dart';
import 'package:intl/intl.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';

class AddRestaurant extends StatefulWidget {
  @override
  State<AddRestaurant> createState() => _AddRestaurantState();
}

class _AddRestaurantState extends State<AddRestaurant> {
  final CollectionReference _user =
      FirebaseFirestore.instance.collection('Users');
  final CollectionReference _restaurant =
      FirebaseFirestore.instance.collection('Restaurant');
  final String uid = FirebaseAuth.instance.currentUser!.uid;
  String imagefromCamera = "";
  final TextEditingController _namecontrol = TextEditingController();
  final TextEditingController _numberphonecontrol = TextEditingController();
  final TextEditingController _addressController = TextEditingController();

  TextEditingController timeinput1 = TextEditingController();
  TextEditingController timeinput2 = TextEditingController();
  @override
  void initState() {
    timeinput1.text = ""; //set the initial value of text field
    timeinput2.text = ""; //set the initial value of text field
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    timeinput1.dispose();
    timeinput2.dispose();
    _namecontrol.dispose();
    _numberphonecontrol.dispose();
    _addressController.dispose();
  }

  Future createRestaurant(
      {required String name,
      required String phone,
      required String address,
      required String timeOpen,
      required String timeClose,
      required img}) async {
    final res = FirebaseFirestore.instance.collection('Restaurant').doc();
    final json = {
      'name': name,
      'phone': phone,
      'address': address,
      'time open': timeOpen,
      'time close': timeClose,
      'img': img,
    };
    await res.set(json);
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Add Restaurant",
          style: TextStyle(
              color: Colors.black,
              fontSize: 25,
              fontWeight: FontWeight.bold,
              fontFamily: Fonts.Poppins),
        ),
        leading: InkWell(
          onTap: () {
            Navigator.pop(context);
          },
          child: Icon(
            Icons.arrow_back,
            size: 25,
            color: Colors.black,
          ),
        ),
        backgroundColor: Color(0xffF5F5F8),
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 5, right: 5),
        child: Column(
          children: [
            SizedBox(
              height: 10,
            ),
            TextField(
              controller: _namecontrol,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: "Enter restaurant's name",
              ),
            ),
            SizedBox(
              height: 10,
            ),
            TextField(
              controller: _numberphonecontrol,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: "Enter restaurant's phone number",
              ),
            ),
            SizedBox(
              height: 10,
            ),
            TextField(
              controller: _addressController,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: "Enter restaurant's address",
              ),
            ),
            SizedBox(
              height: 10,
            ),
            TextField(
              controller: timeinput1, //editing controller of this TextField
              decoration: InputDecoration(
                  icon: Icon(Icons.timer), //icon of text field
                  labelText: "Enter Opening Time" //label text of field
                  ),
              readOnly:
                  true, //set it true, so that user will not able to edit text
              onTap: () async {
                TimeOfDay? pickedTime = await showTimePicker(
                  initialTime: TimeOfDay.now(),
                  context: context,
                );

                if (pickedTime != null) {
                  String formattedTime = pickedTime
                      .format(context); // Use the formatted time directly
                  setState(() {
                    timeinput1.text =
                        formattedTime; // Set the value of the text field.
                  });
                } else {
                  print("Time is not selected");
                }
              },
            ),
            SizedBox(
              height: 10,
            ),
            TextField(
              controller: timeinput2, //editing controller of this TextField
              decoration: InputDecoration(
                  icon: Icon(Icons.timer), //icon of text field
                  labelText: "Enter Closing Time" //label text of field
                  ),
              readOnly:
                  true, //set it true, so that user will not able to edit text
              onTap: () async {
                TimeOfDay? pickedTime = await showTimePicker(
                  initialTime: TimeOfDay.now(),
                  context: context,
                );

                if (pickedTime != null) {
                  String formattedTime = pickedTime
                      .format(context); // Use the formatted time directly
                  setState(() {
                    timeinput2.text =
                        formattedTime; // Set the value of the text field.
                  });
                } else {
                  print("Time is not selected");
                }
              },
            ),
            SizedBox(
              height: 10,
            ),
            IconButton(
              onPressed: () async {
                ImagePicker imagepicker = ImagePicker();
                XFile? file =
                    await imagepicker.pickImage(source: ImageSource.gallery);
                Reference root = FirebaseStorage.instance.ref();
                Reference dir = root.child('avatar');
                String uniqueFileName =
                    DateTime.now().millisecondsSinceEpoch.toString();
                Reference imagesreal = dir.child(uniqueFileName);
                await imagesreal.putFile(File(file!.path));
                imagefromCamera = await imagesreal.getDownloadURL();
              },
              icon: Icon(Icons.camera_alt),
            ),
            ElevatedButton(
              onPressed: () async {
                await createRestaurant(
                    name: _namecontrol.text,
                    phone: _numberphonecontrol.text,
                    address: _addressController.text,
                    timeOpen: timeinput1.text,
                    timeClose: timeinput2.text,
                    img: imagefromCamera);
                    final res = FirebaseFirestore.instance.collection('Restaurant').doc;
                _user.doc(uid).update({
                  'Restaurant': res,
                });
                Navigator.of(context).pop();
              },
              child: Text("SAVE CHANGE"),
            ),
          ],
        ),
      ),
    );
  }
}
