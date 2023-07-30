import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:my_tiffin/homeScreens/item_page.dart';
import 'package:my_tiffin/models/items.dart';
import 'package:my_tiffin/widgets/progress_bar.dart';

import 'when_user_clicks_menu.dart';

class NewestItemWidget extends StatelessWidget {
  const NewestItemWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        child: Padding(padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10 ),
            child: Column(
                children: [
                  SingleChildScrollView(
                    child: Container(
                      margin: const EdgeInsets.fromLTRB(10, 10, 15, 10),
                      width: double.infinity,
                      child: SingleChildScrollView(
                        child: StreamBuilder<QuerySnapshot>(
                          stream: getTodayItems().snapshots(),
                          builder: (context, snapshot) {
                            if (!snapshot.hasData) {
                              return Center(child: circularProgress());
                            } else {
                              return  Container(
                                width: 350,
                                height: MediaQuery.of(context).size.height * 1, // Adjust the height as needed
                                child: ListView(
                                  shrinkWrap: true,
                                  children: List.generate(snapshot.data!.docs.length, (index) {
                                    Items model = Items.fromJson(
                                      snapshot.data!.docs[index].data()! as Map<String, dynamic>,
                                    );
                                    return ClicksMenu(
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
                  ),




   ],
 ),

),
    );
  }
  Query getTodayItems() {
    DateTime now = DateTime.now();
    DateTime startOfToday = DateTime(now.year, now.month, now.day);
    DateTime endOfToday = DateTime(now.year, now.month, now.day, 46, 59, 59, 999);

    Timestamp startTimestamp = Timestamp.fromDate(startOfToday);
    Timestamp endTimestamp = Timestamp.fromDate(endOfToday);

    return FirebaseFirestore.instance
        .collection('items')
        .where("publishedDate", isGreaterThanOrEqualTo: startTimestamp)
        .where("publishedDate", isLessThanOrEqualTo: endTimestamp)
        .orderBy("publishedDate", descending: true);
  }

}
