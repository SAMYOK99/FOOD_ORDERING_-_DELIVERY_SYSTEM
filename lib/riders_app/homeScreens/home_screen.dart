 import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter/material.dart';
import 'package:my_tiffin/globalVariables/globleVariable.dart';
import 'package:my_tiffin/riders_app/authentication/auth_screen.dart';
import 'package:my_tiffin/riders_app/homeScreens/delivering_progress_screen.dart';
import 'package:my_tiffin/riders_app/homeScreens/history_screen.dart';
import 'package:my_tiffin/riders_app/homeScreens/new_orders_screen.dart';
import 'package:my_tiffin/riders_app/homeScreens/package_in_progress.dart';
import 'package:my_tiffin/riders_app/homeScreens/total_amount.dart';
import 'package:my_tiffin/riders_app/riderAssistantMethod/get_current_location.dart';

class RiderHomeScreen extends StatefulWidget {
  const RiderHomeScreen({super.key});

  @override
  State<RiderHomeScreen> createState() => _RiderHomeScreenState();
}

class _RiderHomeScreenState extends State<RiderHomeScreen> {
  @override
  void initState() {
    super.initState();
    UserLocation uLocation= UserLocation();
    uLocation.getCurrentLocation();
    getPerPackageDeliveryAmount();
    getRiderPreviousEarnings();

  }
  getPerPackageDeliveryAmount()
  {
    FirebaseFirestore.instance
        .collection("perDelivery")
        .doc("abc123")
        .get().then((snap)
    {
      perPackageDeliveryAmount = snap.data()!["amount"].toString();
    });

  }

  getRiderPreviousEarnings()
  {
    FirebaseFirestore.instance
        .collection("riders")
        .doc(sharedPreferences!.getString("uid"))
        .get().then((snap)
    {
     previousRiderEarnings = snap.data()!["earnings"].toString();

    });

  }
  @override
  Widget build(BuildContext context) {
    Card dashboardItem(String title, IconData iconData, int index){
      return Card(
        margin: const EdgeInsets.all(8.0),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 3,
                blurRadius: 10,
                offset: const Offset(0,3),

              )
            ],
          ),
          child: InkWell(
            onTap: ()
            {
              if(index == 0)
                {
                  //new available order
                  Navigator.push(context, MaterialPageRoute(builder: (c)=> const NewOrdersScreen()));

                }
              if(index == 1)
                {
                  //package in progress

                  Navigator.push(context, MaterialPageRoute(builder: (c)=> const PackageInProgress()));


                } if(index == 2)
                {
                  // Not yet delivered
                  Navigator.push(context, MaterialPageRoute(builder: (c)=>  const DeliveringProgressScreen()));


                }
              if(index == 3)
                {
                  //History
                  Navigator.push(context, MaterialPageRoute(builder: (c)=> const HistoryScreen()));



                }

              if(index == 4)
              {
                //Total Earning
                Navigator.push(context, MaterialPageRoute(builder: (c)=> const TotalAmountScreen()));



              }

              if(index == 5)
              {
                //Logout
                firebaseAuth.signOut().then((value){
                  Navigator.push(context, MaterialPageRoute(builder: (c)=> const RiderAuthScreen()));
                });


              }
            },
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisSize: MainAxisSize.min,
              verticalDirection: VerticalDirection.down,
              children: [
                const SizedBox(height: 50.0,),
                Center(
                  child: Icon(
                    iconData,
                    size: 40,
                    color: Colors.green,
                  ),
                ),
                const SizedBox(height: 10.0,),
                Center(
                  child: Text(
                    title,
                    style: const TextStyle(
                      fontSize: 18,
                      color: Colors.black,
                    ),
                  ),
                )
              ],

            ),
          ) ,

        ),
      );
    }
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          sharedPreferences!.getString('name') ?? "Default Title",
          style: const TextStyle(
            fontSize: 22,
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
        elevation: 0.0,
        centerTitle: true,
        automaticallyImplyLeading: false,
      ),

      body:  Container(
        margin: const EdgeInsets.all(10),
        padding: const EdgeInsets.symmetric(vertical: 50, horizontal: 2),
        child: GridView.count(
          crossAxisCount: 2,
          padding: const EdgeInsets.all(2),
        children: [
          dashboardItem("Available Orders", Icons.assessment, 0),
          dashboardItem("Package in Progress", Icons.airport_shuttle, 1),
          dashboardItem("Not Yet Delivered", Icons.assessment, 2),
          dashboardItem("History", Icons.done_all, 3),
          dashboardItem("Total Earnings", Icons.monetization_on, 4),
          dashboardItem("Logout ", Icons.logout, 5),

        ],) ,
      ),
    );

  }
}
