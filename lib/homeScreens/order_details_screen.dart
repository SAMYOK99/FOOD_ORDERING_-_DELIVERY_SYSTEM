import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
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
              // Return a loading indicator while data is loading
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              // Handle error case
              return Center(
                child: Text('Error: ${snapshot.error}'),
              );
            } else if (!snapshot.hasData || snapshot.data == null) {
              // Handle the case where data is not available
              return const Center(child: Text('Data not available.'));
            } else {
              // Data is available, build the UI
              final dataMap = snapshot.data!.data() as Map<String, dynamic>;
              orderStatus = dataMap["status"].toString();
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
                        "\$ " + dataMap["totalAmount"].toString(),
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
                      "Order Id" + widget.orderID!,
                      style: const TextStyle(
                        fontSize: 16,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      "Order At " +
                          DateFormat("dd MMMM, yyyy - hh:mm aa").format(
                            DateTime.fromMicrosecondsSinceEpoch(
                              int.parse(dataMap["orderTime"]),
                            ),
                          ),
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
                      ? Image.asset("images/package-delivered.png")
                      : Image.asset("images/state.png",width: MediaQuery.of(context).size.width-20,
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
                      if (snapshot.connectionState ==
                          ConnectionState.waiting) {
                        return Center(child: circularProgress());
                      } else if (snapshot.hasError) {
                        return Center(
                          child: Text('Error: ${snapshot.error}'),
                        );
                      } else if (!snapshot.hasData || snapshot.data == null) {
                        return const Center(child: Text('Address data not available.'));
                      } else {
                        return ShipmentAddressDesign(
                          model: Address.fromJson(
                              snapshot.data!.data() as Map<String, dynamic>),
                        );
                      }
                    },
                  ),
                ],
              );
            }
          },
        ),
      ),
    );
  }
}
