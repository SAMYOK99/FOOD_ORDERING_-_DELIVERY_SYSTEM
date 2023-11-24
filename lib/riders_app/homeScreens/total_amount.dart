import 'package:flutter/material.dart';
import 'package:my_tiffin/globalVariables/globleVariable.dart';

import 'home_screen.dart';

class TotalAmountScreen extends StatefulWidget {
  const TotalAmountScreen({super.key});

  @override
  State<TotalAmountScreen> createState() => _TotalAmountScreenState();
}

class _TotalAmountScreenState extends State<TotalAmountScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Colors.white,
        leading: GestureDetector(
          onTap: () {
            Navigator.push(context, MaterialPageRoute(builder: (c) => const RiderHomeScreen()));
          },
          child: const Icon(
            Icons.arrow_back,
            size: 33,
            color: Colors.green,
          ),
        ),
      ),
      body:  Center(

        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Column(
              children: [
                const Text(
                  "You've earned: ",style: TextStyle(
                  color: Colors.green,
                  letterSpacing: 2,
                  fontSize: 30,

                ),
                ),
                Text(
                 "\$ $previousRiderEarnings",
              style: const TextStyle(
                  fontSize: 50,
                ),
                ),

              ],
            ),
          ],
        ),
      ),

    );
  }
}
