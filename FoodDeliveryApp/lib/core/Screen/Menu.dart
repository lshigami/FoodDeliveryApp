import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:fooddeliveryapp/core/Common/FireStore_Breakfast.dart';
import 'package:fooddeliveryapp/core/Common/listpage1.dart';
import 'package:fooddeliveryapp/core/res/fonts.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class Menu extends StatefulWidget {
  @override
  State<Menu> createState() => _MenuState();
}

class _MenuState extends State<Menu> {
  var  restaurantRef;
  String selectedCategory = 'Breakfast';
  @override
  void initState() {
    isRestaurantEmpty();
    fetchRestaurantReference(); // Fetch and set the reference
    super.initState();
  }

  Future<void> fetchRestaurantReference() async {
    final userDoc = await _user.doc(uid).get();
    final restaurant = userDoc['Restaurant'] as DocumentReference;
    restaurantRef = restaurant;
    setState(() {}); // Trigger a rebuild with the obtained reference
  }

  Set<String> seenValues = {};

  final CollectionReference _user =
      FirebaseFirestore.instance.collection('Users');
  final String uid = FirebaseAuth.instance.currentUser!.uid;
  late bool IsEmpty = true;
  Future<void> isRestaurantEmpty() async {
    DocumentSnapshot userDoc = await _user.doc(uid).get();
    DocumentReference restaurant = userDoc['Restaurant'];
    if (restaurant.get().isBlank == true) {
      IsEmpty = true;
    } else {
      IsEmpty = false;
    }
  }

  String imagefromCamera = "";
  final TextEditingController _namecontrol = TextEditingController();
  final TextEditingController _costControl = TextEditingController();
  final TextEditingController _saleControl = TextEditingController();
  Future<void> _addFood([DocumentSnapshot? documentSnapshot]) async {
    await showModalBottomSheet(
        context: context,
        builder: (BuildContext buildcontext) {
          return Column(
            children: [
              InputField(
                TextHint: "Enter the name of your food",
                FontStyle: Fonts.Poppins,
                controler: _namecontrol,
              ),
              InputField(
                TextHint: "Enter the cost",
                FontStyle: Fonts.Poppins,
                controler: _costControl,
              ),
              InputField(
                  TextHint: "Enter the promotion",
                  FontStyle: Fonts.Poppins,
                  controler: _saleControl),
              DropdownButton(
                elevation: 5,
                iconSize: 35,
                iconEnabledColor: Colors.black,
                value: selectedCategory,
                onChanged: (String? newValue) {
                  setState(() {
                    selectedCategory = newValue!;
                  });
                },
                items: ['Breakfast', 'Lunch', 'Dinner']
                    .map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(
                      value,
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Color(0xFFF8774A),
                          fontSize: 21),
                    ),
                  );
                }).toList(),
              ),
              IconButton(
                  onPressed: () async {
                    ImagePicker imagepicker = ImagePicker();
                    XFile? file = await imagepicker.pickImage(
                        source: ImageSource.gallery);
                    Reference root = FirebaseStorage.instance.ref();
                    Reference dir = root.child('avatar');
                    String uniqueFileName =
                        DateTime.now().millisecondsSinceEpoch.toString();
                    Reference imagesreal = dir.child(uniqueFileName);
                    await imagesreal.putFile(File(file!.path));
                    imagefromCamera = await imagesreal.getDownloadURL();
                  },
                  icon: Icon(Icons.camera_alt)),
              ElevatedButton(
                  onPressed: () async {
                    DocumentReference restaurantRef =
                        FirebaseFirestore.instance.collection('Users').doc(uid);
                    var userData = await restaurantRef.get();
                    var dataMap = userData.data()
                        as Map<String, dynamic>; // Explicitly cast to Map
                    var restaurant = dataMap['Restaurant'];
                    final food =
                        FirebaseFirestore.instance.collection('MenuItem').doc();
                    await food.set({
                      'Name': _namecontrol.text,
                      'Cost': _costControl.text,
                      'Sale': _saleControl.text,
                      'Image': imagefromCamera,
                      'Restaurant': restaurant,
                      'Category': selectedCategory,
                    });
                    _namecontrol.text = documentSnapshot?['Name'];
                    _costControl.text = documentSnapshot?['Cost'];
                    _saleControl.text = documentSnapshot?['Sale'];
                    Navigator.of(context).pop();
                  },
                  child: Text("UPLOAD FOOD"))
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Menu",
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
            )),
        backgroundColor: Color(0xffF5F5F8),
        elevation: 0,
        actions: [
          IconButton(
            onPressed: () async {
              if (IsEmpty == true) {
                Get.snackbar('Error', "You Have To Make A Restaurant First",
                    snackPosition: SnackPosition.TOP,
                    duration: Duration(seconds: 2));
              } else {
                _addFood();
              }
            },
            icon: Icon(
              Icons.add,
              color: Colors.black,
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance
              .collection(
                  'MenuItem') // Adjust this path to your database structure
              .where('Restaurant',
                  isEqualTo: restaurantRef) // Filter by restaurant reference
              .snapshots(),
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}');
            }

            if (snapshot.connectionState == ConnectionState.waiting) {
              return CircularProgressIndicator(); // Loading indicator
            }

            if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
              return Text('No menu items available.');
            }

            return SingleChildScrollView(
              child: GridView.builder(
                shrinkWrap: true,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2, // Number of columns
                  crossAxisSpacing: 10.0,
                  mainAxisSpacing: 10.0,
                ),
                itemCount: snapshot.data!.docs.length,
                itemBuilder: (BuildContext context, int index) {
                  var product = snapshot.data!.docs[index];
                  var productName = product['Name'];
                  var productImage = product['Image'];
                  var productCost = product['Cost'];
                  var productSale = product['Sale'];
                  final size = MediaQuery.of(context).size;
                  return InkWell(
                    onTap: () {},
                    child: Padding(
                      padding: const EdgeInsets.only(top: 0),
                      child: Stack(
                        children: [
                          Container(
                            width: 190,
                            height: 250,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                color: Colors.white,
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black12,
                                    blurRadius: 20,
                                  )
                                ]),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Align(
                                    alignment: Alignment.topCenter,
                                    child: ClipRRect(
                                        borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(20),
                                          topRight: Radius.circular(20),
                                        ),
                                        child: Hero(
                                          tag: 'back',
                                          child: Stack(
                                            children: [
                                              Image(
                                                image:
                                                    NetworkImage(productImage),
                                                fit: BoxFit.cover,
                                                width: 190,
                                                height: 135,
                                              ),
                                              if (productSale != "")
                                                TicketSale(percent: productSale)
                                            ],
                                          ),
                                        ))),
                                Padding(
                                  padding: const EdgeInsets.only(left: 10),
                                  child: Text(
                                    productName,
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 17),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 10),
                                  child: Text(
                                    "$productSale VND",
                                    style: TextStyle(
                                        fontWeight: FontWeight.w300,
                                        fontSize: 14,
                                        color: Color(0xFF7C7C7C)),
                                  ),
                                ),
                                Expanded(
                                  child: Align(
                                      alignment: Alignment.bottomLeft,
                                      child: Padding(
                                        padding: const EdgeInsets.only(
                                            left: 20, bottom: 10),
                                        child: Text(
                                          productCost.toString() + " \$",
                                          style: TextStyle(
                                              fontSize: 18,
                                              color: Color(0xFFE89528),
                                              fontWeight: FontWeight.bold),
                                        ),
                                      )),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            );
          },
        ),
      ),
    );
  }
}
