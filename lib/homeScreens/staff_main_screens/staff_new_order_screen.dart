import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:my_tiffin/asistantMethods/cartItemMethods.dart';
import 'package:my_tiffin/widgets/staff_widget/staff_order_card.dart';
import '/widgets/progress_bar.dart';

class StaffNewOrdersScreen extends StatefulWidget {
  const StaffNewOrdersScreen({super.key});

  @override
  State<StaffNewOrdersScreen> createState() => _StaffNewOrdersScreenState();
}

class _StaffNewOrdersScreenState extends State<StaffNewOrdersScreen> {
  @override
  Widget build(BuildContext context) {
    // return Scaffold(
    //   appBar: AppBar(
    //     centerTitle: true,
    //     title: const Text(
    //       "New Orders",
    //       style: TextStyle(
    //         color: Colors.black,
    //         fontSize: 22,
    //         fontWeight: FontWeight.bold,
    //       ),
    //     ),
    //     iconTheme: const IconThemeData(
    //       size: 33,
    //       color: Colors.green,
    //     ),
    //     backgroundColor: Colors.white,
    //     elevation: 0.0,
    //   ),
    //   body: StreamBuilder<QuerySnapshot>(
    //     stream: FirebaseFirestore.instance
    //         .collection('orders')
    //         .where("status", isEqualTo: "normal")
    //         .orderBy("orderTime", descending: true)
    //         .snapshots(),
    //     builder: (context, snapshot) {
    //       if (snapshot.connectionState == ConnectionState.waiting) {
    //         return Center(child: circularProgress());
    //       } else if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
    //         return Center(
    //           child: Text(
    //             "No items found. Place item first.",
    //             style: TextStyle(
    //               color: Colors.red,
    //               fontSize: 18,
    //             ),
    //           ),
    //         );
    //       }
    //
    //       return ListView.builder(
    //         itemCount: snapshot.data!.docs.length,
    //         itemBuilder: (context, index) {
    //           return Padding(
    //             padding: const EdgeInsets.symmetric(vertical: 9.0),
    //             child: FutureBuilder<QuerySnapshot>(
    //               future: FirebaseFirestore.instance
    //                   .collection("items")
    //                   .where(
    //                 "itemID",
    //                 whereIn: separateOrderItemIds(
    //                   (snapshot.data!.docs[index].data()!
    //                   as Map<String, dynamic>)["productId"],
    //                 ),
    //               )
    //                   .where(
    //                 "orderBy",
    //                 whereIn: (snapshot.data!.docs[index].data()!
    //                 as Map<String, dynamic>)["uid"],
    //               )
    //                   .orderBy("publishedDate", descending: true)
    //                   .get(),
    //               builder: (context, snap) {
    //                 return snap.connectionState == ConnectionState.waiting
    //                     ? Center(
    //                   child: circularProgress(),
    //                 )
    //                     : snap.hasData
    //                     ? OrderCard(
    //                   itemCount: snap.data!.docs.length,
    //                   data: snap.data!.docs,
    //                   orderID: snapshot.data!.docs[index].id,
    //                   separateQuantitiesList:
    //                   separateOrderItemQuantiteis(
    //                     (snapshot.data!.docs[index].data()
    //                     as Map<String, dynamic>)[
    //                     "productId"],
    //                   ),
    //                 )
    //                     : Center(
    //                   child: circularProgress(),
    //                 );
    //               },
    //             ),
    //           );
    //         },
    //       );
    //     },
    //   ),
    // );
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          "My Orders",
          style: TextStyle(
            color: Colors.black,
            fontSize: 22,
            fontWeight: FontWeight.bold,
          ),
        ),
        iconTheme: const IconThemeData(
          size: 33,
          color: Colors.green,
        ),
        backgroundColor: Colors.white,
        elevation: 0.0,
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('orders')
            .where("status", isEqualTo: "normal")
            .orderBy("orderTime", descending: true)
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: circularProgress());
          } else if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return Center(
              child: Text(
                "No items found. Place item first.",
                style: TextStyle(
                  color: Colors.red,
                  fontSize: 18,
                ),
              ),
            );
          }
          else{
            return ListView.builder(
              itemCount: snapshot.data!.docs.length,
              itemBuilder: (c, index) {
                return FutureBuilder<QuerySnapshot>(
                  future: FirebaseFirestore.instance
                      .collection("items")
                      .where(
                    "itemID",
                    whereIn: separateOrderItemIds(
                      (snapshot.data!.docs[index].data()!
                      as Map<String, dynamic>)["productId"],
                    ),
                  )
                      .where(
                    "orderBy",
                    whereIn: (snapshot.data!.docs[index].data()!
                    as Map<String, dynamic>)["uid"],
                  )
                      .orderBy("publishedDate", descending: true)
                      .get(),
                  builder: (context, snap) {
                    return snap.connectionState == ConnectionState.waiting
                        ? Center(
                      child: circularProgress(),
                    )
                        : snap.hasData
                        ? StaffOrderCard(
                      itemCount: snap.data!.docs.length,
                      data: snap.data!.docs,
                      orderID: snapshot.data!.docs[index].id,
                      separateQuantitiesList:
                      separateOrderItemQuantiteis(
                        (snapshot.data!.docs[index].data()
                        as Map<String, dynamic>)[
                        "productId"],
                      ),
                    )
                        : Center(
                      child: circularProgress(),
                    );
                  },
                );
              },
            );
          }

        },
      ),
    );

  }
}
