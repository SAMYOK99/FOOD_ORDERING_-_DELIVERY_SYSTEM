import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:my_tiffin/globalVariables/globleVariable.dart';
import 'package:my_tiffin/models/address.dart';
import 'package:my_tiffin/riders_app/homeScreens/package_picking_screen.dart';
import 'package:my_tiffin/riders_app/riderAssistantMethod/get_current_location.dart';
import 'package:my_tiffin/splashScreen/splash_screen.dart';
class ShipmentAddressDesign extends StatelessWidget {
  final Address? model;
  final String? orderStatus;
  final String? orderID;
  final String? orderBy;

  const ShipmentAddressDesign({super.key, required this.model, required this.orderStatus, required this.orderID, required this.orderBy});

  confirmParcelShipment(BuildContext context, String getOrderId, String purchaserId)
  {
    FirebaseFirestore.instance.collection("orders").doc(getOrderId).update({
"riderUID": sharedPreferences!.getString("uid"),
"riderName": sharedPreferences!.getString("name"),
"status": "picking",
"lat": position?.latitude,
"lng": position?.longitude,
"address": completeAddress,
    }).then((value) {
      FirebaseFirestore.instance.collection("users").doc(orderBy).collection(
          "orders").doc(getOrderId).update({
        "riderUID": sharedPreferences!.getString("uid"),
        "riderName": sharedPreferences!.getString("name"),
        "status": "picking",
        "lat": position?.latitude,
        "lng": position?.longitude,
        "address": completeAddress,
      });
      // send rider to shipment address
      Navigator.push(context, MaterialPageRoute(
          builder: (c) =>
              PackagePickingScreen(
                  purchaserId: purchaserId,
                  purchaserAddress: model!.fullAddress,
                  purchaserLat: model!.lat,
                  purchaserLng: model!.lng,
                  getOrderId: getOrderId
              )));
    });}

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
       const Padding(
          padding:  EdgeInsets.all(10.0),
          child:  Text("Shipping Details:",style: TextStyle(
            color: Colors.black,fontWeight: FontWeight.bold,
          ),),
        ),
        const SizedBox(height: 10.0,),
         Container(
           padding: const EdgeInsets.symmetric(horizontal: 90, vertical: 5),
             width: MediaQuery.of(context).size.width,
           child: Table(
             children: [
               TableRow(
                 children: [
                  const Text("Name",style: TextStyle(color: Colors.black),) ,
                   Text(model!.name!),
                 ]
               ),
               TableRow(
                 children: [
                  const Text("Phone Number",style: TextStyle(color: Colors.black),) ,
                   Text(model!.phoneNumber!),
                 ]
               ),
             ],
           ),
         ),
        const SizedBox(height: 20,),
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: Text(model!.fullAddress!,textAlign: TextAlign.justify ,),
        ),
        const SizedBox(height: 45,),
orderStatus =="ended"
    ?Container()
    : Padding(
      padding: const EdgeInsets.all(8.0),
      child: Center(
  child: Container(
      height: 50,
      width: MediaQuery.of(context).size.width - 40,
      child: ElevatedButton(
        onPressed: (){
          UserLocation uLocation= UserLocation();
          uLocation!.getCurrentLocation();
      confirmParcelShipment(context, orderID!, orderBy!);
        },
        style: ButtonStyle(
          backgroundColor: const MaterialStatePropertyAll(Colors.green),
          padding: const MaterialStatePropertyAll(EdgeInsets.symmetric(vertical: 15,horizontal: 20,),),
          shape: MaterialStatePropertyAll(RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),)),
        ),
        child: const Text('Confirm to Deliver this Package', style: TextStyle(fontWeight: FontWeight.bold,fontSize:16,),),
      ),
  ),
),
    ),
       // Padding(
       //    padding: const EdgeInsets.all(8.0),
       //    child: Center(
       //      child: Container(
       //        height: 50,
       //        width: MediaQuery.of(context).size.width - 40,
       //        child: ElevatedButton(
       //          onPressed: (){
       //            Navigator.push(context, MaterialPageRoute(
       //                builder: (c)=>const MySplashScreen()));
       //          },
       //          style: ButtonStyle(
       //            backgroundColor: const MaterialStatePropertyAll(Colors.green),
       //            padding: const MaterialStatePropertyAll(EdgeInsets.symmetric(vertical: 15,horizontal: 20,),),
       //            shape: MaterialStatePropertyAll(RoundedRectangleBorder(
       //              borderRadius: BorderRadius.circular(20),)),
       //          ),
       //          child: const Text('Go Back', style: TextStyle(fontWeight: FontWeight.bold,fontSize:16,),),
       //        ),
       //      ),
       //    ),
       //  ),

      ],

    );
  }
}
