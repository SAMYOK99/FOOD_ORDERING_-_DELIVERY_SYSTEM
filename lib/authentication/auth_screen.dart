import 'package:my_tiffin/authentication/login.dart';
import 'package:my_tiffin/authentication/register.dart';

import 'package:flutter/material.dart';
class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
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
          child:  Text('Tiffin',
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
                    child: Text('Login',style: TextStyle(color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold),),
                ),
                Tab(
                  icon: Icon(Icons.person,color: Colors.white,),
                  child: Text('Sign Up',style: TextStyle(color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold),),
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
