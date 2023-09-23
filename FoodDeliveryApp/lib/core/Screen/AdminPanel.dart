import 'package:flutter/material.dart';
import 'package:fooddeliveryapp/core/Screen/Menu.dart';
import 'package:fooddeliveryapp/core/Screen/Order.dart';
import 'package:fooddeliveryapp/core/Screen/Restaurant.dart';
import 'package:fooddeliveryapp/core/res/colours.dart';
import 'package:fooddeliveryapp/core/res/fonts.dart';
import 'package:fooddeliveryapp/core/res/image_res.dart';

class Admin extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Admin Panel",
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
      body: Container(
        color: Color(0xFFF3F3F3),
        child: Column(
          children: [
            SizedBox(
              height: 10,
            ),
            GestureDetector(
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => Restaurant()));
              },
              child: Center(
                child: Container(
                  width: size.width - 10,
                  height: size.height / 3 - 60,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    color: Colors.white,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        width: size.width / 3,
                        height: size.width / 2,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage(ImageRes.res),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        "Restaurant\nManagement",
                        style: TextStyle(
                          fontFamily: Fonts.Poppins,
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            GestureDetector(
              onTap: () {
                Navigator.push(
                    context, MaterialPageRoute(builder: (context) => Menu()));
              },
              child: Center(
                child: Container(
                  width: size.width - 10,
                  height: size.height / 3 - 60,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    color: Colors.white,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        width: size.width / 3,
                        height: size.width / 2,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage(ImageRes.menu),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        "Menu\nManagement",
                        style: TextStyle(
                          fontFamily: Fonts.Poppins,
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            GestureDetector(
              onTap: () {
                Navigator.push(
                    context, MaterialPageRoute(builder: (context) => Order()));
              },
              child: Center(
                child: Container(
                  width: size.width - 10,
                  height: size.height / 3 - 60,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    color: Colors.white,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        width: size.width / 3,
                        height: size.width / 2,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage(ImageRes.order),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        "Order\nManagement",
                        style: TextStyle(
                          fontFamily: Fonts.Poppins,
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
