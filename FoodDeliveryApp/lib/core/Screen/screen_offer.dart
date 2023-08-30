import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fooddeliveryapp/core/Common/coupon.dart';
import 'package:fooddeliveryapp/core/Screen/CouponCard.dart';
import 'package:fooddeliveryapp/core/res/fonts.dart';

class Screen_Offer extends StatelessWidget {
  const Screen_Offer({super.key});

  @override
  Widget build(BuildContext context) {
    String ship= 'assets/images/catshi.png';
    String pepsi= 'assets/images/pepsi.jpg';
    String coca= 'assets/images/coca.png';
    String momo= 'assets/images/momo.jpg';
    final CollectionReference _vouchers = FirebaseFirestore.instance.collection('Vouchers');
    return  Container(
      color: Color(0xFFF5F5F8),
      child: ListView(
        children: [
          StreamBuilder(
              stream: _vouchers.doc('InCost').snapshots(),
              builder: (BuildContext context,AsyncSnapshot<DocumentSnapshot>snapshot){
                if(snapshot.hasData){
                  final Map<String, dynamic> voucherdata = snapshot.data!.data() as Map<String, dynamic>;
                  List<dynamic> tickets = voucherdata['Voucher'];
                  return Container(
                    child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: tickets.length,
                      itemBuilder: (context,index){
                        final item = tickets[index];
                        final String code = item['Code'];
                        final String content = item['Content'];
                        final String valid = item['Valid'];
                        return InkWell(
                            onTap: (){
                              Navigator.push(context, MaterialPageRoute(builder: (context)=>CouponCard(code: code, title: content, valid: valid)));
                            },
                            child: HorizontalCouponExample1(code: code, content: content, valid_date: valid));
                      },
                    ),
                  );
                }
                else return CircularProgressIndicator();
              }
          ),
          StreamBuilder(
              stream: _vouchers.doc('InShip').snapshots(),
              builder: (BuildContext context,AsyncSnapshot<DocumentSnapshot>snapshot){
                if(snapshot.hasData){
                  final Map<String, dynamic> voucherdata = snapshot.data!.data() as Map<String, dynamic>;
                  List<dynamic> tickets = voucherdata['Voucher'];
                  return Container(
                    child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: tickets.length,
                      itemBuilder: (context,index){
                        final item = tickets[index];
                        final String code = item['Code'];
                        final String content = item['Content'];
                        final String valid = item['Valid'];
                        return InkWell(
                            onTap: (){
                              Navigator.push(context, MaterialPageRoute(builder: (context)=>CouponCard(code: code, title: content, valid: valid)));
                            },
                            child: HorizontalCouponExample1(code: code, content: content, valid_date: valid,url: ship,));
                      },
                    ),
                  );
                }
                else return CircularProgressIndicator();
              }
          ),
        ],
      )
    );
  }
}
