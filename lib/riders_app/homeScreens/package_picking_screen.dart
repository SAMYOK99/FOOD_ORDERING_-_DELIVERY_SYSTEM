import 'dart:ffi';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:my_tiffin/globalVariables/globleVariable.dart';
import 'package:my_tiffin/riders_app/homeScreens/package_delivering.dart';
import 'package:my_tiffin/riders_app/riderAssistantMethod/get_current_location.dart';
class PackagePickingScreen extends StatefulWidget {
  String? purchaserId;
  String? getOrderId;
  String? purchaserAddress;
  double? purchaserLat;
  double? purchaserLng;

  PackagePickingScreen({
    required this.purchaserId,
    required this.getOrderId,
    required this.purchaserAddress,
    required this.purchaserLat,
    required this.purchaserLng,


});

  @override
  State<PackagePickingScreen> createState() => _PackagePickingScreenState();
}

class _PackagePickingScreenState extends State<PackagePickingScreen> {
  confirmPackage(getOrderId, purchaserId, purchaserAddress, purchaserLat, purchaserLng)
  {
    FirebaseFirestore.instance
        .collection("orders")
        .doc(getOrderId)
        .update({
          "status": "delivering",
          "address": widget.purchaserAddress,
          "lat":position!.latitude,
          "lng":position!.longitude
        });
    Navigator.push(context, MaterialPageRoute(builder: (c)=>PackageDeliveringScreen(
      purchaserId: purchaserId,
      purchaserAddress: purchaserAddress,
      purchaserLng: purchaserLng,
      purchaserLat: purchaserLat,
      getOrderId: getOrderId
    )));

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        iconTheme: const IconThemeData(
          size: 33,
          color: Colors.green,
        ),
        backgroundColor: Colors.white,
        elevation: 0.0,
      ),
      body: Column(
        children: [
          const SizedBox(height: 50,),

          Image.asset(
            "images/confirm.png",
            width: 340,


          ),
          const SizedBox(height: 70,),

        Row(
         mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Center(
                child: Container(
                  height: 50,
                  width: MediaQuery.of(context).size.width - 40,
                  child: ElevatedButton(
                    onPressed: (){

                      UserLocation uLocation = UserLocation();
                      uLocation.getCurrentLocation();
                      // Confirmed that rider has picked the package
                      confirmPackage(
                          widget.getOrderId,
                          widget.purchaserId,
                          widget.purchaserAddress,
                          widget.purchaserLat,
                          widget.purchaserLng);
                    },
                    style: ButtonStyle(
                      backgroundColor: const MaterialStatePropertyAll(Colors.green),
                      padding: const MaterialStatePropertyAll(EdgeInsets.symmetric(vertical: 15,horizontal: 20,),),
                      shape: MaterialStatePropertyAll(RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),)),
                    ),
                    child: const Text('Order has been picked, Confirmed', style: TextStyle(fontWeight: FontWeight.bold,fontSize:16,),),
                  ),
                ),
              ),
            ),


          ],

    ),
        ],
      ),

    );
  }
}
