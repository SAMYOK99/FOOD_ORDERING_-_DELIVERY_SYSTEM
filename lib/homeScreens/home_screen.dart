 import 'package:flutter/material.dart';
import 'package:my_tiffin/authentication/auth_screen.dart';
import 'package:my_tiffin/globalVariables/globleVariable.dart';
import 'package:my_tiffin/widgets/user_drawer.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

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
          title:  Text(
          sharedPreferences!.getString('name')!,
          ),
        centerTitle: true,

      ),
          drawer: UserDrawer(),

          body: Center(
          ),
    ),);

  }
}
