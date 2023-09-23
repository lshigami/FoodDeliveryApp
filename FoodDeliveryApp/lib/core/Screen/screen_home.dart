import 'package:flutter/material.dart';
import 'package:fooddeliveryapp/core/Common/FireStore_Breakfast.dart';
import 'package:fooddeliveryapp/core/Common/SearchBloc.dart';
import 'package:fooddeliveryapp/core/Common/Search_Field_Food.dart';
import 'package:fooddeliveryapp/core/Common/listpage1.dart';
import 'package:fooddeliveryapp/core/Screen/Breakfast2.dart';
import 'package:fooddeliveryapp/core/Screen/Dinner.dart';
import 'package:fooddeliveryapp/core/Screen/HomeScreen.dart';
import 'package:fooddeliveryapp/core/Screen/Lunch.dart';
import 'package:fooddeliveryapp/core/res/fonts.dart';
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
  final pagecontroller = PageController();
  void dispose() {
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
              SearchBox(
                bloc: searchBloc,
              ), // TextField
              Padding(
                padding: const EdgeInsets.only(right: 20),
                child: Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(
                          color: Color(0xFFC8C8C8),
                        ),
                        borderRadius: BorderRadius.circular(15)),
                    child: Image(image: AssetImage(ImageRes.filter))),
              ), // Image Filter
            ],
          ),
        ), // Search ROW
        Consumer<MyChangeNotifier>(
          builder: (context, myChangeNotifier, child) {
            return Visibility(
              visible: !myChangeNotifier.myBoolValue,
              child: Container(child: Result(bloc: searchBloc)),
            );
          },
        ),
        Padding(
          padding: const EdgeInsets.only(top: 15, bottom: 5),
          child: SizedBox(
            height: 120,
            child: PageView.builder(
              controller: pagecontroller,
              itemCount: pages.length,
              itemBuilder: (context, index) {
                return Padding(
                    padding: EdgeInsets.only(left: 20, right: 20),
                    child: pages[index]);
              },
            ),
          ),
        ), // PageView Postcard
        Center(
            child: SmoothPageIndicator(
                controller: pagecontroller,
                count: 2,
                effect: WormEffect(
                    activeDotColor: Color(0xFF53BA9D),
                    dotColor: Color(0xFFB8E4DE),
                    dotWidth: 10,
                    dotHeight: 10))),
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
        SizedBox(
          height: 10,
        ),
        Text(
          "  Categories",
          style: TextStyle(
            color: Color(0xFF333333),
            fontFamily: Fonts.Poppins,
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
        SizedBox(
          height: 10,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: Column(
            children: [
              Row(
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => BreakfastCate()));
                    },
                    child: Container(
                      height: 90,
                      width: MediaQuery.of(context).size.width / 2 - 16,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        image: DecorationImage(
                          image: NetworkImage(
                            "https://static-images.vnncdn.net/files/publish/2023/5/14/clever-junior-694.jpg",
                          ),
                          fit: BoxFit.cover,
                        ),
                      ),
                      child: Center(
                        child: Text(
                          "Breakfast",
                          style: TextStyle(
                            color: Colors.white,
                            fontFamily: Fonts.Poppins,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => LunchCate()));
                    },
                    child: Container(
                      height: 90,
                      width: MediaQuery.of(context).size.width / 2 - 16,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        image: DecorationImage(
                          image: NetworkImage(
                            "https://cdn.tgdd.vn/Files/2021/08/09/1373996/tu-lam-com-tam-suon-trung-don-gian-thom-ngon-nhu-ngoai-hang-202201071248422991.jpg",
                          ),
                          fit: BoxFit.cover,
                        ),
                      ),
                      child: Center(
                        child: Text(
                          "Lunch",
                          style: TextStyle(
                            color: Colors.white,
                            fontFamily: Fonts.Poppins,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 10,
              ),
              GestureDetector(
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => DinnerCate()));
                },
                child: Container(
                  height: 90,
                  width: MediaQuery.of(context).size.width / 2 - 16,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    image: DecorationImage(
                      image: NetworkImage(
                        "https://img.delicious.com.au/Pwnp-j1O/w1200/del/2022/08/ramenara-ramen-carbonara-172843-2.png",
                      ),
                      fit: BoxFit.cover,
                    ),
                  ),
                  child: Center(
                    child: Text(
                      "Dinner",
                      style: TextStyle(
                        color: Colors.white,
                        fontFamily: Fonts.Poppins,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
