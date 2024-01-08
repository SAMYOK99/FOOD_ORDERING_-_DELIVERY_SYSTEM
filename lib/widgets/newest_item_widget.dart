import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_tiffin/models/items.dart';
import 'package:my_tiffin/widgets/progress_bar.dart';

import 'when_user_clicks_menu.dart';

class NewestItemWidget extends StatelessWidget {
  const NewestItemWidget({Key? key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: getItemsFromYesterdayToTomorrow().snapshots(),
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

  Query getItemsFromYesterdayToTomorrow() {
    DateTime now = DateTime.now();
    DateTime startOfYesterday = DateTime(now.year, now.month, now.day - 1);
    DateTime endOfTomorrow = DateTime(now.year, now.month, now.day + 2, 0, 0, 0, 0);

    Timestamp startTimestamp = Timestamp.fromDate(startOfYesterday);
    Timestamp endTimestamp = Timestamp.fromDate(endOfTomorrow);

    return FirebaseFirestore.instance
        .collection('items')
        .where("publishedDate", isGreaterThanOrEqualTo: startTimestamp)
        .where("publishedDate", isLessThan: endTimestamp)
        .orderBy("publishedDate", descending: true);
  }
}
