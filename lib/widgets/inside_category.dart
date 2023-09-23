import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:my_tiffin/models/items.dart';
import 'package:my_tiffin/models/menu.dart';
import 'package:my_tiffin/widgets/progress_bar.dart';
import 'package:my_tiffin/widgets/when_user_clicks_menu.dart';

class InsideCategory extends StatefulWidget {
  final Menu? model;
InsideCategory({this.model});
  @override
  State<InsideCategory> createState() => _InsideCategoryState();
}

class _InsideCategoryState extends State<InsideCategory> {

  @override
  Widget build(BuildContext context) {
      return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text("Items of"+" "+widget.model!.menuTitle!),
          titleTextStyle: const TextStyle(
            color: Colors.black,
            fontSize: 22,
            fontWeight: FontWeight.bold,
          ),
          iconTheme: IconThemeData(
              color: Colors.green
          ),
          backgroundColor: Colors.white,
          elevation: 0.0,
        ),
        body: SingleChildScrollView(
          child: Container(
            margin: const EdgeInsets.fromLTRB(10, 10, 15, 10),
            width: double.infinity,
            child: SingleChildScrollView(
              child: StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance
                    .collection('menus')
                    .doc(widget.model!.menuId) // Use the selectedTab passed as a parameter
                    .collection('items')
                    .snapshots(),
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
      );
    }

     }

