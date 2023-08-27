import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fooddeliveryapp/core/res/colours.dart';
import 'package:fooddeliveryapp/core/res/fonts.dart';
import 'package:fooddeliveryapp/core/res/image_res.dart';
import 'package:get/get.dart';

class BookMarks extends StatefulWidget {
  const BookMarks({super.key});

  @override
  State<BookMarks> createState() => _BookMarksState();
}

class _BookMarksState extends State<BookMarks> {
  @override
  void initState() {
    isBookMarkSavedEmpty();
    super.initState();
  }
  final CollectionReference _user = FirebaseFirestore.instance.collection('Users');
  final String uid = FirebaseAuth.instance.currentUser!.uid;

  Future<void> isBookMarkSavedEmpty() async {
    DocumentSnapshot userDoc = await _user.doc(uid).get();
    List<dynamic> bookmarkSaved = userDoc['Marked'];
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
        title: Text("All Bookmarks",style: TextStyle(color: Colors.black,fontSize: 25,fontWeight: FontWeight.bold,fontFamily: Fonts.Poppins),),
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
          Text("Add your favorite food places",style: TextStyle(color: Colours.fieldText,fontSize: 20,fontFamily: Fonts.Nunito)),
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
          Text("Add Places",style: TextStyle(color: Colors.black,fontSize: 20,fontFamily: Fonts.Nunito,fontWeight: FontWeight.bold)),
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

  Future<void> _removeBookMarks(String name) async {
    final QuerySnapshot querySnapshot = await FirebaseFirestore.instance.collection('Products').where('Name', isEqualTo: name).get();
    String idProduct = querySnapshot.docs.first.id;
    _user.doc(uid).update({
      'Marked': FieldValue.arrayRemove([idProduct])
    });
  }


  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: _user.doc(uid).snapshots(),
        builder: (BuildContext context,AsyncSnapshot<DocumentSnapshot>snapshot){
          if(snapshot.hasData){
            final Map<String, dynamic> userData = snapshot.data!.data() as Map<String, dynamic>;
            List<dynamic> bookmarkSaved = userData['Marked'];
            return Container(
              child: ListView.builder(
                shrinkWrap: true,

                itemCount: bookmarkSaved.length,
                itemBuilder: (context,index){
                  final item = bookmarkSaved[index];
                  final String productUid = item;
                  final DocumentReference productDocRef = FirebaseFirestore.instance.collection('Products').doc(productUid);
                  return FutureBuilder(
                      future: productDocRef.get(),
                      builder: (context, AsyncSnapshot<DocumentSnapshot> snapshot){
                        if(snapshot.hasData){
                          final Map<String, dynamic> productData = snapshot.data!.data() as Map<String, dynamic>;
                          return Padding(
                            padding: const EdgeInsets.only(left:20,right: 20,top: 10,bottom: 10),
                            child: Container(
                              height: 120,
                              width: MediaQuery.sizeOf(context).width-30,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                color: Colors.white
                              ),
                              child: Row(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(left: 10),
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(15),
                                      child: Image(image: NetworkImage(productData['Image']),fit: BoxFit.cover,width: 120,height: 100,),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 10,right: 5),
                                    child: Container(
                                      width: 180,
                                        child: Text(productData['Name'],style: TextStyle(color: Colors.black,fontSize: 20,fontFamily: Fonts.Poppins,fontWeight: FontWeight.bold),maxLines: 1,overflow: TextOverflow.ellipsis,)),
                                  ),
                                  InkWell(onTap: (){
                                    _removeBookMarks(productData['Name']);
                                  },child: Icon(Icons.remove_circle_rounded,color: Colors.pinkAccent,size: 25,))
                                ],
                              ),
                            ),
                          );
                        }
                        else return CircularProgressIndicator();
                      }
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

