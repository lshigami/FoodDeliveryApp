import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:fooddeliveryapp/core/Common/listpage1.dart';
import 'package:fooddeliveryapp/core/res/fonts.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;
import 'package:flutter_animated_button/flutter_animated_button.dart';

import '../model/ModelDetail.dart';



class CardofFood extends StatefulWidget {
  String urlImage;
  String name;
  String restaurant;
  int id;
  String cost;


  CardofFood({super.key,required this.urlImage,required this.name,required this.restaurant,required this.id,required this.cost});

  @override
  State<CardofFood> createState() => _CardofFoodState();
}

class _CardofFoodState extends State<CardofFood> {
  late FoodData foodData;
  String dropdownValue1='S';
  bool loading = true;


  RxInt counter=1.obs;

  final CollectionReference _user = FirebaseFirestore.instance.collection('Users');
  final String uid = FirebaseAuth.instance.currentUser!.uid;

  Future<void> _create(int counter,String size) async {
    final QuerySnapshot querySnapshot = await FirebaseFirestore.instance.collection('Products').where('Name', isEqualTo: widget.name).get();
    String idProduct = querySnapshot.docs.first.id;
    DocumentSnapshot userSnapshot = await _user.doc(uid).get();
    Map<String, dynamic> userData = userSnapshot.data()! as Map<String, dynamic>;
    List<dynamic> cart = userData['Cart'] ?? [];
    int productIndex = cart.indexWhere((item) => item[item.keys.elementAt(0)] == idProduct);
    if (productIndex != -1) {
      cart[productIndex]['Quantity'] += counter;
    } else {
      cart.add({'Quantity': counter,'Uid':idProduct,'Size':size});
    }
    await _user.doc(uid).update({'Cart': cart});
    await _user.doc(uid).update({'Total':FieldValue.increment(counter*double.parse(widget.cost))});
  }

  Future<void>_addBookMarks()async{
    final QuerySnapshot querySnapshot = await FirebaseFirestore.instance.collection('Products').where('Name', isEqualTo: widget.name).get();
    String idProduct = querySnapshot.docs.first.id;
    _user.doc(uid).update({'Marked':FieldValue.arrayUnion([idProduct])});
  }

  Future<void> _removeBookMarks() async {
    final QuerySnapshot querySnapshot = await FirebaseFirestore.instance.collection('Products').where('Name', isEqualTo: widget.name).get();
    String idProduct = querySnapshot.docs.first.id;
    _user.doc(uid).update({
      'Marked': FieldValue.arrayRemove([idProduct])
    });
  }
  Future<void> checkIsBookmarked() async {
    final QuerySnapshot querySnapshot = await FirebaseFirestore.instance.collection('Products').where('Name', isEqualTo: widget.name).get();
    String idProduct = querySnapshot.docs.first.id;
    DocumentSnapshot userDoc = await _user.doc(uid).get();
    if (userDoc.exists && userDoc['Marked'] != null) {
      List<dynamic> bookmarkSaved = userDoc['Marked'];
      isBookmarked.value = bookmarkSaved.contains(idProduct);
    } else {
      isBookmarked.value = false;
    }
  }


  @override
  void initState() {
    fetchData();
    checkIsBookmarked();
    super.initState();
  }

  RxBool isBookmarked = false.obs;

  Future<void> fetchData() async {
    var url = Uri.parse(
        "https://api.nal.usda.gov/fdc/v1/food/${widget.id}?api_key=3RgmWJp67HOvEnVLRkgj0OY8UqO8yy0arDYNn3MZ");
    var response = await http.get(url);
    if (response.statusCode == 200) {
      var decodedResponse = convert.jsonDecode(response.body);
      foodData = FoodData.fromMap(decodedResponse);
      setState(() {
        loading = false;
      });
    } else {
      throw Exception('Failed to load data');
    }
  }

  @override
  Widget build(BuildContext context) {
    double h=MediaQuery.sizeOf(context).height;
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            Positioned(
                left: 0,
                right: 0,
                top: 0,
                height: h*1.1/3,
                child: Image(image: NetworkImage(widget.urlImage),fit: BoxFit.cover,)
            ), // image
            Positioned(
              left: 15,
                right: 15,
                top: 15,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.5),
                            spreadRadius: 0.2,
                            blurRadius: 20,
                          ),
                        ],
                      ),
                      child: Hero(tag: 'back',
                          child: InkWell(
                              child: Icon(Icons.arrow_back_ios_sharp, color: Colors.white),
                            onTap: ()=>Navigator.pop(context),
                          )
                      ),
                    ),
                    Stack(
                      children: [
                        Container(
                          width:118,
                          height: 38,
                          decoration: BoxDecoration(
                              color: Colors.black.withOpacity(0.5),
                              borderRadius: BorderRadius.circular(20),
                              border: Border.all(
                                color: Colors.white,
                                width: 1.3,
                              )
                          ),
                        ),
                        Positioned(
                          left: 20,top: 10,
                            child: Image(image: AssetImage('assets/images/Ellipse 36.png'))
                        ),
                        Positioned(
                            left: 31,top: 10,
                            child: Image(image: AssetImage('assets/images/Ellipse 36.png'))
                        ),
                        Positioned(
                          top: 4.5, right: 32,
                            child: Text('4.5',style: TextStyle(color: Colors.white,fontSize: 21,fontWeight: FontWeight.bold,fontFamily: Fonts.Poppins),)
                        ),
                        Positioned(
                            right: 11,top: 12,
                            child: Image(image: AssetImage('assets/images/Star 17.png'))
                        ),
                      ],
                    )
                  ],
                )
            ), // icon va *
            Positioned(
              top: h*1/3,left: 0,right: 0,
                child: Container(
                  height: h*2/3,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(topLeft: Radius.circular(30),topRight: Radius.circular(20))
                  ),
                )
            ), // white ground
            Positioned(
              left: 50,
                right: 200,
                top: h*1/3-20,
                child: Container(
                  width: 200,
                  height: 51,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(30),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black38,
                        blurRadius: 10
                      )
                    ]
                  ),
                  child: Center(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 6,right: 3),
                          child: Text(widget.name,style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontFamily: Fonts.Poppins,fontSize: 18),overflow: TextOverflow.ellipsis,maxLines: 1,),
                        ),
                        Text(widget.restaurant,style: TextStyle(color: Colors.black,fontFamily: Fonts.Poppins,fontSize: 12),)
                      ],
                    ),
                  ),
                )), // TAG name
            Positioned(
                 top: h*1/3-30,
                 right: 40,
                child:Obx(
                  ()=>InkWell(
                    onTap: (){
                      if (isBookmarked.value) {
                        // Xóa khỏi bookmark
                        _removeBookMarks();
                        isBookmarked.value = false;
                      } else {
                        _addBookMarks();
                        isBookmarked.value = true;
                      }
                    },
                    child: (isBookmarked==true) ? Container(
                      width: 60,
                        height: 60,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: CupertinoColors.systemPink,
                            width: 3
                          )
                        ),
                        child: Center(child: Icon(CupertinoIcons.heart_fill,color: CupertinoColors.systemPink,size: 30,))
                    )
                        : Container(
                        width: 60,
                        height: 60,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            shape: BoxShape.circle,
                            border: Border.all(
                                color: CupertinoColors.black,
                                width: 3
                            )
                        ),
                        child: Center(child: Icon(Icons.heart_broken_sharp,color: Colors.black,size: 30,))
                    )
                  ),
                ),

            ), // heart
            Positioned(
              top: h*1/3+50,left: 30,right: 30,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Description",style: TextStyle(color:Color(0xFF5E5959),fontFamily: Fonts.Avenir,fontSize: 20,fontWeight: FontWeight.bold ),),
                      Container(width: 150,child: Text('This dish is a delicious meal made with fresh ingredients, packed with flavor and nutrition. Enjoy it alone or with sides.😊',style: TextStyle(fontSize: 12,fontFamily: Fonts.Poppins),maxLines: 6,overflow: TextOverflow.ellipsis,)),
                      Row(
                        children: [
                          Text("Must-try     ",style: TextStyle(fontSize: 11,color: Color(0xFF9E9E9E),fontWeight: FontWeight.bold,fontFamily: Fonts.Poppins),),
                          Icon(Icons.access_time,color: Colors.red,size: 15,),
                          Text('     30 min',style: TextStyle(fontSize: 11,color: Color(0xFF9E9E9E),fontWeight: FontWeight.bold,fontFamily: Fonts.Poppins))
                        ],
                      )
                    ],
                  ), // Description
                  Column(
                    children: [
                      Text("Nutritional Value",style: TextStyle(color:Color(0xFF5E5959),fontFamily: Fonts.Avenir,fontSize: 20,fontWeight: FontWeight.bold )),
                      Image(image: AssetImage('assets/images/line.png')),
                      loading ? Text('...Please wait T_T ... ',style: TextStyle(fontSize: 14,fontFamily: Fonts.Poppins,fontStyle: FontStyle.italic)) :
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            height: 75,
                            width: 150,
                            child: ListView.builder(
                                itemCount: foodData == null ? 0: foodData.foodNutrients!.length,
                                itemBuilder: (context,index){
                                  var nutrient = foodData.foodNutrients![index].nutrient!;
                                  return Container(
                                    child: ((nutrient.name!.contains('Protein') || nutrient.name!.contains('Carbohydrate')  || nutrient.name!.contains('Sodium')  || nutrient.name!.contains('Potassium')) &&foodData.foodNutrients![index].amount !=null ) ?
                                       Row(
                                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                     children: [
                                       Text("${nutrient.name.replaceAll(", by difference", "")}",
                                           style: TextStyle(fontSize: 13,fontFamily: Fonts.Poppins,fontStyle: FontStyle.italic,color: Colors.black)),
                                       Text(" ${foodData.foodNutrients![index].amount} ${nutrient.unitName}",
                                           style: TextStyle(fontSize: 12,fontFamily: Fonts.Poppins,fontWeight: FontWeight.bold,color: Colors.black)),
                                     ],
                                       ) : Padding(padding: EdgeInsets.all(0.000000000001)),
                                  );
                                }
                            ),
                          ),
                          Text('Rich in Vitamin A, C,K and E',style: TextStyle(fontSize: 12,fontFamily: Fonts.Poppins,fontStyle: FontStyle.italic)),

                        ],
                      ), // Nutrional Value,
                      Image(image: AssetImage('assets/images/line.png')),
                      Row(
                        children: [
                          Image(image: AssetImage('assets/images/fire.png'),),
                          Text("Approximate ~ 100 calo",style: TextStyle(fontSize: 9,color: Color(0xFF9E9E9E),fontWeight: FontWeight.bold,fontFamily: Fonts.Poppins))
                        ],
                      )
                    ],
                  ),

                ],
              ),
            ),
            Positioned(
              top: h-h/2.5,
              left: MediaQuery.sizeOf(context).width/4-10,
              // right:  MediaQuery.sizeOf(context).width/4-10,
                child: Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 8,right: 8),
                      child: Image(image: AssetImage('assets/images/fast.png'),width: 40,height: 40,),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 8,right: 8),
                      child: Image(image: AssetImage('assets/images/clean.png'),width: 40,height: 40,),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 8,right: 8),
                      child: Image(image: AssetImage('assets/images/cheap.png'),width: 40,height: 40,),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 8),
                      child: Image(image: AssetImage('assets/images/covid.png'),width: 40,height: 40,),
                    )

                  ],
                )
            ),
            Positioned(
              bottom: 10,
              left: 30,
              right: 30,
              child: Stack(
                children: [
                  Container(
                    height: 58,
                    decoration: BoxDecoration(
                      color: Color(0xFFF8774A),
                      borderRadius: BorderRadius.circular(30)
                    ),
                  ),
                  Positioned(
                    right: 17,top: 11,bottom: 11,
                    child: Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle
                      ),
                    ),
                  ),
                  Positioned(
                    right: 25,top: 15,
                      child: InkWell(
                        onTap: (){
                          _create(counter.value,dropdownValue1);
                          Get.snackbar('Product Added', "You Have Added The ${widget.name} To The Cart",snackPosition: SnackPosition.TOP,duration: Duration(seconds: 1));
                        },
                          child: Image(image: AssetImage('assets/images/giohang.png'))
                      )
                  ),
                  Positioned(
                    left: 30,top: 15,
                    child: Text('${widget.cost} \$',style: TextStyle(color: Colors.white,fontFamily: Fonts.Avenir,fontWeight:  FontWeight.bold,fontSize: 21),),
                  ),
                  Positioned(
                    left: 110,top: 10,
                    child: Container(
                      width: 140,
                      height: 40,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                        border: Border.all(
                          color: Colors.white
                        )
                      ),
                      child: Padding(
                        padding: const EdgeInsets.only(left: 15,right: 15),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            InkWell(
                                onTap:(){if(counter.value>1) counter.value--; } ,
                                child: Text('-',style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize:21,fontFamily: Fonts.Metro ),)
                            ),
                            Obx(()=>Text("${counter}",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize:21,fontFamily: Fonts.Metro ))),
                            InkWell(
                                onTap: (){counter.value++;},
                                child: Text('+',style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize:21,fontFamily: Fonts.Metro ))
                            )
                          ],
                        ),
                      ),
                    ),
                  )

                ],
              ),
            ),
            Positioned(
             top: h-h/3,
              left: MediaQuery.of(context).size.width/8,
              width: 290,
              height: 35,
              child: Container(
                width: 290,
                height: 35,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Color(0xFFF1F1F1)
                ),
                child: Padding(
                  padding: const EdgeInsets.only(left: 8,right: 8),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Select Size ",style: TextStyle(color: Color(0xFF5E5959),fontFamily: Fonts.Poppins,fontSize: 17,fontWeight: FontWeight.bold),),
                      DropdownButton(
                        elevation: 5,
                        iconSize: 35,
                        iconEnabledColor: Colors.black,
                        value: dropdownValue1,
                        onChanged: (String? newValue) {
                          setState(() {
                            dropdownValue1 = newValue!;
                          });
                        },
                        items: ['S', 'M', 'L', 'XL']
                            .map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value,style: TextStyle(fontWeight: FontWeight.bold,color: Color(0xFFF8774A),fontSize: 21),),
                          );
                        }).toList()
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Positioned(
              top: h-h/3.5,
              left: 20,
              child: Text("Addtions",style: TextStyle(color: Color(0xFF5E5959),fontFamily: Fonts.Poppins,fontSize: 19,fontWeight: FontWeight.bold,fontStyle: FontStyle.italic)),
            ),
            Positioned(
              bottom: h/11,
              left: 30,
              right: 30,
              child: Container(
                width: 360,
                height: 40,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  border: Border.all(
                    color: Color(0xFFF8774A)
                  )
                ),
              ),
            ),
            Positioned(
              bottom: h/11,
              width: 360,
              height: 40,
              child: Padding(
                padding: const EdgeInsets.only(top: 15,left: 40),
                child: TextField(
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderSide: const BorderSide(
                        width: 0,
                        style: BorderStyle.none,
                      ),
                    ),
                    hintText: "Leave a message for the restaurant here " ,
                    hintStyle: TextStyle(fontFamily: Fonts.Poppins,fontSize: 13,color: Color(0xFF9E9E9E)),
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
