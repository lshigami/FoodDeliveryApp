import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fooddeliveryapp/core/Common/SightOfFood.dart';
import 'package:fooddeliveryapp/core/res/image_res.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class Breakfast extends StatefulWidget {
  const Breakfast({super.key});

  @override
  State<Breakfast> createState() => _BreakfastState();
}

class _BreakfastState extends State<Breakfast> {
  final CollectionReference _product = FirebaseFirestore.instance.collection('Products');
  final breakfast =PageController(viewportFraction: 0.55);
  final ValueNotifier<int> _count = ValueNotifier<int>(0);

  int counter=0;
  @override
  void dispose(){
    super.dispose();
    breakfast.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return  Padding(
      padding: const EdgeInsets.all(10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 365,
            height: 370,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
            ),
            child: Stack(
              children: [
                Container(
                  width: 365,
                  height: 370,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Color(0xFFFDF9EA),
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 30,top: 15),
                      child: RichText(text: TextSpan(text: "Looking for",style: TextStyle(color: Color(0xFFF88922),fontSize: 20),children: [
                        TextSpan(text: " Breakfast",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold,color: Color(0xFFF88922)))
                      ])),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 30),
                      child: Text("Here’s what you might like to taste",style: TextStyle(fontSize: 14,color: Color(0xFFA6978A)),),
                    ),
                    Expanded(
                      child: StreamBuilder(
                          stream: _product.snapshots(),
                          builder: (context,AsyncSnapshot<QuerySnapshot>streamSnapshot){
                            if(streamSnapshot.hasData){
                              return Column(
                                children: [
                                  Expanded(
                                    child: PageView.builder(
                                        controller: breakfast,
                                        itemCount: streamSnapshot.data!.docs.length,
                                        itemBuilder: (context,index){
                                          final DocumentSnapshot documentSnapshot = streamSnapshot.data!.docs[index];
                                          _count.value = streamSnapshot.data!.docs.length;
                                          return InkWell(
                                            onTap: (){
                                              Navigator.push(context, MaterialPageRoute(builder: (context)=>CardofFood(urlImage: documentSnapshot['Image'], name: documentSnapshot['Name'], restaurant: documentSnapshot['Restaurant'], id: documentSnapshot['id'],cost: documentSnapshot['Cost'].toString(),)));
                                            },
                                            child: Padding(
                                              padding: const EdgeInsets.only(top: 30),
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
                                                        ]
                                                    ),
                                                    child:Column(
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
                                                                      Image(image: NetworkImage(documentSnapshot['Image']),fit: BoxFit.cover,width: 190,height: 135,),
                                                                      if( documentSnapshot['Sale']!="" ) TicketSale(percent: documentSnapshot['Sale'])
                                                                    ],
                                                                  ),
                                                                )
                                                            )
                                                        ),
                                                        Padding(
                                                          padding: const EdgeInsets.only(left: 10),
                                                          child: Text(documentSnapshot['Name'],style: TextStyle(fontWeight: FontWeight.bold,fontSize: 17),),
                                                        ),
                                                        Padding(
                                                          padding: const EdgeInsets.only(left: 10),
                                                          child: Text(documentSnapshot['Restaurant'],style: TextStyle(fontWeight: FontWeight.w300,fontSize: 14,color: Color(0xFF7C7C7C)),),
                                                        ),
                                                        Expanded(
                                                          child: Align(
                                                              alignment: Alignment.bottomLeft,
                                                              child: Padding(
                                                                padding: const EdgeInsets.only(left: 20,bottom: 10),
                                                                child: Text(documentSnapshot['Cost'].toString()+" \$",style: TextStyle(fontSize: 18,color: Color(0xFFE89528),fontWeight: FontWeight.bold),),
                                                              )
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          );
                                        }
                                    ),
                                  ),
                                  ValueListenableBuilder<int>(
                                    valueListenable: _count,
                                    builder: (context, count, child) {
                                      return Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          SmoothPageIndicator(
                                            controller: breakfast,
                                            count: count,
                                            effect: WormEffect(
                                              activeDotColor: Color(0xFFF88922),
                                              dotColor: Colors.grey.shade500,
                                              dotWidth: 10,
                                              dotHeight: 10,
                                            ),
                                          ),
                                        ],
                                      );
                                    },
                                  ),
                                ],
                              );
                            }
                            else{
                              return CircularProgressIndicator();
                            }
                          }
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}



// ignore: must_be_immutable
class TicketSale extends StatelessWidget {
  String percent;
  TicketSale({super.key,required this.percent});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Image(image: AssetImage("assets/images/ticks.png"),width:75,height: 26,),
        Padding(
          padding: const EdgeInsets.only(left: 6,top: 3),
          child: Text(percent,style: TextStyle(fontSize: 13,color: Colors.white,fontWeight: FontWeight.bold),),
        )
      ],
    );
  }
}
