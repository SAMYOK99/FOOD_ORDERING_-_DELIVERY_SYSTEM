import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:my_tiffin/globalVariables/globleVariable.dart';
import 'package:my_tiffin/maps/map_utils.dart';
import 'package:my_tiffin/riders_app/homeScreens/home_screen.dart';
import 'package:my_tiffin/riders_app/riderAssistantMethod/get_current_location.dart';
import 'package:my_tiffin/riders_app/splashScreen/splash_screen.dart';

class PackageDeliveringScreen extends StatefulWidget {
  String? purchaserId;
  String? purchaserAddress;
  double? purchaserLat;
  double? purchaserLng;
  String? getOrderId;


  PackageDeliveringScreen(
      { this.purchaserId,
        this.purchaserAddress,
        this.purchaserLat,
        this.purchaserLng,
        this.getOrderId
      });


  @override
  State<PackageDeliveringScreen> createState() => _PackageDeliveringScreenState();
}

class _PackageDeliveringScreenState extends State<PackageDeliveringScreen> {
  deliveringPackage(getOrderId, purchaserId, purchaserAddress, purchaserLat, purchaserLng)
  {
    String riderNewTotalEarningAmount=((double.parse(previousRiderEarnings))+(double.parse(perPackageDeliveryAmount))).toString();
    FirebaseFirestore.instance
        .collection("orders")
        .doc(getOrderId)
        .update({
      "status": "ended",
      "address": widget.purchaserAddress,
      "lat":position!.latitude,
      "lng":position!.longitude,
      "earnings":perPackageDeliveryAmount, // payment per delivery
    }).then((value)  
    {
      FirebaseFirestore.instance
          .collection("riders")
          .doc(sharedPreferences!.getString("uid")).update({"earnings": riderNewTotalEarningAmount,});// total earnings of riders)
     });
      // .then((value){
    //   FirebaseFirestore.instance
    //       .collection("users")
    //       .doc(sharedPreferences!.getString("uid")).update({"earnings": ""});// total earnings of sellers)
    // });
    //     .then((value){
    //   FirebaseFirestore.instance
    //       .collection("users")
    //       .doc(purchaserId)
    //       .collection("orders").doc(getOrderId).update({"status":"ended",
    //   "riderUID": sharedPreferences!.getString("uid")});
    // });
    Navigator.push(context, MaterialPageRoute(builder: (c)=>RiderHomeScreen()));

  }
  getOrderTotalAmount()
  {
    FirebaseFirestore.instance
        .collection("orders")
        .doc(widget.getOrderId)
        .get()
        .then((snap) {
          snap.data()!["totalAmount"].toString();


    });
  }

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
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
            "images/giving.png",
            width: 340,


          ),
          const SizedBox(height: 70,),

          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [

              GestureDetector(
                onTap: (){

                MapU.launchMapFromSourceTodestinatioan(position!.latitude, position!.longitude, widget.purchaserLat, widget.purchaserLng);

                },
                child: const Row(
                  mainAxisAlignment:MainAxisAlignment.center,
                  children: [
                    Icon(Icons.location_on),
                    Text('Show Users Locations',style: TextStyle(
                      fontStyle:FontStyle.italic,
                    ),)

                  ],
                ),
              ),
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
                        deliveringPackage(
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
                      child: const Text('Order has been delivered, Confirm', style: TextStyle(fontWeight: FontWeight.bold,fontSize:16,),),
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
