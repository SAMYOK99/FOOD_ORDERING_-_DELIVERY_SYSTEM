import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:my_tiffin/asistantMethods/cartItemMethods.dart';
import 'package:my_tiffin/globalVariables/globleVariable.dart';
import 'package:my_tiffin/widgets/order_card.dart';
import '/widgets/progress_bar.dart';

class UserOrdersScreen extends StatefulWidget {
  const UserOrdersScreen({super.key});

  @override
  State<UserOrdersScreen> createState() => _UserOrdersScreenState();
}

class _UserOrdersScreenState extends State<UserOrdersScreen> {
  @override
  Widget build(BuildContext context) {
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
            .collection('users')
            .doc(sharedPreferences!.getString("uid"))
            .collection('orders')
            .where("status", isEqualTo: "normal")
            .orderBy("orderTime", descending: true)
            .snapshots(),
        builder: (c, snapshot) {
          return snapshot.hasData
              ? ListView.builder(
            itemCount: snapshot.data!.docs.length ,
            itemBuilder: (c, index) {
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 9.0),
                  child: FutureBuilder<QuerySnapshot>(
                    future: FirebaseFirestore.instance
                        .collection("items")
                        .where(
                        "itemID",
                        whereIn: separateOrderItemIds(
                            (snapshot.data!.docs[index].data()!
                            as Map<String, dynamic>)["productId"]))
                        .where(
                        "orderBy",
                        whereIn: (snapshot.data!.docs[index].data()!
                        as Map<String, dynamic>)["uid"])
                        .orderBy("publishedDate", descending: true)
                        .get(),
                    builder: (c, snap) {
                      return snap.hasData
                          ? OrderCard(
                        itemCount: snap.data!.docs.length,
                        data: snap.data!.docs,
                        orderID: snapshot.data!.docs[index].id,
                        separateQuantitiesList:
                        separateOrderItemQuantiteis(
                            (snapshot.data!.docs[index].data()
                            as Map<String, dynamic>)[
                            "productId"]),
                      )
                          : Center(
                        child: circularProgress(),
                      );
                    },
                  ),
                );

            },
          )
              : Center(
            child: circularProgress(),
          );
        },
      ),
    );
  }
}




