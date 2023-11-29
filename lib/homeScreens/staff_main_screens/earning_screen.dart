import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:my_tiffin/globalVariables/globleVariable.dart';
import 'package:my_tiffin/homeScreens/staff_main_screens/staff_home_screen.dart';


class TotalEarningScreen extends StatefulWidget {
  const TotalEarningScreen({super.key});

  @override
  State<TotalEarningScreen> createState() => _TotalEarningScreenState();
}


class _TotalEarningScreenState extends State<TotalEarningScreen> {
  double totalEarning = 0.0;

  retrieveTotalEarning() async
  {
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance.collection("orders").get();
    double tempTotalEarning = 0.0;
    querySnapshot.docs.forEach((doc) {
      if(doc.exists){
        var data = doc.data() as Map<String, dynamic>?;
        if (data != null && data['totalAmount'] != null) {
          double orderAmount = data['totalAmount'];
          tempTotalEarning += orderAmount;
        }      }
    });
setState(() {
  totalEarning = tempTotalEarning;
});
  }
  @override
  void initState() {
retrieveTotalEarning();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Colors.white,
        leading: GestureDetector(
          onTap: () {
            Navigator.push(context, MaterialPageRoute(builder: (c) => const StaffHomeScreen()));
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
                  "Total Earnings: ",style: TextStyle(
                  color: Colors.green,
                  letterSpacing: 2,
                  fontSize: 30,

                ),
                ),
                Text(
                  "\$ $totalEarning",
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
