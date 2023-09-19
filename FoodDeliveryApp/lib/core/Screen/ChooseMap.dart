import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:fooddeliveryapp/core/res/colours.dart';
import 'package:fooddeliveryapp/core/res/fonts.dart';
import 'package:get/get.dart';
import 'package:location/location.dart';
import 'package:mapbox_gl/mapbox_gl.dart';
import 'package:http/http.dart' as http;
class LocationSuggestion {
  final String name;
  final LocationData location;
  LocationSuggestion({required this.name, required this.location});
}
class AddressMapBox extends StatefulWidget {
  const AddressMapBox({super.key});

  @override
  State<AddressMapBox> createState() => _AddressMapBoxState();
}

class _AddressMapBoxState extends State<AddressMapBox> {

  RxString MyAddress=''.obs;

  late MapboxMapController _controller;
  LocationData? _locationData;
  String MyAdresss='';
  void _onMapCreated(MapboxMapController controller) {
    _controller = controller;
  }
  void _zoomIn() {
    _controller.animateCamera(CameraUpdate.zoomIn());
  }
  void _zoomOut() {
    _controller.animateCamera(CameraUpdate.zoomOut());
  }
  Future<void> _getCurrentLocation() async {
    final location = Location();
    // Check if location service is enabled
    bool serviceEnabled = await location.serviceEnabled();
    if (!serviceEnabled) {
      serviceEnabled = await location.requestService();
      if (!serviceEnabled) {
        return;
      }
    }

    // Check if permission is granted
    PermissionStatus permissionGranted = await location.hasPermission();
    if (permissionGranted == PermissionStatus.denied) {
      permissionGranted = await location.requestPermission();
      if (permissionGranted != PermissionStatus.granted) {
        return;
      }
    }

    // Get current location
    final locationData = await location.getLocation();
    setState(() async{
      _locationData = locationData;
      print("${locationData.latitude}, ${locationData.longitude}");
      String sex = await getAddressFromLatLng(locationData.latitude!, locationData.longitude!);
      print(sex);
      _controller.animateCamera(
        CameraUpdate.newLatLngZoom(LatLng(locationData.latitude!, locationData.longitude!),17),
      );
    });

  }
  Future<LatLng> _getCenterLocation() async {
    final visibleRegion = await _controller.getVisibleRegion();
    final southwest = visibleRegion.southwest;
    final northeast = visibleRegion.northeast;
    final centerLat = (northeast.latitude + southwest.latitude) / 2;
    final centerLng = (northeast.longitude + southwest.longitude) / 2;
    return LatLng(centerLat, centerLng);
  }
  void _updateLocation(LatLng newLocation) {
    setState(() {
      _controller.animateCamera(
        CameraUpdate.newLatLngZoom(newLocation,17),
      );
    });
  }

  Future<String> getAddressFromLatLng(double latitude, double longitude) async {
    final url = Uri.parse(
        'https://api.mapbox.com/geocoding/v5/mapbox.places/$longitude,$latitude.json?access_token=${dotenv.get('MAPBOX_ACCESS_TOKEN')}');
    final response = await http.get(url);
    final data = jsonDecode(response.body);
    if (data['features'] != null && data['features'].isNotEmpty) {
      return data['features'][0]['place_name'];
    } else {
      throw Exception('Failed to get address from coordinates');
    }
  }
  final TextEditingController _controllerText = TextEditingController();

  Future<List<LocationSuggestion>> search(String query) async {
    final url = Uri.parse(
        'https://api.mapbox.com/geocoding/v5/mapbox.places/$query.json?access_token=${dotenv.get('MAPBOX_ACCESS_TOKEN')}&proximity=106.6297,10.8231');
    final response = await http.get(url);
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return data['features']
          .map<LocationSuggestion>((json) => LocationSuggestion(
        name: json['place_name'],
        location: LocationData.fromMap({
          'latitude': json['geometry']['coordinates'][1],
          'longitude': json['geometry']['coordinates'][0],
        }),
      ))
          .toList();
    } else {
      throw Exception('Failed to load locations');
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colours.lightOrboldOrangeTextangeText,
        elevation: 0,
        title: Text('Choose Your Location',style: TextStyle(fontWeight: FontWeight.bold,fontFamily: Fonts.Poppins,fontSize: 20),),
        leading: InkWell(onTap: (){
          Navigator.pop(context);
        },child: Icon(Icons.arrow_back,size: 25,color: Colors.white,)),
      ),
      body:Stack(
        children: [
          MapboxMap(
            styleString: MapboxStyles.MAPBOX_STREETS,
            onMapCreated: _onMapCreated,
            accessToken: dotenv.get('MAPBOX_ACCESS_TOKEN'),
            initialCameraPosition: const CameraPosition(target: LatLng(10.866276536331597, 106.80332749115358)),
          ),
          Positioned(
            bottom: 80,
            right: 10,
            child: Column(
              children: [
                FloatingActionButton(
                  onPressed: _zoomIn,
                  child: const Icon(Icons.zoom_in),
                ),
                const SizedBox(height: 10),
                FloatingActionButton(
                  onPressed: _zoomOut,
                  child: const Icon(Icons.zoom_out),
                ),
                const SizedBox(height: 10),
                FloatingActionButton(
                  onPressed: _getCurrentLocation,
                  child: Icon(Icons.add_location_sharp),
                ),

              ],
            ),
          ),
          Positioned(
            bottom: 20,
            left: MediaQuery.sizeOf(context).width/2-100,
            height: 45,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colours.lightOrboldOrangeTextangeText,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
            onPressed: () async {
              final centerLocation = await _getCenterLocation();
              print('${centerLocation.latitude} and ${centerLocation.longitude}');
              String sex = await getAddressFromLatLng(centerLocation.latitude, centerLocation.longitude);
              MyAddress.value=sex;
              _controllerText.text=sex;
            },
            child: Text('Confirm Location',style: TextStyle(color: Colors.white,fontSize: 20,fontFamily: Fonts.Poppins,fontWeight: FontWeight.bold),)
          ),
          ),
          Positioned(
            top: MediaQuery.of(context).size.height / 2 - 25,
            left: MediaQuery.of(context).size.width / 2 - 25,
            child: Icon(Icons.location_on, size: 50, color: Colors.red),
          ),
          Positioned(
              top: 25,
              left: 20,
              width: MediaQuery.sizeOf(context).width,
              child: Padding(
                padding: const EdgeInsets.only(right: 40),
                child: TypeAheadField<LocationSuggestion>(
                  textFieldConfiguration: TextFieldConfiguration(
                    controller: _controllerText,
                    decoration: InputDecoration(
                      fillColor: Colors.white,
                      filled: true,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30.0),
                        borderSide: BorderSide.none,
                      ),
                      hintText: 'Enter a location',
                    ),
                  ),
                  suggestionsCallback: search,
                  noItemsFoundBuilder: (context)=>SizedBox.shrink(),
                  itemBuilder: (context, suggestion) {
                    return Padding(
                      padding: const EdgeInsets.only(left: 15,right: 15),
                      child: ListTile(
                        leading: Icon(Icons.location_on,color: Colors.red,),
                        title: Text(suggestion.name),
                      ),
                    );
                  },
                  onSuggestionSelected: (suggestion) {
                    _controllerText.text =suggestion.name;
                    final LatLng thise = LatLng(suggestion.location.latitude!,suggestion.location.longitude!);
                    print('${suggestion.location.latitude} , ${suggestion.location.longitude!}');
                    _updateLocation(thise);
                  },
                ),
              )
          ),
        ],
      ),
    );
  }
}
