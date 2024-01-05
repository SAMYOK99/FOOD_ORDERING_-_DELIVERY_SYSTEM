import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:khalti_flutter/khalti_flutter.dart';
import 'package:my_tiffin/asistantMethods/cartItemMethods.dart';
import 'package:my_tiffin/homeScreens/home_screen.dart';
import '../globalVariables/globleVariable.dart';
import 'package:esewa_flutter_sdk/esewa_flutter_sdk.dart';
import 'package:esewa_flutter_sdk/esewa_config.dart';
import 'package:esewa_flutter_sdk/esewa_payment.dart';
import 'package:esewa_flutter_sdk/esewa_payment_success_result.dart';

class PlaceOrderScreen extends StatefulWidget {
  String? addressID;
  double? totalAmount;


  PlaceOrderScreen({super.key,
  required this.addressID,
  required this.totalAmount,
  });

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
  saveKhaltiOrderDetails(){
    {
      writeOrderDetailsInOrder({
        "addressID": widget.addressID,
        "totalAmount": widget.totalAmount,
        "orderBy": sharedPreferences!.getString("uid"),
        "productId": sharedPreferences!.getStringList("userCart"),
        "paymentDetails": "Paid via Khalti",
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
        "paymentDetails": "Paid via Khalti",
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
          Fluttertoast.showToast(msg: "Payment is successfull, Order has been placed successfully");
        });
      });
    }

  }
  saveEsewaOrderDetails(){
    {
      writeOrderDetailsInOrder({
        "addressID": widget.addressID,
        "totalAmount": widget.totalAmount,
        "orderBy": sharedPreferences!.getString("uid"),
        "productId": sharedPreferences!.getStringList("userCart"),
        "paymentDetails": "Paid via Esewa",
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
        "paymentDetails": "Paid via Esewa",
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
          Fluttertoast.showToast(msg: "Payment is successfull, Order has been placed successfully");
        });
      });
    }

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
        centerTitle: true,
        title: const Text(
          'Payment Gateway',
          style: TextStyle(
            color: Colors.black,
            fontSize: 22,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Recommended method(s)',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),),
                const Divider(
                  thickness: 2,
                ),
                InkWell(
                  onTap: payViaKhalti,
                  child:Row(
                    children: [
                      Image.asset("images/khalti.png",
                        height: 30,
                      ),
                      const SizedBox(width: 15,),
                      const Text('Pay via Khalti',
                        style: TextStyle(
                          fontSize: 20,
                        ),)
                    ],
                  ),
                ),

                const Divider(
                  thickness: 2,
                ),
                InkWell(
                  onTap: payViaEsewa,
                  child:Row(
                    children: [
                      Image.asset("images/esewa.jpg",
                        height: 40,
                      ),
                      const SizedBox(width: 15,),
                      const Text('Pay via Esewa',
                        style: TextStyle(
                          fontSize: 20,
                        ),)
                    ],
                  ),
                ),

                const Divider(
                  thickness: 2,
                ),
                const SizedBox(height: 10,),
                const Text('Other method(s)',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),),
              const Divider(
                  thickness: 2,
                ),

                InkWell(
                  onTap: saveOrderDetails,
                  child: const Center(
                    child: Row(
                      children: [
                        Icon(Icons.money_sharp),
                         SizedBox(width: 15,),
                        SizedBox(
                          child: Text("Cash on Delivery",
                            style: TextStyle(
                              fontSize: 20,
                            ),),

                        ),
                      ],
                    ),
                  ),
                ),

                const Divider(
                  thickness: 2,
                ),
              ],
            ),
          ),
          // Padding(
          //   padding: const EdgeInsets.all(8.0),
          //   child: Center(
          //     child: Container(
          //       height: 50,
          //       width: MediaQuery.of(context).size.width - 40,
          //       child: ElevatedButton(
          //         onPressed: (){
          //           saveOrderDetails();
          //
          //         },
          //         style: ButtonStyle(
          //           backgroundColor: const MaterialStatePropertyAll(Colors.green),
          //           padding: const MaterialStatePropertyAll(EdgeInsets.symmetric(vertical: 15,horizontal: 20,),),
          //           shape: MaterialStatePropertyAll(RoundedRectangleBorder(
          //             borderRadius: BorderRadius.circular(20),)),
          //         ),
          //         child: const Text('Place Order', style: TextStyle(fontWeight: FontWeight.bold,fontSize:16,),),
          //       ),
          //     ),
          //   ),
          // )
        ],
      ),
    );
  }
  payViaKhalti(){
    KhaltiScope.of(context).pay(
        config: PaymentConfig(
          amount: (widget.totalAmount! * 100).toInt(),
          productIdentity: sharedPreferences!.getStringList("userCart")!.join(","),
          productName: "name"
        ),
        onSuccess: onSuccess,
        onFailure: onFailure,
      onCancel: onCancel,
      preferences: [
        PaymentPreference.khalti,
      ]
    );
  }
  void onSuccess(PaymentSuccessModel success){
    saveKhaltiOrderDetails();
  }
  void onFailure(PaymentFailureModel failure){
    debugPrint("payment failed");
  }
  void onCancel(){
    debugPrint("Canceled");
  }
  payViaEsewa(){
    try{
      EsewaFlutterSdk.initPayment(
        esewaConfig: EsewaConfig(
          environment: Environment.test,
          clientId: "JB0BBQ4aD0UqIThFJwAKBgAXEUkEGQUBBAwdOgABHD4DChwUAB0R",
          secretId: "BhwIWQQADhIYSxILExMcAgFXFhcOBwAKBgAXEQ==",
        ),
        esewaPayment: EsewaPayment(
          productId: sharedPreferences!.getStringList("userCart")!.join(","),
          productName: "name",
          productPrice: "(widget.totalAmount!).toInt()", callbackUrl: '',

        ),
        onPaymentSuccess: (EsewaPaymentSuccessResult data) {
          debugPrint(":::SUCCESS::: => $data");
          saveEsewaOrderDetails();


        },
        onPaymentFailure: (data) {
          debugPrint(":::FAILURE::: => $data");
        },
        onPaymentCancellation: (data) {
          debugPrint(":::CANCELLATION::: => $data");
        },
      );
    }catch(e){
      debugPrint('EXCEPTION');
    }
  }
}
