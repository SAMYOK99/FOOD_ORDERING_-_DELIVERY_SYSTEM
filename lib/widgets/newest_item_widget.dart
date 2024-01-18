import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_tiffin/models/items.dart';
import 'package:my_tiffin/widgets/progress_bar.dart';

import 'when_user_clicks_menu.dart';

class NewestItemWidget extends StatelessWidget {
  const NewestItemWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: getItemsFromPastThreeDays().limit(6).snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return Center(child: circularProgress());
        } else {
          return ListView.builder(
            itemCount: snapshot.data!.docs.length,
            itemBuilder: (context, index) {
              Items model = Items.fromJson(
                snapshot.data!.docs[index].data()! as Map<String, dynamic>,
              );
              return ClicksMenu(
                model: model,
                context: context,
              );
            },
          );
        }
      },
    );
  }

  Query getItemsFromPastThreeDays() {
    DateTime now = DateTime.now();
    DateTime startOfPastThreeDays = DateTime(now.year, now.month, now.day - 3);
    DateTime endOfToday = DateTime(now.year, now.month, now.day + 1, 0, 0, 0, 0);

    Timestamp startTimestamp = Timestamp.fromDate(startOfPastThreeDays);
    Timestamp endTimestamp = Timestamp.fromDate(endOfToday);

    return FirebaseFirestore.instance
        .collection('items')
        .where("publishedDate", isGreaterThanOrEqualTo: startTimestamp)
        .where("publishedDate", isLessThan: endTimestamp)
        .orderBy("publishedDate", descending: true);
  }
}
