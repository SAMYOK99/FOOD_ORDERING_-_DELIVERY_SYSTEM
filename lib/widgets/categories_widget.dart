import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:my_tiffin/models/items.dart';
import 'package:my_tiffin/models/menu.dart';
import 'package:my_tiffin/widgets/category_item_design.dart';
import 'package:my_tiffin/widgets/progress_bar.dart';

class CategoriesWidget extends StatefulWidget {
  final Menu? model;
  final Items? item;

CategoriesWidget({this.model,this.item});
  @override
  State<CategoriesWidget> createState() => _CategoriesWidgetState();
}

class _CategoriesWidgetState extends State<CategoriesWidget> {

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('menus')
            .snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Center(child: circularProgress());
          } else {
            return  Container(
              width: 350,
              height: MediaQuery.of(context).size.height * 0.09, // Adjust the height as needed
              child: ListView(
                scrollDirection: Axis.horizontal,
                shrinkWrap: true,
                children: List.generate(snapshot.data!.docs.length, (index) {
                  Menu model = Menu.fromJson(
                    snapshot.data!.docs[index].data()! as Map<String, dynamic>,
                  );
                  return CategoryItem(
                    model: model,
                    context: context,
                  );
                }),
              ),
            );
          }
        },
      ),
    );
  }
}
