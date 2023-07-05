 import 'package:flutter/material.dart';
import 'package:my_tiffin/authentication/auth_screen.dart';
import 'package:my_tiffin/globalVariables/globleVariable.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RiderHomeScreen extends StatelessWidget {
  const RiderHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 2,
        child:  Scaffold(
      appBar:AppBar(
          flexibleSpace: Container(
            decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Colors.cyan,
                    Colors.lightGreen,
                  ],

                )
            ),

          ),
          title:  Text('haha',
            style: TextStyle(
              color: Colors.black38,
            ),
          ),
        centerTitle: true,
        automaticallyImplyLeading: false,
      ),

          body: Center(
            child: ElevatedButton(
              child: const Text('Lol'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
              ),
              onPressed: (){
               firebaseAuth.signOut().then((value) {
                 Navigator.push(context, MaterialPageRoute(builder: (c)=>const AuthScreen()));
               });

              },
            ),
          ),
    ),);

  }
}
