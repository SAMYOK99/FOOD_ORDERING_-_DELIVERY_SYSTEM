 import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:my_tiffin/globalVariables/globleVariable.dart';
import 'package:my_tiffin/riders_app/authentication/auth_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RiderHomeScreen extends StatelessWidget {
  const RiderHomeScreen({super.key});

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


                }
              if(index == 1)
                {
                  //package in progress


                } if(index == 2)
                {
                  // Not yet delivered


                }
              if(index == 3)
                {
                  //History


                }

              if(index == 4)
              {
                //Total Earning


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
                    color: Colors.black,
                  ),
                ),
                const SizedBox(height: 10.0,),
                Center(
                  child: Text(
                    title,
                    style: const TextStyle(
                      fontSize: 18,
                      color: Colors.black
                    ),
                  ),
                )
              ],

            ),
          ) ,

        ),
      );

    };
    return Scaffold(
      appBar:AppBar(
    backgroundColor: Colors.white,
      title:  const Text('haha',
        style:  TextStyle(
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
        margin: EdgeInsets.all(10),
        padding: EdgeInsets.symmetric(vertical: 50, horizontal: 1),
        child: GridView.count(
          crossAxisCount: 2,
          padding: EdgeInsets.all(2),
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
