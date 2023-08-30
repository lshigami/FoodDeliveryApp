import 'package:flutter/material.dart';
import 'package:fooddeliveryapp/core/res/fonts.dart';

class CouponCard extends StatefulWidget {
  String code;
  String title;
  String valid;
  CouponCard({super.key,required this.code,required this.title,required this.valid});

  @override
  State<CouponCard> createState() => _CouponCardState();
}

class _CouponCardState extends State<CouponCard> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NestedScrollView(
        physics: NeverScrollableScrollPhysics(),
          floatHeaderSlivers: true,
          headerSliverBuilder: (context, innerBoxIsScrolled)=>[
            SliverAppBar(
              leading: InkWell(onTap: (){
                Navigator.pop(context);
              },child: Icon(Icons.arrow_back,size: 25,color: Colors.black,)),
              backgroundColor: Colors.white,
              expandedHeight: 250,
              flexibleSpace: FlexibleSpaceBar(
                background: Image.network('https://th.bing.com/th/id/OIG.mfr4JXZuLU3lyIvxfmbZ?pid=ImgGn',fit: BoxFit.cover,),
              ),
              floating: true,
              pinned: false,
              snap: true,
              stretch: true,
              elevation: 0,
              shape: LinearBorder.bottom(),
            ),
          ],
          body:Stack(
            children: [
              Container(
                color: Colors.white,
              ),
              Positioned(
                right: 30,left: 30,top: 0,
                child: Container(
                  width: 250,
                  height: 150,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey,
                        blurRadius: 5,
                        spreadRadius: 1,
                        offset: Offset(0,6)
                      )
                    ]
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 10,bottom: 5),
                        child: Container(
                          width: 120,
                          height: 35,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            color: Color(0xff97D5C8)
                          ),
                          child: Center(child: Text(widget.code,style: TextStyle(fontSize: 19,color: Colors.white,fontWeight: FontWeight.bold,fontFamily: Fonts.Cera),)),
                        ),
                      ),
                      Container(
                        width: 200,
                        child: Text(widget.title,maxLines: 2,overflow: TextOverflow.ellipsis,style: TextStyle(fontSize: 25,fontFamily: Fonts.Avenir,fontWeight: FontWeight.bold),textAlign: TextAlign.center,),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 5),
                        child: Text(widget.valid,style: TextStyle(fontSize: 15,fontFamily: Fonts.Poppins,fontWeight: FontWeight.bold,color: Colors.grey)),
                      ),
                    ],
                  ),
                ),
              ),
              Positioned(
                top: 160,
                height: 270,
                left: 30,right: 30,
                child: Container(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("• Coupon only applies to participating restaurants.",style: TextStyle(fontFamily: Fonts.Poppins,fontWeight: FontWeight.bold,fontSize: 15),),
                      Text("• Coupon can be used once a day and reused the next day.",style: TextStyle(fontFamily: Fonts.Poppins,fontWeight: FontWeight.bold,fontSize: 15),),
                      Text("• The program may change content and end earlier than expected according to company policy.",style: TextStyle(fontFamily: Fonts.Poppins,fontWeight: FontWeight.bold,fontSize: 15),),
                      Text("• For more infomation, please contact Customer Service via email  [fastfood@lecle.vn] .",style: TextStyle(fontFamily: Fonts.Poppins,fontWeight: FontWeight.bold,fontSize: 15),),
                    ],
                  ),
                ),
              )
            ],
          )
      ),
    );
  }
}
