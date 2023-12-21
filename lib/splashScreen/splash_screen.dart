import 'dart:async';
import 'package:my_tiffin/authentication/auth_screen.dart';
import 'package:flutter/material.dart';
import 'package:my_tiffin/globalVariables/globleVariable.dart';
import 'package:my_tiffin/homeScreens/home_screen.dart';
import 'package:my_tiffin/homeScreens/staff_main_screens/staff_home_screen.dart';
import 'package:my_tiffin/riders_app/homeScreens/home_screen.dart';

class MySplashScreen extends StatefulWidget {
  const MySplashScreen({super.key});


  @override
  State<MySplashScreen> createState() => _MySplashScreenState();
}
String? role= sharedPreferences?.getString('role');

class _MySplashScreenState extends State<MySplashScreen> {
  startTimer(){

    Timer(const Duration(seconds: 1),() async{
      // if staff is logged in already
      if(firebaseAuth.currentUser!=null) {
        if (role == 'user') {
          Navigator.push(
              context, MaterialPageRoute(builder: (c) => const HomeScreen()));
        } else if (role == 'rider') {
          Navigator.push(context,
              MaterialPageRoute(builder: (c) => const RiderHomeScreen()));
        }
        else if (role == 'staff') {
          Navigator.push(context,
              MaterialPageRoute(builder: (c) => const StaffHomeScreen()));
        }
      }
        else { // if staff is not logged in yet
        Navigator.push(context, MaterialPageRoute(builder: (c) => const AuthScreen()));
      }
    });
  }
  @override
  void initState() {
    super.initState();
    startTimer();
  }
  @override
  Widget build(BuildContext context) {
    return Material(
      child: Container(
        color: Colors.white,
        child: Center(
          child: Column(
            mainAxisAlignment:MainAxisAlignment.center,
            children: [
              Image.asset("images/splash.jpg"),
              const SizedBox(height: 10,),
              const Padding(
                  padding: EdgeInsets.all( 18.0),
                  child:Text('Admin Panel',
                      textAlign: TextAlign.center,
                           style: TextStyle(
                             color: Colors.black54,
                             fontFamily: 'Signatra',
                             fontSize: 40,
                             letterSpacing: 3,
                  ),
                  ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
