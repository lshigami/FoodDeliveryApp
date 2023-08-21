import 'package:flutter/material.dart';
import 'package:fooddeliveryapp/core/Common/FireStore_Breakfast.dart';
import 'package:fooddeliveryapp/core/Common/SearchBloc.dart';
import 'package:fooddeliveryapp/core/Common/Search_Field_Food.dart';
import 'package:fooddeliveryapp/core/Common/listpage1.dart';
import 'package:fooddeliveryapp/core/Screen/HomeScreen.dart';
import 'package:fooddeliveryapp/core/res/image_res.dart';
import 'package:provider/provider.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class Screen_Home extends StatefulWidget {
  const Screen_Home({super.key});

  @override
  State<Screen_Home> createState() => _Screen_HomeState();
}

class _Screen_HomeState extends State<Screen_Home> {
  final SearchBloc searchBloc = SearchBloc();
  final pagecontroller =PageController();
  void dispose(){
    super.dispose();
    pagecontroller.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 5),
          child: Row(
            children: [
              SearchBox(bloc:searchBloc ,), // TextField
              Padding(
                padding: const EdgeInsets.only(right: 20),
                child: Container(
                    width: 40,
                    height: 40,
                    decoration:BoxDecoration(
                        color: Colors.white,border: Border.all(color: Color(0xFFC8C8C8),),borderRadius: BorderRadius.circular(15)
                    ),
                    child: Image(image: AssetImage(ImageRes.filter))
                ),
              ), // Image Filter
            ],
          ),
        ), // Search ROW
        Consumer<MyChangeNotifier>(
          builder: (context, myChangeNotifier, child) {
            return Visibility(
              visible: !myChangeNotifier.myBoolValue,
              child: Container(
                  child: Result(bloc: searchBloc)
              ),
            );
          },
        ),
        Padding(
          padding: const EdgeInsets.only(top:15,bottom: 5),
          child: SizedBox(
            height: 120,
            child: PageView.builder(
              controller: pagecontroller,
              itemCount: pages.length,
              itemBuilder: (context, index) {
                return Padding(
                    padding: EdgeInsets.only(left: 20,right: 20),
                    child: pages[index]
                );
              },
            ),
          ),
        ), // PageView Postcard
        Center(child: SmoothPageIndicator(controller: pagecontroller, count: 2,effect: WormEffect(activeDotColor: Color(0xFF53BA9D),dotColor: Color(0xFFB8E4DE),dotWidth: 10,dotHeight: 10))),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Badget(idx: 0, info: "Hot Deals"),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Badget(idx: 1, info: "New On\nFastFood"),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Badget(idx: 2, info: "Save Food\nSave Hunger"),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Badget(idx: 3, info: "Set Your\nPreferences\nNow!"),
            )
          ],
        ),
        Breakfast(),

      ],
    );
  }
}
