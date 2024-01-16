import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:my_tiffin/models/address.dart';
import 'package:my_tiffin/widgets/progress_bar.dart';
import 'package:my_tiffin/riders_app/widgets/status_banner.dart';
import 'package:my_tiffin/widgets/staff_widget/staff_shipment_address.dart';

class StaffOrderDetailsScreen extends StatefulWidget {
  final String? orderID;
  const StaffOrderDetailsScreen({super.key, required this.orderID});

  @override
  State<StaffOrderDetailsScreen> createState() => _StaffOrderDetailsScreenState();
}

class _StaffOrderDetailsScreenState extends State<StaffOrderDetailsScreen> {
  String orderStatus = "";
  String orderBy = "";
  getOrderInfo(){
    FirebaseFirestore.instance.collection("orders").doc(widget.orderID).get().then((DocumentSnapshot){
      orderStatus = DocumentSnapshot.data()!["status"].toString();
      orderBy = DocumentSnapshot.data()!["orderBy"].toString();
    });
  }
  @override
  void initState() {
    super.initState();
    getOrderInfo();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: FutureBuilder<DocumentSnapshot>(
          future: FirebaseFirestore.instance
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
              return const Center(child: Text('Data not available.'));
            } else {
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
                      "Order Id: " + widget.orderID!,
                      style: const TextStyle(
                        fontSize: 16,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text("Payment Status: ${dataMap["paymentDetails"]}"
                      ,
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
                      ? Image.asset("images/delivered.png",
                    width: MediaQuery.of(context).size.width-100,
                    height: 200,)
                      : Image.asset("images/packing-icon.png",
                    width: MediaQuery.of(context).size.width-100,
                    height: 200,
                  ),

                  const Divider(
                    thickness: 4,
                  ),
                  FutureBuilder<DocumentSnapshot>(
                    future: FirebaseFirestore.instance
                        .collection("users")
                        .doc(orderBy)
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
                        return StaffShipmentAddressDesign(
                          orderBy: orderBy                                 ,
                          orderStatus: orderStatus,
                          orderID: widget.orderID,
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
