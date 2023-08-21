import 'package:flutter/material.dart';
import 'package:fooddeliveryapp/core/Common/SearchBloc.dart';
import 'package:fooddeliveryapp/core/Screen/HomeScreen.dart';
import 'package:fooddeliveryapp/core/res/colours.dart';
import 'package:fooddeliveryapp/core/res/fonts.dart';
import 'package:provider/provider.dart';


class SearchBox extends StatefulWidget {
  final SearchBloc bloc;
  SearchBox({required SearchBloc bloc}) : this.bloc=bloc;

  @override
  State<SearchBox> createState() => _SearchBoxState();
}

class _SearchBoxState extends State<SearchBox> {
  final searchcontroller= TextEditingController();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    searchcontroller.addListener(() {
      widget.bloc.Search(searchcontroller.text);
    });
  }
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.only(left: 22,right: 35),
        child: Container(
          height: 50,
          child: TextField(
            controller: searchcontroller,
            onChanged: (value) {
              if (value.isEmpty) {
                Provider.of<MyChangeNotifier>(context, listen: false).setMyBoolValue(true);
              } else {
                Provider.of<MyChangeNotifier>(context, listen: false).setMyBoolValue(false);
              }
            },
            decoration: InputDecoration(
              border: OutlineInputBorder(
                  borderSide: const BorderSide(
                    width: 0,
                    style: BorderStyle.none,
                  ),
                  borderRadius: BorderRadius.circular(15)
              ),
              prefixIcon: Icon(Icons.search),
              hintText: "Search food nearby",
              hintStyle: TextStyle(fontFamily: Fonts.Roboto,fontSize: 16,color: Colours.fieldText),
              fillColor: Color(0xFFF3F3F3),
              filled: true,
            ),
          ),
        ),
      ),
    );
  }
}


class Result extends StatefulWidget {
  final SearchBloc bloc;
  Result({required SearchBloc bloc}) : this.bloc=bloc;

  @override
  State<Result> createState() => _ResultState();
}

class _ResultState extends State<Result> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200,
      child: StreamBuilder<List<String>>(
        initialData: [],
        stream: widget.bloc.searchcontroller.stream,
        builder: (context,snapshot){
          return Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20)
            ),
            child: ListView.builder(
                itemCount: snapshot.data?.length,
                itemBuilder: (context,index){
                  return Padding(
                    padding: const EdgeInsets.only(left: 50,right: 50,bottom: 10),
                    child: Container(
                      width: 50,
                      height: 50,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topRight,
                          end: Alignment.bottomLeft,
                          colors: [
                            Color(0xFF6AF0E0),
                            Color(0xFF51B698),
                          ],
                        ),
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Flexible(child: Text(snapshot.data![index],style: TextStyle(fontSize: 20,color: Colors.white,fontWeight: FontWeight.bold),overflow: TextOverflow.ellipsis,))
                        ],
                      ),
                    ),
                  );
                }
            ),
          );
        },
      ),
    );
  }
}
