import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_tiffin/authentication/auth_screen.dart';
import 'package:my_tiffin/globalVariables/globleVariable.dart';
import 'package:my_tiffin/homeScreens/staff_main_screens/canceled_order_screen.dart';
import 'package:my_tiffin/homeScreens/staff_main_screens/earning_screen.dart';
import 'package:my_tiffin/homeScreens/staff_main_screens/history_screen.dart';
import 'package:my_tiffin/homeScreens/staff_main_screens/staff_new_order_screen.dart';

class StaffDrawer extends StatefulWidget {
  const StaffDrawer({super.key});

  @override
  State<StaffDrawer> createState() => _StaffDrawerState();
}

class _StaffDrawerState extends State<StaffDrawer> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          //drawer header
          Container(
              decoration: const BoxDecoration(
                gradient:LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Color(0x665ac18e),
                      Color(0x995ac18e),
                      Color(0xcc5ac18e),
                      Color(0xff5ac18e),
                      // Color.fromRGBO(116, 187, 244, 100),
                      // Colors.lightGreen,


                    ]
                ),
              ),
              padding: const EdgeInsets.only(top: 25,bottom:10),
              child: Column(
                children: [
                  Material(
                    borderRadius: const BorderRadius.all(Radius.circular(80)),
                    elevation: 10,
                    child: Padding(
                      padding: const  EdgeInsets.all(1.0),
                      child: Container(
                        height: 150,
                        width: 150,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(80),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.5),
                              spreadRadius: 2,
                              blurRadius: 10,
                              offset: const Offset(0,3),

                            )
                          ],
                        ),
                        child: CircleAvatar(
                          backgroundImage:NetworkImage(
                              sharedPreferences!.getString('photoUrl')!
                          ) ,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 10,),
                  Text(
                    sharedPreferences!.getString('name')!,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontFamily:'Train',
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    sharedPreferences!.getString('email')!,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                    ),
                  ),
                ],

              )
          ),

          //body of container
          Container(
            padding: const EdgeInsets.only(top: 1),
            child: Column(
              children: [
                ListTile(
                  leading: const Icon(
                    CupertinoIcons.home,
                    // Icons.home,
                    color: Colors.green,),
                  title: const Text(
                    'Home',
                    style: TextStyle(color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                  onTap: (){

                  },

                ),
                ListTile(
                  leading: const Icon(Icons.reorder,color: Colors.green,),
                  title: const Text(
                    'Available Orders',
                    style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold,fontSize: 18,),
                  ),
                  onTap: (){
                    Navigator.push(context,MaterialPageRoute(builder: (c)=>StaffNewOrdersScreen()));

                  },

                ),
                ListTile(
                  leading: const Icon(Icons.reorder,color: Colors.green,),
                  title: const Text(
                    'Canceled Orders',
                    style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold,fontSize: 18,),
                  ),
                  onTap: (){
                    Navigator.push(context,MaterialPageRoute(builder: (c)=>StaffCancelledOrdersScreen()));

                  },

                ),
                ListTile(
                  leading:  const Icon(Icons.shopping_cart,color: Colors.green,),
                  title: const Text(
                    'History',
                    style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold,fontSize: 18,),
                  ),
                  onTap: (){
                    Navigator.push(context,MaterialPageRoute(builder: (c)=>StaffHistoryScreen()));


                  },
                ),
                ListTile(
                  leading:  const Icon(Icons.monetization_on,color: Colors.green,),
                  title: const Text(
                    'Total Earnings',
                    style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold,fontSize: 18,),
                  ),
                  onTap: (){
                    Navigator.push(context,MaterialPageRoute(builder: (c)=>TotalEarningScreen()));


                  },
                ),

                ListTile(
                  leading: const Icon(Icons.exit_to_app,color: Colors.green,),
                  title: const Text(
                    'Logout',
                    style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold,fontSize: 18,),
                  ),
                  onTap: (){
                    firebaseAuth.signOut().then((value) => {
                      Navigator.push(context, MaterialPageRoute(builder: (c)=>const AuthScreen()))
                    });
                  },

                ),

              ],
            ),
          )
        ],
      ),
    );
  }
}
