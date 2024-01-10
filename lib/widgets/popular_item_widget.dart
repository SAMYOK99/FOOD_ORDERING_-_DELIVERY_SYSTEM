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
    return  StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
      stream: FirebaseFirestore.instance.collection('views').snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return Center(child: circularProgress());
        } else {
          // Create a map to count the views for each item
          Map<String, int> viewCounts = {};

          // Loop through each view and count occurrences of each item ID
          snapshot.data!.docs.forEach((DocumentSnapshot<Map<String, dynamic>> doc) {
            String itemId = doc.data()!['item_id'];
            viewCounts[itemId] = (viewCounts[itemId] ?? 0) + 1;
          });

          // Sort items based on view counts in descending order
          List<String> popularItemIds = viewCounts.keys.toList()
            ..sort((a, b) => viewCounts[b]!.compareTo(viewCounts[a]!));

          return Container(
            margin: const EdgeInsets.fromLTRB(10, 10, 15, 10),
            width: double.infinity,
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: popularItemIds.map((itemId) {
                  // Fetch item details based on the popular item IDs
                  return FutureBuilder<DocumentSnapshot<Map<String, dynamic>>>(
                    future: FirebaseFirestore.instance.collection('items').doc(itemId).get(),
                    builder: (context, itemSnapshot) {
                      if (itemSnapshot.connectionState == ConnectionState.waiting) {
                        return SizedBox(); // Placeholder while fetching item details
                      } else if (itemSnapshot.hasError || !itemSnapshot.hasData) {
                        return SizedBox(); // Handle error or no data
                      } else {
                        Items model = Items.fromJson(itemSnapshot.data!.data()! as Map<String, dynamic>);
                        return PopularShownItems(
                          model: model,
                          context: context,
                        );
                      }
                    },
                  );
                }).toList(),
              ),
            ),
          );
        }
      },
    );


  }

}
