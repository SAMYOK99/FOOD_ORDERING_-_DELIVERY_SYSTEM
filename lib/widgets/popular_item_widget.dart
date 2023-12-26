import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:my_tiffin/models/items.dart';
import 'package:my_tiffin/widgets/popular_item.dart';
import 'package:my_tiffin/widgets/progress_bar.dart';

class PopularItems extends StatefulWidget {
  @override
  State<PopularItems> createState() => _PopularItemsState();
}

class _PopularItemsState extends State<PopularItems> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        margin: const EdgeInsets.fromLTRB(10, 10, 15, 10),
        width: double.infinity,
        child: SingleChildScrollView(
          child: StreamBuilder<QuerySnapshot>(
            stream:    FirebaseFirestore.instance
                .collection('items')
                .orderBy("publishedDate",descending: true)
                .snapshots(),
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return Center(child: circularProgress());
              } else {
                return Container(
                  width: 350,
                  height: MediaQuery.of(context).size.height * 0.4, // Adjust the height as needed
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    shrinkWrap: true,
                    children: List.generate(snapshot.data!.docs.length, (index) {
                      Items model = Items.fromJson(
                        snapshot.data!.docs[index].data()! as Map<String, dynamic>,
                      );
                      return PopularShownItems(
                        model: model,
                        context: context,
                      );
                    }),
                  ),
                );
              }
            },
          ),
        ),
      ),
    );
  }

  // Function to get the start and end timestamps for today
}
