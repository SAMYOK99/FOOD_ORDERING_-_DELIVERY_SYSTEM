import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:my_tiffin/homeScreens/staff_main_screens/staff_item_page.dart';
import 'package:my_tiffin/models/items.dart';
import 'package:my_tiffin/models/menu.dart';
import 'package:provider/provider.dart';

class ClicksMenu extends StatefulWidget {
  Items? model;
  BuildContext? context;

  ClicksMenu({this.model, this.context});

  @override
  State<ClicksMenu> createState() => _ClicksMenuState();
}

class _ClicksMenuState extends State<ClicksMenu> {

  // deleteMenu(String itemUID){
  //   Menu selectedMenu = Provider.of<Menu>(context, listen: false);
  //   String? selectedTab = selectedMenu.selectedTab;
  //   FirebaseFirestore.instance
  //       .collection("menus")
  //       .doc(selectedTab)
  //       .collection("items")
  //       .doc(itemUID)
  //       .delete();
  //   Fluttertoast.showToast(msg: "Item Deleted");
  //
  // }
  @override
  Widget build(BuildContext context) {
    return Padding(padding: const EdgeInsets.symmetric(vertical: 10),
      child: Container(
        width: MediaQuery
            .of(context)
            .size
            .width * 0.9,
        height: MediaQuery.of(context).size.height*0.22,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 3,
              blurRadius: 10,
              offset: const Offset(0, 3),

            )
          ],
        ),
        child: Column(
            children: [
              Row(
                children: [
                  InkWell(
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(
                          builder: (c) => const StaffItemPage()));
                    },
                    child: Container(
                      margin: EdgeInsets.fromLTRB(0, 8, 0, 0),
                      alignment: Alignment.bottomCenter,
                      child: Image.network(
                        widget.model!.thumbnailUrl!,
                        height: 120,
                        width: 150,
                      ),
                      // Image.asset(
                      //   "images/burger.png",
                      //   height: 120,
                      //   width: 150,
                      // ),
                    ),
                  ),
                  Container(
                    width: 190,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Text(
                          widget.model!.itemTitle!,
                          style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                          ),),
                        Text(
                          widget.model!.shortInfo!,
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),),
                        RatingBar.builder(
                          initialRating: 4,
                          minRating: 1,
                          direction: Axis.horizontal,
                          itemCount: 5,
                          itemSize: 18,
                          itemPadding: const EdgeInsets.symmetric(
                              horizontal: 4),
                          itemBuilder: (context, _) =>
                          const Icon(
                            Icons.star,
                            color: Colors.green,

                          ),
                          onRatingUpdate: (index) {},),
                        Text(
                          "\$"+widget.model!.itemPrice!,
                          style: TextStyle(
                            fontSize: 17,
                            color: Colors.green,
                            fontWeight: FontWeight.bold,
                          ),),
                      ],
                    ),
                  ),

                ],
              ),
              const Padding(
                padding: EdgeInsets.fromLTRB(20, 0, 20, 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Icon(Icons.favorite_border,
                      color: Colors.green,
                      size: 26,
                    ),
                    Icon(
                      CupertinoIcons.cart,
                      color: Colors.green,
                      size: 26,
                    ),
                  ],
                ),
              ),

            ]
        ),
      ),
    );

  }
}
