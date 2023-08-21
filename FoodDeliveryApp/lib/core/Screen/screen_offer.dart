import 'package:flutter/material.dart';
import 'package:fooddeliveryapp/core/Common/coupon.dart';
import 'package:fooddeliveryapp/core/res/fonts.dart';

class Screen_Offer extends StatelessWidget {
  const Screen_Offer({super.key});

  @override
  Widget build(BuildContext context) {
    String ship= 'assets/images/catshi.png';
    String pepsi= 'assets/images/pepsi.jpg';
    String coca= 'assets/images/coca.png';
    String momo= 'assets/images/momo.jpg';

    return  Container(
      color: Color(0xFFF5F5F8),

      child: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Center(child: Text("Some Coupons For Only You",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold,fontFamily: Fonts.Poppins,color: Color(0xFF0B666A)),)),
          ),
          HorizontalCouponExample1(content: 'Sale 50% for bill from 30\$', valid_date: 'Valid : 30/9/2023',),
          HorizontalCouponExample1(content: 'Sale 20% for bill from 15\$', valid_date: 'Valid : 30/9/2023'),
          HorizontalCouponExample1(content: 'Free delivery for bill from 10\$', valid_date: 'Valid : 30/9/2023',url: ship,),
          HorizontalCouponExample1(content: 'Free delivery for bill near 5 km', valid_date: 'Valid : 30/9/2023',url: ship,),
          HorizontalCouponExample1(content: 'Pepsi treats you up to 2\$', valid_date: 'Valid : 30/9/2023',url: pepsi,),
          HorizontalCouponExample1(content: 'Coca treats you up to 2\$', valid_date: 'Valid : 30/9/2023',url: coca,),
          HorizontalCouponExample1(content: 'Momo pay treats you up to 80% ', valid_date: 'Valid : 30/9/2023',url: momo,),

        ],
      ),
    );
  }
}
