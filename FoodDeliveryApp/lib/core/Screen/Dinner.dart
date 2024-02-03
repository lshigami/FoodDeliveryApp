import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fooddeliveryapp/core/Common/FireStore_Breakfast.dart';
import 'package:fooddeliveryapp/core/res/fonts.dart';

class DinnerCate extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Dinner For You",
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
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('MenuItem')
            .where('Category', isEqualTo: 'Dinner') // Filter by category
            .snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return CircularProgressIndicator(); // Loading indicator
          }

          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return Text('No dinner items available.');
          }

          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: ListView(
              // Use a ListView to display the list of breakfast items
              children: snapshot.data!.docs.map((DocumentSnapshot document) {
                var productName = document['Name'];
                var productImage = document['Image'];
                var productCost = document['Cost'];
                var restaurantReference = document['Restaurant'];

                return FutureBuilder<DocumentSnapshot>(
                  // Retrieve the restaurant reference
                  future: restaurantReference.get(),
                  builder: (BuildContext context,
                      AsyncSnapshot<DocumentSnapshot> restaurantSnapshot) {
                    if (restaurantSnapshot.connectionState ==
                        ConnectionState.waiting) {
                      return CircularProgressIndicator(); // Loading indicator
                    }

                    if (restaurantSnapshot.hasError) {
                      return Text('Error: ${restaurantSnapshot.error}');
                    }

                    if (!restaurantSnapshot.hasData) {
                      return Text('Restaurant data not available.');
                    }

                    var restaurantName = restaurantSnapshot.data!['name'];

                    return Container(
                      width: MediaQuery.of(context).size.width ,
                      height: MediaQuery.of(context).size.height/3,
                      margin: EdgeInsets.only(
                          bottom: 16.0), // Adjust spacing between items
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        image: DecorationImage(
                          image: NetworkImage(productImage),
                          fit: BoxFit.cover,
                        ),
                      ),
                      child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              productName,
                              style: TextStyle(
                                color: Colors.white,
                                fontFamily: Fonts.Poppins,
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: 8.0),
                            Text(
                              '\$$productCost', // Assuming Cost is a numeric field
                              style: TextStyle(
                                color: Colors.white,
                                fontFamily: Fonts.Poppins,
                                fontSize: 16,
                              ),
                            ),
                            SizedBox(height: 8.0),
                            Text(
                              'Restaurant: $restaurantName',
                              style: TextStyle(
                                color: Colors.white,
                                fontFamily: Fonts.Poppins,
                                fontSize: 16,
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                );
              }).toList(),
            ),
          );
        },
      ),
    );
  }
}
