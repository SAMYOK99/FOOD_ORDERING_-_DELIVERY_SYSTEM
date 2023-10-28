import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:my_tiffin/asistantMethods/cartItemMethods.dart';
import 'package:my_tiffin/homeScreens/home_screen.dart';

import '../globalVariables/globleVariable.dart';

class PlaceOrderScreen extends StatefulWidget {
  String? addressID;
  double? totalAmount;

  PlaceOrderScreen({super.key,
  required this.addressID,
  required this.totalAmount});

  @override
  State<PlaceOrderScreen> createState() => _PlaceOrderScreenState();
}

class _PlaceOrderScreenState extends State<PlaceOrderScreen> {
  String orderId = DateTime.now().microsecondsSinceEpoch.toString();
  saveOrderDetails()

  {
    writeOrderDetailsInOrder({
      "addressID": widget.addressID,
      "totalAmount": widget.totalAmount,
      "orderBy": sharedPreferences!.getString("uid"),
      "productId": sharedPreferences!.getStringList("userCart"),
      "paymentDetails": "Cash on Delivery",
      "orderTime": orderId,
      "isSuccess": true,
      "riderUID": "",
      "status": "normal",
      "orderId": orderId
    });
    saveOrderDetailsInFireStore({
      "addressID": widget.addressID,
      "totalAmount": widget.totalAmount,
      "orderBy": sharedPreferences!.getString("uid"),
      "productId": sharedPreferences!.getStringList("userCart"),
      "paymentDetails": "Cash on Delivery",
      "orderTime": orderId,
      "isSuccess": true,
      "riderUID": "",
      "status": "normal",
      "orderId": orderId
    }).whenComplete((){
      clearCart(context);
     setState(() {
       orderId="";
       Navigator.push(context, MaterialPageRoute(builder: (c)=>const HomeScreen()));
       Fluttertoast.showToast(msg: "Order has been placed successfully");
     });
    });
  }
  Future saveOrderDetailsInFireStore(Map<String, dynamic> data) async
  {
    await FirebaseFirestore.instance
        .collection("users")
        .doc(sharedPreferences!.getString("uid"))
        .collection("orders")
        .doc(orderId)
        .set(data);
  }

  Future writeOrderDetailsInOrder(Map<String, dynamic> data) async
  {
    await FirebaseFirestore.instance
        .collection("orders")
        .doc(orderId)
        .set(data);
  }
    @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(
          color: Colors.green,
          size: 33,

        ),
        backgroundColor: Colors.white,
        elevation: 0.0,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Center(
              child: Container(
                height: 50,
                width: MediaQuery.of(context).size.width - 40,
                child: ElevatedButton(
                  onPressed: (){
                    saveOrderDetails();

                  },
                  style: ButtonStyle(
                    backgroundColor: const MaterialStatePropertyAll(Colors.green),
                    padding: const MaterialStatePropertyAll(EdgeInsets.symmetric(vertical: 15,horizontal: 20,),),
                    shape: MaterialStatePropertyAll(RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),)),
                  ),
                  child: const Text('Place Order', style: TextStyle(fontWeight: FontWeight.bold,fontSize:16,),),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
