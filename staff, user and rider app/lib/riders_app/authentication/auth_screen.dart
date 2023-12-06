import 'package:my_tiffin/authentication/auth_screen.dart';
import 'package:my_tiffin/riders_app/authentication/login.dart';
import 'package:my_tiffin/riders_app/authentication/register.dart';

import 'package:flutter/material.dart';
import 'package:my_tiffin/splashScreen/splash_screen.dart';
class RiderAuthScreen extends StatefulWidget {
  const RiderAuthScreen({super.key});

  @override
  State<RiderAuthScreen> createState() => _RiderAuthScreenState();
}

class _RiderAuthScreenState extends State<RiderAuthScreen> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          flexibleSpace: Container(
            decoration: const BoxDecoration(
              gradient:LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment(0.8,1),
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

          ),
        automaticallyImplyLeading: false,

        title: const Padding(
          padding:  EdgeInsets.fromLTRB(0.0, 20.0, 0.0,30.0),
          child:  Text('Rider',
            style: TextStyle(
              fontSize: 50,
              fontFamily: 'Lobster',
              color:Colors.white,
            )
          ),
        ),
         centerTitle: true,
          bottom: const TabBar(
              tabs: [
                Tab(
                  icon: Icon(Icons.lock,color: Colors.white,),
                  text:'Login',
                ),
                Tab(
                  icon: Icon(Icons.person,color: Colors.white,),
                  text:'Sign Up',
                )
              ],
            indicatorColor: Colors.white38,
            indicatorWeight:6,
              ),
        ),
      body: Container(
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
        child: const TabBarView(
          children: [
            LoginScreen(),
            RegisterScreen(),
          ],
        ),
      ),
      ),
    );
  }
}
