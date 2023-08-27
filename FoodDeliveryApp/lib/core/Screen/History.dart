import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fooddeliveryapp/core/res/colours.dart';
import 'package:fooddeliveryapp/core/res/fonts.dart';
import 'package:fooddeliveryapp/core/res/image_res.dart';
import 'package:get/get.dart';

class History extends StatefulWidget {
  const History({super.key});

  @override
  State<History> createState() => _HistoryState();
}

class _HistoryState extends State<History> {
  @override
  void initState() {
    isBookMarkSavedEmpty();
    super.initState();
  }
  final CollectionReference _user = FirebaseFirestore.instance.collection('Users');
  final String uid = FirebaseAuth.instance.currentUser!.uid;

  Future<void> isBookMarkSavedEmpty() async {
    DocumentSnapshot userDoc = await _user.doc(uid).get();
    List<dynamic> bookmarkSaved = userDoc['History'];
    if (bookmarkSaved.isEmpty){
      IsEmpty.value=true;
      print("true");
    }
    else {
      IsEmpty.value=false;
      print("false");
    }
  }
  late RxBool IsEmpty =true.obs;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffF5F5F8),
      appBar: AppBar(
        title: Text("Your History Order",style: TextStyle(color: Colors.black,fontSize: 25,fontWeight: FontWeight.bold,fontFamily: Fonts.Poppins),),
        leading: InkWell(onTap: (){
          Navigator.pop(context);
        },child: Icon(Icons.arrow_back,size: 25,color: Colors.black,)),
        backgroundColor: Color(0xffF5F5F8),
        elevation: 0,
      ),
      body: Container(
          child:Obx(
                ()=>  (IsEmpty==true) ? WhenDoesntHasData() : WhenHasData(),
          )
      ),
    );
  }
}

class WhenDoesntHasData extends StatelessWidget {
  const WhenDoesntHasData({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text("Nothing yet ... ",style: TextStyle(color: Colours.fieldText,fontSize: 20,fontFamily: Fonts.Nunito),),
          Text("Buy something to help us",style: TextStyle(color: Colours.fieldText,fontSize: 20,fontFamily: Fonts.Nunito)),
          RawMaterialButton(
            onPressed: () {},
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
          Text("Buy Now",style: TextStyle(color: Colors.black,fontSize: 20,fontFamily: Fonts.Nunito,fontWeight: FontWeight.bold)),
          Image(image: AssetImage(ImageRes.line))
        ],
      ),
    );
  }
}
class WhenHasData extends StatefulWidget {
  const WhenHasData({super.key});

  @override
  State<WhenHasData> createState() => _WhenHasDataState();
}

class _WhenHasDataState extends State<WhenHasData> {
  final CollectionReference _user = FirebaseFirestore.instance.collection('Users');
  final String uid = FirebaseAuth.instance.currentUser!.uid;


  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: _user.doc(uid).snapshots(),
        builder: (BuildContext context,AsyncSnapshot<DocumentSnapshot>snapshot){
          if(snapshot.hasData){
            final Map<String, dynamic> userData = snapshot.data!.data() as Map<String, dynamic>;
            final List<dynamic> history = userData['History'];
            return Container(
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: history.length,
                itemBuilder: (context,index){
                 // final String productUid = item;
                 // final DocumentReference productDocRef = FirebaseFirestore.instance.collection('Products').doc(productUid);
                  final Map<String, dynamic> historyItem = history[index];
                  final List<dynamic> cart = historyItem['cart'];
                  final String historyTime = historyItem['time'];
                  final String total = historyItem['total'];
                  return Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.grey,
                          width: 1,
                        ),
                        borderRadius: BorderRadius.circular(20)
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ListView.builder(
                              shrinkWrap: true,
                              itemCount: cart.length,
                              itemBuilder: (context,index){
                                final Map<String, dynamic> details = cart[index];
                                final String size = details['Size'];
                                final String num =details['Quantity'].toString();
                                final String id = details['Uid'];
                                final DocumentReference productDocRef = FirebaseFirestore.instance.collection('Products').doc(id);
                                return FutureBuilder(
                                  future: productDocRef.get(),
                                    builder: (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot){
                                      if (snapshot.hasData) {
                                        final Map<String, dynamic> productData =snapshot.data!.data() as Map<String, dynamic>;
                                        final String name = productData['Name'];
                                        final String image = productData['Image'];
                                        return Padding(
                                          padding: const EdgeInsets.only(left: 20),
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              Row(
                                                children: [
                                                  ClipRRect(
                                                      borderRadius: BorderRadius.circular(30),
                                                      child: Container(
                                                        width: 40,height: 40,
                                                        child: Image(image: NetworkImage(image),fit: BoxFit.cover,),
                                                      )
                                                  ),
                                                  Padding(
                                                    padding: const EdgeInsets.only(left: 15),
                                                    child: Text(name,style: TextStyle(color: Colors.black, fontSize: 20,fontFamily: Fonts.Poppins),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.only(right: 20),
                                                child: Text(num,style: TextStyle(color: Colors.black, fontSize: 20,fontFamily: Fonts.Poppins)),
                                              ),
                                            ],
                                          ),
                                        );
                                      } else {
                                        return CircularProgressIndicator();
                                      }
                                    }
                                );
                              },
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 15,right: 15),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text("Time : ${historyTime}" ,style: TextStyle(color: Colors.blueAccent, fontSize: 15,fontFamily: Fonts.Poppins),),
                                  Text("Cost : ${total} \$" ,style: TextStyle(color: Colours.lightOrboldOrangeTextangeText, fontSize: 15,fontFamily: Fonts.Cera),),
                                  Text("Done",style: TextStyle(color: Colors.green,fontWeight: FontWeight.bold, fontSize: 15,fontFamily: Fonts.Poppins)),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            );
          }
          else return CircularProgressIndicator();
        }
    );
  }
}

