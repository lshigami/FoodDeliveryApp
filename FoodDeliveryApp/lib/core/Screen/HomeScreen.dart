
import 'package:flutter/material.dart';
import 'package:fooddeliveryapp/core/Common/FireStore_Breakfast.dart';
import 'package:fooddeliveryapp/core/Common/SearchBloc.dart';
import 'package:fooddeliveryapp/core/Common/Search_Field_Food.dart';
import 'package:fooddeliveryapp/core/Common/listpage1.dart';
import 'package:fooddeliveryapp/core/Screen/screen_cart.dart';
import 'package:fooddeliveryapp/core/Screen/screen_home.dart';
import 'package:fooddeliveryapp/core/Screen/screen_offer.dart';
import 'package:fooddeliveryapp/core/Screen/screen_user.dart';
import 'package:fooddeliveryapp/core/res/colours.dart';
import 'package:fooddeliveryapp/core/res/fonts.dart';
import 'package:fooddeliveryapp/core/res/image_res.dart';
import 'package:provider/provider.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:animated_notch_bottom_bar/animated_notch_bottom_bar/animated_notch_bottom_bar.dart';

class MyChangeNotifier with ChangeNotifier {
  bool _myBoolValue = true;

  bool get myBoolValue => _myBoolValue;

  void setMyBoolValue(bool newValue) {
    _myBoolValue = newValue;
    notifyListeners();
  }
}

class HomeScreen extends StatefulWidget {
  HomeScreen({super.key});
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // final SearchBloc searchBloc = SearchBloc();
  // final pagecontroller =PageController();

  final _pagebarcontroller =PageController(initialPage: 0);
  final _controller =NotchBottomBarController(index: 0);
  int _currentPage = 0;

  final List<Widget> bottomBarPages = [
    const Screen_Home(),
    const Screen_Offer(),
    Screen_Cart(NumberofItem: 3),
    Screen_User(),
  ];

  @override
  void initState() {
    super.initState();
    _pagebarcontroller.addListener(() {
      setState(() {
        _currentPage = _pagebarcontroller.page!.round();
      });
    });
  }
  @override
  void dispose(){
    super.dispose();
    // pagecontroller.dispose();
    _pagebarcontroller.dispose();
  }
  @override
  Widget build(BuildContext context) {

    return ChangeNotifierProvider(
      create: (context) => MyChangeNotifier(),
      child: Scaffold(
        backgroundColor: Colors.white,
          appBar: _currentPage<2 ? AppBar(
            backgroundColor: Colors.white,
            elevation: 0,
            title:Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Home",style: TextStyle(color: Colors.black,fontFamily:Fonts.Poppins,fontWeight: FontWeight.bold,fontSize: 17),),
                Text("Suoi Tien Theme Park, 9 District, Ho Chi Minh City",overflow: TextOverflow.ellipsis,style: TextStyle(color: Color(0xFFB2B2B2),fontWeight: FontWeight.w500,fontSize: 16),)
              ],
            ),
            leading: Image(image: AssetImage(ImageRes.homeicon)),
            actions: [
              Image(image: AssetImage(ImageRes.heartblue))
            ],
          ) : null,
        body:PageView(
          controller: _pagebarcontroller,
          physics: NeverScrollableScrollPhysics(),
          children: List.generate(bottomBarPages.length, (index) => bottomBarPages[index]),
        ),
        extendBody: true,
        bottomNavigationBar: AnimatedNotchBottomBar(
          notchBottomBarController: _controller,
          durationInMilliSeconds: 100,
          bottomBarWidth: 50,
          removeMargins: true,
          notchColor: Color(0xFFFF6838),
          bottomBarItems: [
            BottomBarItem(inActiveItem: Image.asset(ImageRes.bbi1), activeItem: Image.asset(ImageRes.bbi1,color: Colors.white,),itemLabel: "Home"),
            BottomBarItem(inActiveItem: Image.asset(ImageRes.bbi2), activeItem: Image.asset(ImageRes.bbi2,color: Colors.white,),itemLabel: "Offer"),
            BottomBarItem(inActiveItem: Image.asset(ImageRes.bbi3), activeItem: Image.asset(ImageRes.bbi3,color: Colors.white,),itemLabel: "Cart"),
            BottomBarItem(inActiveItem: Image.asset(ImageRes.bbi4), activeItem: Image.asset(ImageRes.bbi4,color: Colors.white,),itemLabel: "User"),

          ],
          onTap: (index) {
            _pagebarcontroller.jumpToPage(index);
        },
        )
      )
    );
  }
}





