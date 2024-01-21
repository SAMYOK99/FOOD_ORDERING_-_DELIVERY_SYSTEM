import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:my_tiffin/homeScreens/home_screen.dart';
import 'package:my_tiffin/models/address.dart';
import 'package:my_tiffin/widgets/progress_bar.dart';
import 'package:my_tiffin/widgets/shipment_address_design.dart';
import 'package:my_tiffin/widgets/status_banner.dart';
import '../globalVariables/globleVariable.dart';

class OrderDetailsScreen extends StatefulWidget {
  final String? orderID;
  const OrderDetailsScreen({super.key, required this.orderID});

  @override
  State<OrderDetailsScreen> createState() => _OrderDetailsScreenState();
}

class _OrderDetailsScreenState extends State<OrderDetailsScreen> {
  String orderStatus = "";

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  void fetchData() async {
    final snapshot = await FirebaseFirestore.instance
        .collection('users')
        .doc(sharedPreferences!.getString("uid"))
        .collection('orders')
        .doc(widget.orderID)
        .get();

    if (snapshot.exists) {
      final dataMap = snapshot.data() as Map<String, dynamic>;
      setState(() {
        orderStatus = dataMap["status"].toString();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: FutureBuilder<DocumentSnapshot>(
          future: FirebaseFirestore.instance
              .collection('users')
              .doc(sharedPreferences!.getString("uid"))
              .collection('orders')
              .doc(widget.orderID)
              .get(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(
                child: Text('Error: ${snapshot.error}'),
              );
            } else if (!snapshot.hasData || snapshot.data == null) {
              return const Center(child: Text('Data not available.'));
            } else {
              final dataMap = snapshot.data!.data() as Map<String, dynamic>;
              return Column(
                children: [
                  StatusBanner(
                    status: dataMap["isSuccess"],
                    orderStatus: orderStatus,
                  ),
                  const SizedBox(
                    height: 15.0,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "Rs. ${dataMap["totalAmount"]}",
                        style: const TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      "Order Id: ${widget.orderID!}",
                      style: const TextStyle(
                        fontSize: 16,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      "Payment Status: ${dataMap["paymentDetails"]}",
                      style: const TextStyle(
                        fontSize: 16,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      "Order At ${DateFormat("dd MMMM, yyyy - hh:mm aa").format(
                        DateTime.fromMicrosecondsSinceEpoch(
                          int.parse(dataMap["orderTime"]),
                        ),
                      )}",
                      style: const TextStyle(
                        fontSize: 16,
                        color: Colors.grey,
                      ),
                    ),
                  ),
                  const Divider(
                    thickness: 4,
                  ),
                  orderStatus == "ended"
                      ? Image.asset(
                    "images/package-delivered.png",
                    width: MediaQuery.of(context).size.width - 100,
                    height: 200,
                  )
                      : Image.asset(
                    "images/state.png",
                    width: MediaQuery.of(context).size.width - 20,
                  ),
                  const Divider(
                    thickness: 4,
                  ),
                  FutureBuilder<DocumentSnapshot>(
                    future: FirebaseFirestore.instance
                        .collection("users")
                        .doc(sharedPreferences!.getString("uid"))
                        .collection("userAddress")
                        .doc(dataMap["addressID"])
                        .get(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Center(child: circularProgress());
                      } else if (snapshot.hasError) {
                        return Center(
                          child: Text('Error: ${snapshot.error}'),
                        );
                      } else if (!snapshot.hasData || snapshot.data == null) {
                        return const Center(
                            child: Text('Address data not available.'));
                      } else {
                        return ShipmentAddressDesign(
                          model: Address.fromJson(
                              snapshot.data!.data() as Map<String, dynamic>),
                        );
                      }
                    },
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Center(
                      child: () {
                        print(orderStatus);
                        if (dataMap["paymentDetails"] == "Cash on Delivery") {
                          if (orderStatus == "normal") {
                            return SizedBox(
                              height: 50,
                              width: MediaQuery.of(context).size.width - 40,
                              child: ElevatedButton(
                                onPressed: () {
                                  cancelOrder(widget.orderID);
                                },
                                style: ButtonStyle(
                                  backgroundColor:
                                  const MaterialStatePropertyAll(Colors.green),
                                  padding:
                                  const MaterialStatePropertyAll(EdgeInsets.symmetric(
                                      vertical: 15, horizontal: 20)),
                                  shape: MaterialStatePropertyAll(
                                    RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                  ),
                                ),
                                child: const Text(
                                  'Cancel this Order',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold, fontSize: 16),
                                ),
                              ),
                            );
                          } else {
                            return const Center(
                              child: Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Text(
                                  "You can't cancel the order, Your order has been picked up by the rider or you already made a payment",
                                  style: TextStyle(
                                    color: Colors.red,
                                  ),
                                ),
                              ),
                            );
                          }
                        } else {
                          return const Center(
                            child: Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Text(
                                "You can't cancel the order, Your payment method is not 'Cash on Delivery'",
                                style: TextStyle(
                                  color: Colors.red,
                                ),
                              ),
                            ),
                          );
                        }
                      }(),
                    ),
                  )
                ],
              );
            }
          },
        ),
      ),
    );
  }

  void cancelOrder(orderUid) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Cancel Order"),
          content: const Text("Are you sure you want to cancel this order?"),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text(
                'No',
                style: TextStyle(color: Colors.green),
              ),
            ),
            TextButton(
              onPressed: () {
                FirebaseFirestore.instance
                    .collection('users')
                    .doc(sharedPreferences!.getString("uid"))
                    .collection('orders')
                    .doc(orderUid)
                    .update({"status": "canceled"})
                    .then((value) {
                  FirebaseFirestore.instance
                      .collection("orders")
                      .doc(orderUid)
                      .update({"status": "canceled"})
                      .then((_) {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (c) => const HomeScreen()),
                    );
                    Fluttertoast.showToast(msg: "Order Canceled");
                  }).catchError((error) {
                    print("Error updating order status: $error");
                  });
                }).catchError((error) {
                  print("Error updating order status: $error");
                });
              },
              child: const Text(
                'Yes',
                style: TextStyle(
                  color: Colors.green,
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
