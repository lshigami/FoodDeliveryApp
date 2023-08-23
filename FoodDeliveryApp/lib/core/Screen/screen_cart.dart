import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fooddeliveryapp/core/res/colours.dart';
import 'package:fooddeliveryapp/core/res/fonts.dart';
import 'package:fooddeliveryapp/core/res/image_res.dart';
import 'package:get/get.dart';
import 'package:fooddeliveryapp/core/Common/SightOfFood.dart';

class Screen_Cart extends StatelessWidget {
  int NumberofItem;
  Screen_Cart({super.key,required this.NumberofItem});

  @override
  Widget build(BuildContext context) {

    final CollectionReference _user = FirebaseFirestore.instance.collection('Users');
    final String uid = FirebaseAuth.instance.currentUser!.uid;
    RxInt amount=0.obs;
    Rx<double> totalcost =0.0.obs;

    Future<void> _update(double cost)async {
      await _user.doc(uid).update({'Total':FieldValue.increment(cost)});
    }

    return Scaffold(
      appBar: AppBar(
        title: Text("Your Order",style: TextStyle(color: Colors.black,fontFamily: Fonts.Cera,fontSize: 25),),
        backgroundColor: Colors.white,
        elevation: 0,
        actions: [
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: Icon(Icons.add_shopping_cart_sharp,color: Colors.black,size: 30,),
          ),
          // Text("${NumberofItem}",style: TextStyle(color: Color(0xFFFF6838),fontFamily: Fonts.Cera,fontSize: 25)),
        ],
      ),
      body: StreamBuilder(
        stream: _user.doc(uid).snapshots(),
        builder: (BuildContext context,AsyncSnapshot<DocumentSnapshot>snapshot){
          if(snapshot.hasData){

            double myValue = 1.0*(snapshot.data!['Total']);
            RxDouble myObservableValue = myValue.obs;
            totalcost=myObservableValue;

            final Map<String, dynamic> userData = snapshot.data!.data() as Map<String, dynamic>;
            final List<dynamic> cart = userData['Cart'];
            return ListView(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 20),
                  child: Center(
                    child: Container(
                      width: 380,
                      height: 125,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(25),
                          color: Color(0xFFFEEBC1)
                      ),
                      child: Padding(
                        padding: const EdgeInsets.only(left: 20,right: 20,top: 10,bottom: 10),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(right: 10),
                                      child: Image(image: AssetImage(ImageRes.homeicon)),
                                    ),
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text("Quang Thang",style: TextStyle(fontSize: 16,fontFamily: Fonts.Poppins,fontWeight: FontWeight.bold),),
                                        Container(
                                            width: 170,
                                            child: Text("Suoi Tien Theme Park, 9 District, Ho Chi Minh City",maxLines: 2,overflow: TextOverflow.ellipsis,style: TextStyle(color: Color(0xFF686868),fontSize: 12,fontWeight: FontWeight.bold,fontFamily: Fonts.Poppins),)
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                                Text("Edit Address",style: TextStyle(fontSize: 13,fontFamily: Fonts.Cera,fontWeight: FontWeight.bold)),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(right: 10),
                                      child: Container(
                                        width: 40,
                                        height: 35,
                                        child: Icon(Icons.access_time,color: Colors.black,),
                                        decoration: BoxDecoration(
                                            color: Color(0xFFE6B64E),
                                            borderRadius: BorderRadius.circular(10)
                                        ),
                                      ),
                                    ),
                                    Text("30 Minute",style: TextStyle(fontSize: 16,fontFamily: Fonts.Poppins,fontWeight: FontWeight.bold)),
                                  ],
                                ),
                                Text("Schedule Time",style: TextStyle(fontSize: 13,fontFamily: Fonts.Cera,fontWeight: FontWeight.bold)),

                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                Container(
                  child: ListView.builder(
                    shrinkWrap: true,

                    itemCount: cart.length ,
                    itemBuilder: (context,index){
                      final item = cart[index];
                      final String productUid = item['Uid'];
                      amount+=item['Quantity'];
                      RxInt costperone = 0.obs;
                      costperone+=item['Quantity'];
                      final DocumentReference productDocRef = FirebaseFirestore.instance.collection('Products').doc(productUid);

                      return FutureBuilder(
                          future: productDocRef.get(),
                          builder: (context, AsyncSnapshot<DocumentSnapshot> snapshot) {
                            if (snapshot.hasData) {
                              final Map<String, dynamic> productData = snapshot.data!.data() as Map<String, dynamic>;
                              final String imageUrl = productData['Image'];
                              final String nameProduct = productData['Name'];
                              final String nameRestaurant = productData['Restaurant'];
                              double cost = (productData['Cost'] * item['Quantity']).toDouble();
                              return  Padding(
                                padding: const EdgeInsets.only(left: 15,right: 15,top: 15),
                                child: Row(
                                  children: [
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(20),
                                      child: Image(image: NetworkImage(imageUrl),fit: BoxFit.cover,width: 90,height: 80,),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(left: 20),
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Container(width: 100,child: Text(nameProduct,style: TextStyle(fontFamily: Fonts.Poppins,fontWeight: FontWeight.bold,fontSize: 15,),maxLines: 2,overflow: TextOverflow.ellipsis,)),
                                          Container(width: 100,child: Text(nameRestaurant,style: TextStyle(fontFamily: Fonts.Poppins,fontSize: 12),maxLines: 2,overflow: TextOverflow.ellipsis,)),
                                        ],
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(left: 20),
                                      child: Container(
                                        width: 90,
                                        height: 35,
                                        decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(30),
                                            border: Border.all(
                                                color: Color(0xFFF8774A)
                                            )
                                        ),
                                        child: Padding(
                                          padding: const EdgeInsets.only(left: 15,right: 15),
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              InkWell(
                                                onTap: (){
                                                  for (int i = 0; i < cart.length; i++) {
                                                    final item = cart[i];
                                                    if (item['Uid'] == productUid) {
                                                      item['Quantity'] -= 1;
                                                      _update(-1.0*productData['Cost']);
                                                      if (item['Quantity'] == 0) {
                                                        // Xóa sản phẩm khỏi giỏ hàng
                                                        cart.removeAt(i);
                                                      }
                                                      _user.doc(uid).update({'Cart': cart});
                                                      break;
                                                    }
                                                  }
                                                },
                                                  child: Text('-',style: TextStyle(color: Color(0xFFF8774A),fontWeight: FontWeight.bold,fontSize:21,fontFamily: Fonts.Metro ),)
                                              ),
                                              Obx(()=> Text("${costperone}",style: TextStyle(color: Color(0xFFF8774A),fontWeight: FontWeight.bold,fontSize:21,fontFamily: Fonts.Metro ))),
                                              InkWell(
                                                  onTap: (){
                                                    _update(1.0*productData['Cost']);
                                                    for (int i = 0; i < cart.length; i++) {
                                                      final item = cart[i];
                                                      if (item['Uid'] == productUid) {
                                                        // totalcost +=(productData['Cost']).toDouble() ;

                                                        item['Quantity'] += 1;
                                                        _user.doc(uid).update({'Cart': cart});
                                                        break;
                                                      }
                                                    }
                                                  },
                                                  child: Text('+',style: TextStyle(color: Color(0xFFF8774A),fontWeight: FontWeight.bold,fontSize:21,fontFamily: Fonts.Metro )))
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(right: 8,left: 8),
                                      child: Text("${cost}\$",style: TextStyle(fontFamily: Fonts.Poppins,fontWeight: FontWeight.bold,fontSize: 14)),
                                    )
                                  ],
                                ),
                              );
                            }
                            else return CircularProgressIndicator();
                          }
                        );
                      },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 15,right: 15,top: 15,bottom: 15),
                  child: Stack(
                    children: [
                      Container(
                        width:MediaQuery.sizeOf(context).width,
                        height: 50,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(90),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black12,
                                blurRadius: 3,
                              )
                            ]
                        ),
                        child: TextField(
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderSide: const BorderSide(
                                width: 0,
                                style: BorderStyle.none,
                              ),
                            ),
                            hintText: "Enter Promo Code" ,
                            hintStyle: TextStyle(fontFamily: Fonts.Poppins,fontSize: 13,color: Color(0xFF9E9E9E)),
                          ),
                        ),
                      ),
                      Positioned(
                        right: 0,
                        child: Container(
                          width: 100,
                          height: 50,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(90),
                              color: Color(0xffF8774A)
                          ),
                          child: Center(child: Text("Apply",style: TextStyle(color: Colors.white,fontSize:14,fontWeight: FontWeight.bold,fontFamily: Fonts.Poppins ),)),
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 15,right: 15),
                  child: Container(
                      width: 380,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black12,
                              blurRadius: 3,
                            )
                          ]
                      ),
                      child:Padding(
                        padding: const EdgeInsets.only(left: 25,right: 25,top: 10,bottom: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text("Subtotal :",style: TextStyle(fontSize: 16,fontFamily: Fonts.Poppins,fontWeight: FontWeight.bold),),
                                Text("Delivery :",style: TextStyle(fontSize: 16,fontFamily: Fonts.Poppins,fontWeight: FontWeight.bold),),
                                Text("Discounted :",style: TextStyle(fontSize: 16,fontFamily: Fonts.Poppins,fontWeight: FontWeight.bold),),
                                Text("Total :",style: TextStyle(fontSize: 20,fontFamily: Fonts.Avenir,fontWeight: FontWeight.bold),),

                              ],
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text("${totalcost} \$",style: TextStyle(fontSize: 16,fontFamily: Fonts.Poppins,fontWeight: FontWeight.bold),),
                                Text("5 \$",style: TextStyle(fontSize: 16,fontFamily: Fonts.Poppins,fontWeight: FontWeight.bold),),
                                Text("0 \$",style: TextStyle(fontSize: 16,fontFamily: Fonts.Poppins,fontWeight: FontWeight.bold,color: Colors.green),),
                                Text("${totalcost+5} \$",style: TextStyle(fontSize: 20,fontFamily: Fonts.Avenir,fontWeight: FontWeight.bold,color: Colours.lightOrboldOrangeTextangeText),),

                              ],
                            ),
                          ],
                        ),
                      )
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 50,right: 50,top: 20),
                  child: Container(
                    width: 250,
                    height: 60,
                    decoration: BoxDecoration(
                        color: Colours.lightOrboldOrangeTextangeText,
                        borderRadius: BorderRadius.circular(30)
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("PAYMENT",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontFamily: Fonts.Poppins,fontSize: 20),),
                        Icon(Icons.arrow_forward_outlined,color: Colors.white,size: 28,)
                      ],
                    ),
                  ),
                )
              ],
            );
          }
          else return Center(child: CircularProgressIndicator());
        }
      )
    );
  }
}
