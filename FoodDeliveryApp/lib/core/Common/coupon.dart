import 'package:flutter/material.dart';
import 'package:coupon_uikit/coupon_uikit.dart';

// ignore: must_be_immutable
class HorizontalCouponExample1 extends StatelessWidget {
  String code;
  String content;
  String valid_date;
  String ?url;
  HorizontalCouponExample1({Key? key,required this.code,required this.content,required this.valid_date,this.url}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const Color primaryColor =Colors.white;
    const Color secondaryColor = Color(0xff97D5C8);

    return Padding(
      padding: const EdgeInsets.only(left: 20,right: 20,top: 10),
      child: CouponCard(
        height: 100,
        backgroundColor: primaryColor,
        curveAxis: Axis.vertical,
        firstChild: Container(
          decoration:  BoxDecoration(
            color: secondaryColor,
          ),
          child:Image(image: AssetImage(url??'assets/images/catco.png'),fit: BoxFit.cover,),
        ),
        secondChild: Container(
          width: double.maxFinite,
          padding: const EdgeInsets.all(18),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children:  [
              Text(
                'Coupon Code',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              SizedBox(height: 7),
              Text(
                content,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16,
                  color: Color(0xffF8774A),
                  fontWeight: FontWeight.bold,
                  overflow: TextOverflow.ellipsis
                ),
              ),
              Spacer(),
              Text(
                valid_date,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.black45,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
