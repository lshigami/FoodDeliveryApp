import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fooddeliveryapp/core/Screen/AddRestaurant.dart';
import 'package:fooddeliveryapp/core/res/colours.dart';
import 'package:fooddeliveryapp/core/res/fonts.dart';
import 'package:fooddeliveryapp/core/res/image_res.dart';
import 'package:get/get.dart';

class Restaurant extends StatefulWidget {
  const Restaurant({super.key});
  @override
  State<Restaurant> createState() => _RestaurantState();
}

class _RestaurantState extends State<Restaurant> {
  @override
  void initState() {
    isRestaurantEmpty();
    super.initState();
  }

  final CollectionReference _user =
      FirebaseFirestore.instance.collection('Users');
  final String uid = FirebaseAuth.instance.currentUser!.uid;
  late RxBool IsEmpty = true.obs;
  Future<void> isRestaurantEmpty() async {
    DocumentSnapshot userDoc = await _user.doc(uid).get();
    DocumentReference restaurant = userDoc['Restaurant'];
    if (restaurant.get().isBlank == true) {
      IsEmpty.value = true;
      print("true");
    } else {
      IsEmpty.value = false;
      print("false");
    }
  }

  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Restaurant",
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
      body: Container(
          child: Obx(
        () => (IsEmpty == true) ? NoData() : HasData(),
      )),
    );
  }
}

class NoData extends StatelessWidget {
  const NoData({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text("Add your Restaurant",
              style: TextStyle(
                  color: Colours.fieldText,
                  fontSize: 20,
                  fontFamily: Fonts.Nunito)),
          RawMaterialButton(
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => AddRestaurant()));
            },
            elevation: 2.0,
            fillColor: Colors.black,
            child: Icon(
              Icons.add,
              size: 20.0,
              color: Colors.white,
            ),
            padding: EdgeInsets.all(10.0),
            shape: CircleBorder(),
          ),
          Text("Add Restaurant",
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 20,
                  fontFamily: Fonts.Nunito,
                  fontWeight: FontWeight.bold)),
          Image(image: AssetImage(ImageRes.line))
        ],
      ),
    );
  }
}

class HasData extends StatefulWidget {
  const HasData({Key? key});

  @override
  State<HasData> createState() => _HasDataState();
}

class _HasDataState extends State<HasData> {
  final String uid = FirebaseAuth.instance.currentUser!.uid;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<DocumentSnapshot>(
      stream:
          FirebaseFirestore.instance.collection('Users').doc(uid).snapshots(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return CircularProgressIndicator();
        }

        if (!snapshot.hasData || !snapshot.data!.exists) {
          // Handle the case when the user document doesn't exist or is empty
          return Text('User document is empty or missing');
        }

        DocumentReference restaurantRef = snapshot.data!['Restaurant'];

        return StreamBuilder<DocumentSnapshot>(
          stream: restaurantRef.snapshots(),
          builder: (context, restaurantSnapshot) {
            if (restaurantSnapshot.hasError) {
              return Text('Error: ${restaurantSnapshot.error}');
            }

            if (restaurantSnapshot.connectionState == ConnectionState.waiting) {
              return CircularProgressIndicator();
            }

            if (!restaurantSnapshot.hasData ||
                !restaurantSnapshot.data!.exists) {
              // Handle the case when the 'Restaurant' document doesn't exist or is empty
              return Center(
                  child: Text('Restaurant document is empty or missing'));
            }

            // Retrieve data from the 'Restaurant' document
            Map<String, dynamic> restaurantData =
                restaurantSnapshot.data!.data() as Map<String, dynamic>;

            // Use the restaurant data to build your widgets
            // For example, you can access the 'name' field as follows:
            String restaurantName = restaurantData['name'] as String;
            String address = restaurantData['address'] as String;
            String imgLink = restaurantData['img'] as String;
            String phone = restaurantData['phone'] as String;
            String timeOpen = restaurantData['time open'] as String;
            String timeClose = restaurantData['time close'] as String;
            final size = MediaQuery.of(context).size;
            // Return the widgets based on the restaurant data
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Column(
                children: [
                  Container(
                    height: size.height / 3,
                    width: size.width,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      image: DecorationImage(
                        fit: BoxFit.cover,
                        image: NetworkImage(imgLink),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Center(
                    child: Text(
                      restaurantName,
                      style: TextStyle(
                        fontSize: 40,
                        fontFamily: Fonts.Restaurant,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Align(
                    alignment: Alignment.topLeft,
                    child: Text(
                      "🍽 Address: " + address,
                      style: TextStyle(
                        fontSize: 30,
                        fontFamily: Fonts.Restaurant,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Align(
                    alignment: Alignment.topLeft,
                    child: Text(
                      "☎️ Phone: " + phone,
                      style: TextStyle(
                        fontSize: 30,
                        fontFamily: Fonts.Restaurant,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Align(
                    alignment: Alignment.topLeft,
                    child: Text(
                      "🟢 Open: " + timeOpen,
                      style: TextStyle(
                        fontSize: 30,
                        fontFamily: Fonts.Restaurant,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Align(
                    alignment: Alignment.topLeft,
                    child: Text(
                      "🔴 Close: " + timeClose,
                      style: TextStyle(
                        fontSize: 30,
                        fontFamily: Fonts.Restaurant,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }
}
