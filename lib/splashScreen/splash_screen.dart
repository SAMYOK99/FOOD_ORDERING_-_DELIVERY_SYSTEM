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

    Timer(const Duration(seconds: 3),() async{
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
      child: Padding(
        padding: EdgeInsets.all(18.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.asset("images/sp.jpg"),
            SizedBox(height: 8), // Vertical space after the image
            Image.asset("images/name.png"),

          ],
        ),
      ),











    );
  }
}
