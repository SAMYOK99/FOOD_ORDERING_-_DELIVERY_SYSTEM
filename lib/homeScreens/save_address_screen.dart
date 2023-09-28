import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:my_tiffin/globalVariables/globleVariable.dart';
import 'package:my_tiffin/models/address.dart';
import 'package:my_tiffin/widgets/text_field.dart';

class SavedAddressScreen extends StatelessWidget {

  final _name = TextEditingController();
  final _phoneNumber = TextEditingController();
  final _chowk = TextEditingController();
  final _city = TextEditingController();
  final _state = TextEditingController();
  final _country = TextEditingController();
  final _locationController = TextEditingController();
  final _completeAddress= TextEditingController();
  final formKey = GlobalKey<FormState>();
  LocationPermission? permission;
  List<Placemark>? placemarks;
  Position? position;

  SavedAddressScreen({super.key});

  getUserLocation() async {
    permission = await Geolocator.requestPermission();
    Position newPosition = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high
    );
    position = newPosition;
    placemarks = await placemarkFromCoordinates(
        position!.latitude, position!.longitude);
    Placemark pMark = placemarks![0];
    String fullAdress = "${pMark.subThoroughfare}, ${pMark.thoroughfare}, ${pMark.subLocality}, ${pMark.locality}, ${pMark.subAdministrativeArea}, ${pMark.administrativeArea}, ${pMark.postalCode}, ${pMark.country}";
    _locationController.text = fullAdress;
    _chowk.text = "${pMark.subThoroughfare}, ${pMark.thoroughfare}, ${pMark.subLocality}, ${pMark.locality}";
    _city.text= "${pMark.subAdministrativeArea}";
    _state.text = " ${pMark.administrativeArea}";
    _country.text = "${pMark.country}";
    _completeAddress.text = fullAdress;



  }

  LocationBottomNavBar(){
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      height: 70,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          ElevatedButton(
            onPressed: (){
              if(formKey.currentState!.validate())
                {
                  final model = Address(
                    name: _name.text.trim(),
                    phoneNumber: _phoneNumber.text.trim(),
                    chowk: _chowk.text.trim(),
                    city: _city.text.trim(),
                    country: _country.text.trim(),
                    fullAddress: _completeAddress.text.trim(),
                    lat: position!.latitude,
                    lng: position!.longitude,

                  ).toJson();
                  FirebaseFirestore.instance.collection("users")
                      .doc(sharedPreferences!.getString("uid"))
                      .collection("userAddress").doc(DateTime.now().millisecondsSinceEpoch.toString())
              .set(model).then((value)
              {
                Fluttertoast.showToast(msg: "New address has been saved.");
                formKey.currentState!.reset();

              });
                }

            },
            style: ButtonStyle(
              backgroundColor: const MaterialStatePropertyAll(Colors.green),
              padding: const MaterialStatePropertyAll(EdgeInsets.symmetric(vertical: 15,horizontal: 20,),),
              shape: MaterialStatePropertyAll(RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),)),
            ),
            child: const Text('Save', style: TextStyle(fontWeight: FontWeight.bold,fontSize:16,),),
          )],
    ));

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(
          size: 33,
            color: Colors.green
        ),
        backgroundColor: Colors.white,

        elevation: 0.0,
      ),

      body: ListView(
        children: [
          SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Column(
                children: [
                  Container(
                    padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
                    alignment: Alignment.centerLeft,
                    child: Text("Save Address:",style: TextStyle(
                      color: Colors.black,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),),
                  ),

                ListTile(
                  leading: Icon(
                    Icons.person_pin_circle,
                    color: Colors.green,
                    size: 35,
                  ),
                  title: Container(
                    width: 250,
                    child: TextField(
                      style: TextStyle(
                        color: Colors.black,
                      ),
                      controller: _locationController,
                      decoration: InputDecoration(
                        hintText: "Your Address?",
                        hintStyle: TextStyle(
                          color: Colors.black
                         )
                      ),
                    ),
                  ),
                ),
                 const SizedBox(height: 10,),
                  Container(
                    width: 400,
                    height: 40,
                    alignment: Alignment.center,
                    child: ElevatedButton.icon(

                      onPressed: () {
                        getUserLocation();
                      },
                      icon: const Icon(
                        Icons.location_on,
                        color: Colors.white,
                      ),
                      label: const Text('Get my address',
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.cyan,
                          elevation: 5,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          )
                      ),
                    )
                    ,),
                 const SizedBox(height: 15,),
                  Form(key: formKey,
                    child: Column(
                      children: [
                        TextFieldWidget(
                          hint: "Name",
                          controller: _name,
                        ),
                        const SizedBox(height: 5,),
                        TextFieldWidget(
                        hint: "Phone Number",
                        controller: _phoneNumber,
                      ),
                      const SizedBox(height: 5,),
                      TextFieldWidget(
                        hint: "Street Address",
                        controller: _chowk,
                      ),
                        const SizedBox(height: 5,),

                        TextFieldWidget(
                        hint: "City",
                        controller: _city,
                      ),
                        const SizedBox(height: 5,),   TextFieldWidget(
                        hint: "Province",
                        controller: _state,
                      ),
                        const SizedBox(height: 5,),

                        TextFieldWidget(
                          hint: "Country",
                        controller: _country,
                      ),
                        const SizedBox(height: 5,),

                        TextFieldWidget(
                        hint: "Comlete Address",
                        controller: _completeAddress,
                      ),


                      ],
                    ),

                  ),


                ],
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: LocationBottomNavBar(),
    );
  }
}


